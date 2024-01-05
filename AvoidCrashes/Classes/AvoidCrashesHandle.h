//
//  AvoidCrashesHandle.h
//  AvoidCrashes
//
//  Created by cu on 2024/1/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AvoidCrashesHandle <NSObject>


/// 把错误信息回调给外部
/// - Parameter info: 信息
- (void)avoidCrashesHandleCrashInformation:(NSString *)info;


/// 把错误信息回调给外部
/// - Parameter exception: 错误
- (void)avoidCrashesHandleException:(NSException *)exception;

@end

NS_ASSUME_NONNULL_END
