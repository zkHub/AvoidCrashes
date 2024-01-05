//
//  ACViewController.m
//  AvoidCrashes
//
//  Created by zhangke on 12/29/2023.
//  Copyright (c) 2023 zhangke. All rights reserved.
//

#import "ACViewController.h"
#import "AvoidCrashes.h"

@interface ACViewController ()<AvoidCrashesHandle>

@end

@implementation ACViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [AvoidCrashes configAvoidCrashesHandler:self];
    
//    NSString *a = [NSNumber numberWithInt:1];
//    NSInteger length = a.length;
    
    NSNumber *a1 = nil;
    NSArray *__NSArrayI = @[a1];
    __NSArrayI = [NSArray arrayWithObjects:&__NSArrayI count:3];
    
//    NSArray *__NSArray0 = @[];
//    NSArray *__NSSingleObjectArrayI = @[@(1)];
//    __NSArrayI = @[@(1), @(2)];
    NSMutableArray *__NSArrayM = [NSMutableArray array];
    
    [__NSArrayM addObject:a1];
    [__NSArrayM insertObject:@(1) atIndex:3];
    __NSArrayM[4] = @(2);
    
//    [__NSArray0 objectAtIndex:3];
//    [__NSSingleObjectArrayI objectAtIndex:3];
//    [__NSArrayI objectAtIndex:3];
//    [__NSArrayM objectAtIndex:3];
//
//    __NSArray0[3];
//    __NSSingleObjectArrayI[3];
//    __NSArrayI[3];
//    __NSArrayM[3];
//    
//    [__NSArray0 objectsAtIndexes:[NSIndexSet indexSetWithIndex:3]];
//    [__NSSingleObjectArrayI objectsAtIndexes:[NSIndexSet indexSetWithIndex:3]];
//    [__NSArrayI objectsAtIndexes:[NSIndexSet indexSetWithIndex:3]];
//    [__NSArrayM objectsAtIndexes:[NSIndexSet indexSetWithIndex:3]];

}


- (void)handleCrashInformation:(NSString *)info {
    NSLog(@"1");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
