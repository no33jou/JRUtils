//
//  UIView+JRFrame.m
//  pregnantMedical
//
//  Created by 姚俊任 on 2016/11/21.
//  Copyright © 2016年 com.jiqiao. All rights reserved.
//

#import "UIView+JRFrame.h"

@implementation UIView (JRFrame)
- (CGFloat)JR_X{
    return self.frame.origin.x;
}
- (void)setJR_X:(CGFloat)JR_X{
    CGRect frame = self.frame;
    frame.origin.x = JR_X;
    self.frame = frame;
}
- (CGFloat)JR_Y{
    return self.frame.origin.y;
}
- (void)setJR_Y:(CGFloat)JR_Y{
    CGRect frame = self.frame;
    frame.origin.y = JR_Y;
    self.frame = frame;
}
- (CGFloat)JR_W{
    return self.frame.size.width;
}
- (void)setJR_W:(CGFloat)JR_W{
    CGRect frame = self.frame;
    frame.size.width = JR_W;
    self.frame = frame;
}
- (CGFloat)JR_H{
    return self.frame.size.height;
}
- (void)setJR_H:(CGFloat)JR_H{
    CGRect frame = self.frame;
    frame.size.height = JR_H;
    self.frame = frame;
}
- (CGFloat)JR_CenterX{
    return self.center.x;
}
- (void)setJR_CenterX:(CGFloat)JR_CenterX{
    CGPoint center = self.center;
    center.x = JR_CenterX;
    self.center = center;
}
- (CGFloat)JR_CenterY{
    return self.center.y;
}
- (void)setJR_CenterY:(CGFloat)JR_CenterY{
    CGPoint center = self.center;
    center.y = JR_CenterY;
    self.center = center;
}
@end
