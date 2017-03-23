//
//  NSDecimalNumber+rounding.h
//  decimalNumberTest
//
//  Created by 程智锋 on 15/10/25.
//  Copyright © 2015年 程智锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDecimalNumber(rounding)


/**
 *  截取小数位
 *
 *  @param position  小数位数
 *  @param roundMode 模式。NSRoundPlain四舍五入，NSRoundDown直接截取
 */
-(NSDecimalNumber *)returnRoundValueWithPosition:(NSInteger)position andRoundMode:(NSRoundingMode)roundMode;


@end
