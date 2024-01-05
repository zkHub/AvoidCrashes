//
//  NSArray+AvoidCrashes.m
//  AvoidCrashes
//
//  Created by cu on 2024/1/4.
//

#import "NSArray+AvoidCrashes.h"
#import "NSObject+AvoidCrashes.h"
#import "AvoidCrashesLog.h"

@implementation NSArray (AvoidCrashes)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class __NSArray0 = NSClassFromString(@"__NSArray0");
        Class __NSArrayI = NSClassFromString(@"__NSArrayI");
        Class __NSSingleObjectArrayI = NSClassFromString(@"__NSSingleObjectArrayI");
        Class __NSPlaceholderArray = NSClassFromString(@"__NSPlaceholderArray");
        
        swizzleInstanceMethod(__NSPlaceholderArray, @selector(initWithObjects:count:), @selector(ac_initWithObjects:count:));

        swizzleInstanceMethod(__NSArray0, @selector(objectAtIndex:), @selector(ac___NSArray0ObjectAtIndex:));
        swizzleInstanceMethod(__NSArrayI, @selector(objectAtIndex:), @selector(ac___NSArrayIObjectAtIndex:));
        swizzleInstanceMethod(__NSSingleObjectArrayI, @selector(objectAtIndex:), @selector(ac___NSSingleObjectArrayIObjectAtIndex:));
        
        swizzleInstanceMethod(self.class, @selector(objectAtIndexedSubscript:), @selector(ac_objectAtIndexedSubscript:));
        swizzleInstanceMethod(__NSArrayI, @selector(objectAtIndexedSubscript:), @selector(ac___NSArrayIObjectAtIndexedSubscript:));
        
        swizzleInstanceMethod(self.class, @selector(objectsAtIndexes:), @selector(ac_objectsAtIndexes:));
        
    });
}


- (instancetype)ac_initWithObjects:(id  _Nonnull const[])objects count:(NSUInteger)cnt {
    id instance = nil;
    @try {
        instance = [self ac_initWithObjects:objects count:cnt];
    } @catch (NSException *exception) {
        [AvoidCrashesLog logCrashInfoWithException:exception];
        
        // 把为nil的数据去掉,然后初始化数组
        NSInteger newObjsIndex = 0;
        id  _Nonnull __unsafe_unretained newObjects[cnt];
        
        for (int i = 0; i < cnt; i++) {
            if (objects[i] != nil) {
                newObjects[newObjsIndex] = objects[i];
                newObjsIndex++;
            }
        }
        instance = [self ac_initWithObjects:newObjects count:newObjsIndex];
    } @finally {
        return instance;
    }
}

//MARK: - objectAtIndex:
- (id)ac___NSArray0ObjectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        return [self ac___NSArray0ObjectAtIndex:index];
    }
    [AvoidCrashesLog logCrashInfoWithReason:[NSString stringWithFormat:@"__NSArray0 objectAtIndex:%lu, count:%lu", index, self.count]];
    return nil;
}

- (id)ac___NSArrayIObjectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        return [self ac___NSArrayIObjectAtIndex:index];
    }
    [AvoidCrashesLog logCrashInfoWithReason:[NSString stringWithFormat:@"__NSArrayI objectAtIndex:%lu, count:%lu", index, self.count]];
    return nil;
}

- (id)ac___NSSingleObjectArrayIObjectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        return [self ac___NSSingleObjectArrayIObjectAtIndex:index];
    }
    [AvoidCrashesLog logCrashInfoWithReason:[NSString stringWithFormat:@"__NSSingleObjectArrayI objectAtIndex:%lu, count:%lu", index, self.count]];
    return nil;
}


//MARK: - objectAtIndexedSubscript:
- (id)ac___NSArrayIObjectAtIndexedSubscript:(NSUInteger)idx {
    if (idx < self.count) {
        return [self ac___NSArrayIObjectAtIndexedSubscript:idx];
    }
    [AvoidCrashesLog logCrashInfoWithReason:[NSString stringWithFormat:@"__NSArrayI objectAtIndexedSubscript:%lu, count:%lu", idx, self.count]];
    return nil;
}

- (id)ac_objectAtIndexedSubscript:(NSUInteger)idx {
    if (idx < self.count) {
        return [self ac_objectAtIndexedSubscript:idx];
    }
    [AvoidCrashesLog logCrashInfoWithReason:[NSString stringWithFormat:@"NSArray objectAtIndexedSubscript:%lu, count:%lu", idx, self.count]];
    return nil;
}

//MARK: - objectsAtIndexes
- (NSArray *)ac_objectsAtIndexes:(NSIndexSet *)indexes {
    NSArray *returnArray = nil;
    @try {
        returnArray = [self ac_objectsAtIndexes:indexes];
    } @catch (NSException *exception) {
        [AvoidCrashesLog logCrashInfoWithException:exception];
    } @finally {
        return returnArray;
    }
}

@end
