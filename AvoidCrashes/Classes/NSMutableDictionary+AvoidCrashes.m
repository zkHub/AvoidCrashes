//
//  NSMutableDictionary+AvoidCrashes.m
//  AvoidCrashes
//
//  Created by cu on 2024/1/5.
//

#import "NSMutableDictionary+AvoidCrashes.h"
#import "NSObject+AvoidCrashes.h"

@implementation NSMutableDictionary (AvoidCrashes)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class __NSDictionaryM = NSClassFromString(@"__NSDictionaryM");
        
        swizzleInstanceMethod(__NSDictionaryM, @selector(setObject:forKey:), @selector(ac_setObject:forKey:));
        swizzleInstanceMethod(__NSDictionaryM, @selector(setObject:forKeyedSubscript:), @selector(ac_setObject:forKeyedSubscript:));
        
        swizzleInstanceMethod(__NSDictionaryM, @selector(removeObjectForKey:), @selector(ac_removeObjectForKey:));

    });
}

//MARK: - -[__NSDictionaryM setObject:forKey:]: object cannot be nil
- (void)ac_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    @try {
        [self ac_setObject:anObject forKey:aKey];
    } @catch (NSException *exception) {
        [AvoidCrashesLog logCrashInfoWithException:exception];
    } @finally {
        
    }
}

//MARK: - -[__NSDictionaryM setObject:forKeyedSubscript:]: key cannot be nil
- (void)ac_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    @try {
        [self ac_setObject:obj forKeyedSubscript:key];
    } @catch (NSException *exception) {
        [AvoidCrashesLog logCrashInfoWithException:exception];
    } @finally {
        
    }
}

//MARK: - -[__NSDictionaryM removeObjectForKey:]: key cannot be nil
- (void)ac_removeObjectForKey:(id)aKey {
    @try {
        [self ac_removeObjectForKey:aKey];
    } @catch (NSException *exception) {
        [AvoidCrashesLog logCrashInfoWithException:exception];
    } @finally {
        
    }
}

@end
