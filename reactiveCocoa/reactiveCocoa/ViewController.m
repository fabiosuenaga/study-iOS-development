//
//  ViewController.m
//  reactiveCocoa
//
//  Created by Fabio Suenaga on 08/12/16.
//  Copyright © 2016 Personal. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ViewController ()

@property(weak,nonatomic) IBOutlet UITextField *number1;
@property(weak,nonatomic) IBOutlet UITextField *number2;
@property(weak,nonatomic) IBOutlet UIButton *calc;
@property(weak,nonatomic) IBOutlet UILabel *message;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.message.hidden = YES;
    
    // RACSignal that dispatch isValidFirstValue method. Only value between 1 and 100 is allowed!
    RACSignal *validFirstElement =
        [self.number1.rac_textSignal
            map:^id(NSNumber *firstValue) {
                return @([self isValidFirstValue:firstValue]);
            }
        ];
    
    // RACSignal that dispatch isValidSecondValue method. Only even values is allowed!
    RACSignal *validSecondElement =
        [self.number2.rac_textSignal
            map:^id(NSNumber *secondValue) {
                return @([self isValidSecondValue:secondValue]);
            }
         ];
    
    // RAC Macro: allow to assign the output of signal to the property of an object. In this case, map transforms the event data setting the font color.
    RAC(self.number1, textColor) =
        [validFirstElement
            map:^id(NSNumber *validValue) {
                return [validValue boolValue] ? [UIColor blackColor] : [UIColor redColor];
            }
        ];
    
    RAC(self.number2, textColor) =
        [validSecondElement
            map:^id(NSNumber *validValue) {
                return [validValue boolValue] ? [UIColor blackColor] : [UIColor redColor];
            }
         ];
    
    // RACSignal combining two rac signals.
    RACSignal *validCalc =
        [RACSignal combineLatest:@[validFirstElement, validSecondElement]
                          reduce:^id(NSNumber *first, NSNumber *second){
                              return @([first boolValue] && [second boolValue]);
                          }];
   
    [validCalc subscribeNext:^(NSNumber *result) {
        self.calc.enabled = [result boolValue];
    }];
    
//    [[[[self.calc rac_signalForControlEvents:UIControlEventTouchUpInside]
//       doNext:^(id x) {
//           self.calc.enabled = NO;
//           self.message.hidden = YES;
//       }]
//       flattenMap:^id(id x) {
//          return [self calcSignal];
//       }]
//       subscribeNext:^(NSNumber *signedIn) {
//         self.calc.enabled = YES;
//         BOOL success = [signedIn boolValue];
//         self.message.hidden = success;
//         if (success) {
//             self.message.text = @"ok";
//         } else {
//             self.message.text = @"nok";
//         }
//       }];
}

# pragma mark Methods

// Only value between 1 and 100 is allowed!
- (BOOL)isValidFirstValue:(NSNumber *)firstNumber {
    
    return [firstNumber floatValue] > 0 && [firstNumber floatValue] <= 100;
}

// Only even values is allowed!
- (BOOL)isValidSecondValue:(NSNumber *)number {
    int value        = 2;
    int numberCast   = [number intValue];
    float result = (numberCast % value);
    
    return [number floatValue] > 0 && [number floatValue] <= 100 && (result == 0.0);
}

//- (void)calc:(NSNumber *)value01 sum:(NSNumber *)value02 complete:(BOOL)completeBlock {
//    NSNumber *resultFinal = 0;
//    if (resultFinal > 0) {
//        BOOL success = YES;
//        completeBlock(success);
//    }
//
//}
//
//-(RACSignal *)calcSignal {
//    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        [self calc:
//           value01:
//          complete:^(BOOL success) {
//             [subscriber sendNext:@(success)];
//             [subscriber sendCompleted];
//         }];
//        return nil;
//    }];
//}

@end
