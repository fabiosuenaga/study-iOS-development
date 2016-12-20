//
//  MathOperationsViewController.m
//  Jumblify
//
//  Created by Fabio Suenaga on 16/12/16.
//  Copyright © 2016 Tuts+. All rights reserved.
//

#import "MathOperationsViewController.h"
#import <math.h>

@interface MathOperationsViewController ()

@end

@implementation MathOperationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (Boolean)isOddValue:(int)number {
    if ((fmod, number, 2) == 0) {
        return YES;
    }
    return NO;
}

- (NSString *)castIntValue:(int)number {
    return [NSString stringWithFormat:@"Número: %d",number];
}


@end
