//
//  NSDictionary+AvoidCrashes.m
//  AvoidCrashes
//
//  Created by cu on 2024/1/5.
//

#import "NSDictionary+AvoidCrashes.h"
#import "NSObject+AvoidCrashes.h"

@implementation NSDictionary (AvoidCrashes)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class __NSPlaceholderDictionary = NSClassFromString(@"__NSPlaceholderDictionary");
        swizzleInstanceMethod(__NSPlaceholderDictionary, @selector(initWithObjects:forKeys:count:), @selector(ac_initWithObjects:forKeys:count:));
    });
}

//MARK: - -[__NSPlaceholderDictionary initWithObjects:forKeys:count:]: attempt to insert nil object from objects[1]
// @{}
// +[NSDictionary dictionaryWithObjects:forKeys:count:]
// -[__NSPlaceholderDictionary initWithObjects:forKeys:count:]
- (instancetype)ac_initWithObjects:(id  _Nonnull const[])objects forKeys:(id<NSCopying>  _Nonnull const[])keys count:(NSUInteger)cnt {
    id instance = nil;
    @try {
        instance = [self ac_initWithObjects:objects forKeys:keys count:cnt];
    } @catch (NSException *exception) {
        [AvoidCrashesLog logCrashInfoWithException:exception];
        //处理错误的数据，然后重新初始化一个字典
        NSUInteger index = 0;
        id  _Nonnull __unsafe_unretained newObjects[cnt];
        id  _Nonnull __unsafe_unretained newkeys[cnt];
        
        for (int i = 0; i < cnt; i++) {
            if (objects[i] && keys[i]) {
                newObjects[index] = objects[i];
                newkeys[index] = keys[i];
                index++;
            }
        }
        instance = [self ac_initWithObjects:objects forKeys:keys count:index];
    } @finally {
        return instance;
    }
}


@end
