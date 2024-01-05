//
//  NSMutableArray+AvoidCrashes.m
//  AvoidCrashes
//
//  Created by cu on 2024/1/4.
//

#import "NSMutableArray+AvoidCrashes.h"
#import "NSObject+AvoidCrashes.h"
#import "AvoidCrashesLog.h"

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

//MARK: - setObject:atIndexedSubscript:
- (void)ac_setObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
    @try {
        [self ac_setObject:obj atIndexedSubscript:idx];
    } @catch (NSException *exception) {
        [AvoidCrashesLog logCrashInfoWithException:exception];
    } @finally {
        
    }
}

//MARK: - objectAtIndex:
- (id)ac_objectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        return [self ac_objectAtIndex:index];
    }
    [AvoidCrashesLog logCrashInfoWithReason:[NSString stringWithFormat:@"__NSArrayM objectAtIndex:%lu, count:%lu", index, self.count]];
    return nil;
}

//MARK: - objectAtIndexedSubscript:
- (id)ac_objectAtIndexedSubscript:(NSUInteger)idx {
    if (idx < self.count) {
        return [self ac_objectAtIndexedSubscript:idx];
    }
    [AvoidCrashesLog logCrashInfoWithReason:[NSString stringWithFormat:@"__NSArrayM objectAtIndexedSubscript:%lu, count:%lu", idx, self.count]];
    return nil;
}

//MARK: - removeObjectAtIndex:
- (void)ac_removeObjectAtIndex:(NSUInteger)index {
    @try {
        [self ac_removeObjectAtIndex:index];
    } @catch (NSException *exception) {
        [AvoidCrashesLog logCrashInfoWithException:exception];
    } @finally {
        
    }
}


@end
