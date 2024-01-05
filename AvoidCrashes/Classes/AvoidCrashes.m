//
//  AvoidCrashes.m
//  AvoidCrashes
//
//  Created by cu on 2023/12/29.
//

#import "AvoidCrashes.h"
#import "AvoidCrashesLog.h"
#import "NSObject+AvoidCrashes.h"
#import "NSArray+AvoidCrashes.h"
#import "NSMutableArray+AvoidCrashes.h"

@implementation AvoidCrashes

+ (void)configAvoidCrashesHandler:(id<AvoidCrashesHandle>)handler {
    AvoidCrashesLog.shareInstance.handler = handler;
    [self configAvoidCrashes];
}

+ (void)configAvoidCrashes {
    [NSObject ac_avoidCrashesUnrecognizedSelector];
}


@end
