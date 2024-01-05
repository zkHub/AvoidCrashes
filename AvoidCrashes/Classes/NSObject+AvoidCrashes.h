//
//  NSObject+AvoidCrashes.h
//  AvoidCrashes
//
//  Created by cu on 2024/1/2.
//

#import <Foundation/Foundation.h>
#import "AvoidCrashesLog.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (AvoidCrashes)


/// 交换类方法的C实现
/// @param originalSelector 原始方法的 SEL
/// @param swizzledSelector 交换方法的 SEL
void swizzleClassMethod(Class class, SEL originalSelector, SEL swizzledSelector);

/// 交换实例方法的C实现
/// @param originalSelector 原始方法的 SEL
/// @param swizzledSelector 交换方法的 SEL
void swizzleInstanceMethod(Class class, SEL originalSelector, SEL swizzledSelector);


/// 交换类方法的实现
/// @param originalSelector 原始方法的 SEL
/// @param swizzledSelector 交换方法的 SEL
+ (void)ac_swizzleClassMethod:(SEL)originalSelector swizzledMethod:(SEL)swizzledSelector;

/// 交换实例方法的实现
/// @param originalSelector 原始方法的 SEL
/// @param swizzledSelector 交换方法的 SEL
+ (void)ac_swizzleInstanceMethod:(SEL)originalSelector swizzledMethod:(SEL)swizzledSelector;

+ (void)ac_avoidCrashesUnrecognizedSelector;

@end

NS_ASSUME_NONNULL_END
