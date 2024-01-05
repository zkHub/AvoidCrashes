//
//  AvoidCrashesLog.m
//  AvoidCrashes
//
//  Created by cu on 2024/1/4.
//

#import "AvoidCrashesLog.h"

@implementation AvoidCrashesLog

+ (instancetype)shareInstance {
    static AvoidCrashesLog *ac = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ac = [[AvoidCrashesLog alloc] init];
    });
    return ac;
}

+ (void)logCrashInfoWithException:(NSException *)exception {
    
#ifdef DEBUG
    // 获取crash发生的主要信息
    NSString *mainCallStackSymbolMsg = [AvoidCrashesLog getMainCallStackSymbolMessageWithCallStackSymbols:exception.callStackSymbols];
    if (mainCallStackSymbolMsg == nil) {
        mainCallStackSymbolMsg = [NSString stringWithFormat:@"%@", exception.callStackSymbols];
    }
    NSString *crashInfo = [NSString stringWithFormat:@"\n\n%@\n\n%@\n%@\n\nError Place:\n%@\n\n%@\n\n", AvoidCrashesLogSeparator, exception.name, exception.reason, mainCallStackSymbolMsg, AvoidCrashesLogSeparator];
    AvoidCrashesLog(@"%@", crashInfo);
#endif
    
    // 可以把崩溃信息回调给外部
    if ([AvoidCrashesLog.shareInstance.handler respondsToSelector:@selector(avoidCrashesHandleException:)]) {
        [AvoidCrashesLog.shareInstance.handler avoidCrashesHandleException:exception];
    }
}

+ (void)logCrashInfoWithReason:(NSString *)reason {
    NSArray *callStackSymbols = [NSThread callStackSymbols];
    // 获取crash发生的主要信息
    NSString *mainCallStackSymbolMsg = [NSString stringWithFormat:@"%@", callStackSymbols];
#ifdef DEBUG
    mainCallStackSymbolMsg = [AvoidCrashesLog getMainCallStackSymbolMessageWithCallStackSymbols:callStackSymbols];
    if (mainCallStackSymbolMsg == nil) {
        mainCallStackSymbolMsg = [NSString stringWithFormat:@"%@", callStackSymbols];
    }
#endif
    NSString *crashInfo = [NSString stringWithFormat:@"\n\n%@\n\n%@\nError Place:\n%@\n\n%@\n\n", AvoidCrashesLogSeparator, reason, mainCallStackSymbolMsg, AvoidCrashesLogSeparator];
    AvoidCrashesLog(@"%@", crashInfo);
    // 可以把崩溃信息回调给外部
    if ([AvoidCrashesLog.shareInstance.handler respondsToSelector:@selector(avoidCrashesHandleCrashInformation:)]) {
        [AvoidCrashesLog.shareInstance.handler avoidCrashesHandleCrashInformation:[NSString stringWithFormat:@"%@", crashInfo]];
    }
}


/// 通过栈信息获取崩溃发生的主要节点
/// - Parameter callStackSymbols: 栈信息
+ (NSString *)getMainCallStackSymbolMessageWithCallStackSymbols:(NSArray<NSString *> *)callStackSymbols {
    __block NSString *mainCallStackSymbolMsg = nil;
    // 匹配出来的格式为 +[类名 方法名] 或者 -[类名 方法名]
    NSString *regularExpStr = @"[-\\+]\\[.+\\]";
    NSRegularExpression *regularExp = [[NSRegularExpression alloc] initWithPattern:regularExpStr options:NSRegularExpressionCaseInsensitive error:nil];
    
    for (int index = 2; index < callStackSymbols.count; index++) {
        NSString *callStackSymbol = callStackSymbols[index];
        [regularExp enumerateMatchesInString:callStackSymbol options:NSMatchingReportProgress range:NSMakeRange(0, callStackSymbol.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            if (result) {
                NSString* tempCallStackSymbolMsg = [callStackSymbol substringWithRange:result.range];
                //get className
                NSString *className = [tempCallStackSymbolMsg componentsSeparatedByString:@" "].firstObject;
                className = [className componentsSeparatedByString:@"["].lastObject;
                NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(className)];
                //filter category and system class
                if (![className hasSuffix:@")"] && bundle == [NSBundle mainBundle]) {
                    mainCallStackSymbolMsg = callStackSymbol;
                }
                *stop = YES;
            }
        }];
        if (mainCallStackSymbolMsg.length) {
            break;
        }
    }
    return mainCallStackSymbolMsg;
}



@end
