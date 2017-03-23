//
//  UIImage+ToolKit.h
//  GameVideoShare
//
//  Created by xzysun on 15/2/6.
//  Copyright (c) 2015年 netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ToolKit)

#pragma mark - Fix Orientation
+ (UIImage *)fixOrientation:(UIImage *)aImage;

#pragma mark - Cut Image
//根据截取比例来剪切图片
+(UIImage *)cutImage:(UIImage *)orignImage withLeft:(CGFloat)left withRight:(CGFloat)right withTop:(CGFloat)top withBottom:(CGFloat)bottom;

#pragma mark - Rotate Image
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

#pragma mark - Ellipse
+ (UIImage *)ellipseImage:(UIImage *)image withInset:(CGFloat)inset;
+ (UIImage *)ellipseImage:(UIImage *)image withInset:(CGFloat)inset withBorderWidth:(CGFloat)width withBorderColor:(UIColor*)color;
//在外围画边框
+ (UIImage *)ellipseImage:(UIImage *)image withBorderWidth:(CGFloat)borderWidth withBorderColor:(UIColor*)color;


/**
 * 根据CIImage生成指定大小的UIImage
 *
 * @param image CIImage
 * @param size 图片宽度
 */
+(UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size;
@end
