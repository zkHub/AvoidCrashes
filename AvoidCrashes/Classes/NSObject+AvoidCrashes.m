//
//  NSObject+AvoidCrashes.m
//  AvoidCrashes
//
//  Created by cu on 2024/1/2.
//

#import "NSObject+AvoidCrashes.h"
#import <objc/runtime.h>
#import "AvoidCrashesLog.h"

@implementation NSObject (AvoidCrashes)


//MARK: - method swizzling

// 交换类方法的实现 C 函数
void swizzleClassMethod(Class class, SEL originalSelector, SEL swizzledSelector) {

    Method originalMethod = class_getClassMethod(class, originalSelector);
    Method swizzledMethod = class_getClassMethod(class, swizzledSelector);

    BOOL didAddMethod = class_addMethod(class,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));

    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

// 交换实例方法的实现 C 函数
void swizzleInstanceMethod(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

    BOOL didAddMethod = class_addMethod(class,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));

    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

// 交换类方法的实现
+ (void)ac_swizzleClassMethod:(SEL)originalSelector swizzledMethod:(SEL)swizzledSelector {
    swizzleClassMethod(self.class, originalSelector, swizzledSelector);
}

// 交换实例方法的实现
+ (void)ac_swizzleInstanceMethod:(SEL)originalSelector swizzledMethod:(SEL)swizzledSelector {
    swizzleInstanceMethod(self.class, originalSelector, swizzledSelector);
}


//MARK: - unrecognized selector sent to instance/class
+ (void)ac_avoidCrashesUnrecognizedSelector {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // hook 消息转发的最后一步
        // class mathod
        swizzleClassMethod(self.class, @selector(methodSignatureForSelector:), @selector(ac_methodSignatureForSelector:));
        swizzleClassMethod(self.class, @selector(forwardInvocation:), @selector(ac_forwardInvocation:));
        // instance mathod
        swizzleInstanceMethod(self.class, @selector(methodSignatureForSelector:), @selector(ac_methodSignatureForSelector:));
        swizzleInstanceMethod(self.class, @selector(forwardInvocation:), @selector(ac_forwardInvocation:));
    });
}

// class method
+ (NSMethodSignature *)ac_methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *ms = [self ac_methodSignatureForSelector:aSelector];
    if (!ms) {
        ms = [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return ms;
}

+ (void)ac_forwardInvocation:(NSInvocation *)anInvocation {
    @try {
        [self ac_forwardInvocation:anInvocation];
    } @catch (NSException *exception) {
        [AvoidCrashesLog logCrashInfoWithException:exception];
    } @finally {
        
    }
}

// instance method
- (NSMethodSignature *)ac_methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *ms = [self ac_methodSignatureForSelector:aSelector];
    if (!ms) {
        ms = [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return ms;
}

- (void)ac_forwardInvocation:(NSInvocation *)anInvocation {
    @try {
        [self ac_forwardInvocation:anInvocation];
    } @catch (NSException *exception) {
        [AvoidCrashesLog logCrashInfoWithException:exception];
    } @finally {
        
    }
}

@end
