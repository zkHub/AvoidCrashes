//
//  NSSet+AovidCrashes.m
//  AvoidCrashes
//
//  Created by cu on 2024/1/5.
//

#import "NSSet+AovidCrashes.h"
#import "NSObject+AvoidCrashes.h"

@implementation NSSet (AovidCrashes)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class __NSPlaceholderSet = NSClassFromString(@"__NSPlaceholderSet");
        
        swizzleInstanceMethod(__NSPlaceholderSet, @selector(initWithObjects:count:), @selector(ac_initWithObjects:count:));
    });
}

// -[__NSPlaceholderSet initWithObjects:count:]: attempt to insert nil object from objects[0]
// +[NSSet setWithObject:]
// -[__NSPlaceholderSet initWithObjects:count:]
- (instancetype)ac_initWithObjects:(id  _Nonnull const[])objects count:(NSUInteger)cnt {
    id instance = nil;
    @try {
        instance = [self ac_initWithObjects:objects count:cnt];
    } @catch (NSException *exception) {
        [AvoidCrashesLog logCrashInfoWithException:exception];
        
        // 把为nil的数据去掉,然后初始化
        NSInteger newIndex = 0;
        id  _Nonnull __unsafe_unretained newObjects[cnt];
        
        for (int i = 0; i < cnt; i++) {
            if (objects[i] != nil) {
                newObjects[newIndex] = objects[i];
                newIndex++;
            }
        }
        instance = [self ac_initWithObjects:newObjects count:newIndex];
    } @finally {
        return instance;
    }
}

@end
