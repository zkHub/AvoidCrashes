//
//  AvoidCrashes.h
//  AvoidCrashes
//
//  Created by cu on 2023/12/29.
//

#import <Foundation/Foundation.h>
#import "AvoidCrashesHandle.h"



NS_ASSUME_NONNULL_BEGIN


@interface AvoidCrashes : NSObject

+ (void)configAvoidCrashesHandler:(id<AvoidCrashesHandle>)handler;

@end

NS_ASSUME_NONNULL_END
