//
//  AvoidCrashesLog.h
//  AvoidCrashes
//
//  Created by cu on 2024/1/4.
//

#import <Foundation/Foundation.h>
#import "AvoidCrashesHandle.h"


#ifdef DEBUG
#define AvoidCrashesLog(...) NSLog(@"%@",[NSString stringWithFormat:__VA_ARGS__])
#else
#define AvoidCrashesLog(...)
#endif

#define AvoidCrashesLogSeparator   @"========================AvoidCrashes Log========================"


NS_ASSUME_NONNULL_BEGIN

@interface AvoidCrashesLog : NSObject

@property (nonatomic, weak) id<AvoidCrashesHandle> handler;

+ (instancetype)shareInstance;


/// 打印崩溃信息
/// - Parameter exception: 错误
+ (void)logCrashInfoWithException:(NSException *)exception;


/// 打印自定义崩溃信息
/// - Parameter reason: 自定义信息
+ (void)logCrashInfoWithReason:(NSString *)reason;

@end

NS_ASSUME_NONNULL_END
