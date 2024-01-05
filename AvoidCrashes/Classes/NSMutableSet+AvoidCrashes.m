//
//  NSMutableSet+AvoidCrashes.m
//  AvoidCrashes
//
//  Created by cu on 2024/1/5.
//

#import "NSMutableSet+AvoidCrashes.h"
#import "NSObject+AvoidCrashes.h"

@implementation NSMutableSet (AvoidCrashes)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class __NSSetM = NSClassFromString(@"__NSSetM");
        
        swizzleInstanceMethod(__NSSetM, @selector(addObject:), @selector(ac_addObject:));
        
        swizzleInstanceMethod(__NSSetM, @selector(removeObject:), @selector(ac_removeObject:));
    });
}

//MARK: - -[__NSSetM addObject:]: object cannot be nil
- (void)ac_addObject:(id)object {
    @try {
        [self ac_addObject:object];
    } @catch (NSException *exception) {
        [AvoidCrashesLog logCrashInfoWithException:exception];
    } @finally {
        
    }
}

//MARK: - -[__NSSetM removeObject:]: object cannot be nil
- (void)ac_removeObject:(id)object {
    @try {
        [self ac_removeObject:object];
    } @catch (NSException *exception) {
        [AvoidCrashesLog logCrashInfoWithException:exception];
    } @finally {
        
    }
}

@end
