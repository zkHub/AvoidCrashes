//
//  NSMutableArray+AvoidCrashes.m
//  AvoidCrashes
//
//  Created by cu on 2024/1/4.
//

#import "NSMutableArray+AvoidCrashes.h"
#import "NSObject+AvoidCrashes.h"

@implementation NSMutableArray (AvoidCrashes)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class __NSArrayM = NSClassFromString(@"__NSArrayM");
        
        swizzleInstanceMethod(__NSArrayM, @selector(insertObject:atIndex:), @selector(ac_insertObject:atIndex:));
        swizzleInstanceMethod(__NSArrayM, @selector(setObject:atIndexedSubscript:), @selector(ac_setObject:atIndexedSubscript:));

        swizzleInstanceMethod(__NSArrayM, @selector(objectAtIndex:), @selector(ac_objectAtIndex:));
        swizzleInstanceMethod(__NSArrayM, @selector(objectAtIndexedSubscript:), @selector(ac_objectAtIndexedSubscript:));
        
        swizzleInstanceMethod(__NSArrayM, @selector(removeObjectAtIndex:), @selector(ac_removeObjectAtIndex:));
        
    });
}

//MARK: - insertObject:atIndex:
- (void)ac_insertObject:(id)anObject atIndex:(NSUInteger)index {
    @try {
        [self ac_insertObject:anObject atIndex:index];
    } @catch (NSException *exception) {
        [AvoidCrashesLog logCrashInfoWithException:exception];
    } @finally {
        
    }
}

//MARK: - -[__NSArrayM setObject:atIndexedSubscript:]: index 4 beyond bounds for empty array
- (void)ac_setObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
    @try {
        [self ac_setObject:obj atIndexedSubscript:idx];
    } @catch (NSException *exception) {
        [AvoidCrashesLog logCrashInfoWithException:exception];
    } @finally {
        
    }
}

//MARK: - -[__NSArrayM objectAtIndex:]: index 3 beyond bounds for empty array
- (id)ac_objectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        return [self ac_objectAtIndex:index];
    }
    [AvoidCrashesLog logCrashInfoWithReason:[NSString stringWithFormat:@"__NSArrayM objectAtIndex:%lu, count:%lu", index, self.count]];
    return nil;
}

//MARK: - -[__NSArrayM objectAtIndexedSubscript:]: index 3 beyond bounds for empty array
- (id)ac_objectAtIndexedSubscript:(NSUInteger)idx {
    if (idx < self.count) {
        return [self ac_objectAtIndexedSubscript:idx];
    }
    [AvoidCrashesLog logCrashInfoWithReason:[NSString stringWithFormat:@"__NSArrayM objectAtIndexedSubscript:%lu, count:%lu", idx, self.count]];
    return nil;
}

//MARK: - removeObjectAtIndex:
- (void)ac_removeObjectAtIndex:(NSUInteger)index {
    [self ac_removeObjectAtIndex:index];
    return;
    @try {
        [self ac_removeObjectAtIndex:index];
    } @catch (NSException *exception) {
        [AvoidCrashesLog logCrashInfoWithException:exception];
    } @finally {
        
    }
}


@end
