//
//  JRCornerImage.h
//  RWAssistant
//
//  Created by 姚俊任 on 2016/12/21.
//  Copyright © 2016年 韩鹏帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JRCorner : NSObject
/***
    UIView圆角可以使用cornerRadius,在不开masksToBounds和clipsToBounds不会有性能问题,
 ***/


/**
 UIImage

 @param img 要画圆角的Image
 @param radius 角度
 @param corner 圆角样式:左上 右上 左下 右下 的排列组合
 @return 返回绘制了圆角Image
 */
+ (UIImage *)dealImage:(UIImage *)img cornerRadius:(CGFloat)radius byRoundingCorners:(UIRectCorner)corner;
@end
