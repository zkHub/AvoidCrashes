//
//  AvoidCrashesProtocol.h
//  AvoidCrashes
//
//  Created by cu on 2024/1/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AvoidCrashesProtocol <NSObject>

@required
+ (void)ac_avoidCrashesMethodSwizzling;

@end

NS_ASSUME_NONNULL_END
