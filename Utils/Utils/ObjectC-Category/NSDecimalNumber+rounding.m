//
//  NSDecimalNumber+rounding.m
//  decimalNumberTest
//
//  Created by 程智锋 on 15/10/25.
//  Copyright © 2015年 程智锋. All rights reserved.
//

#import "NSDecimalNumber+rounding.h"

@implementation NSDecimalNumber(rounding)


-(NSDecimalNumber *)returnRoundValueWithPosition:(NSInteger)position andRoundMode:(NSRoundingMode)roundMode
{

    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:roundMode scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    
//    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    
//    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:price];
    roundedOunces = [self decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    return roundedOunces;
}

@end
