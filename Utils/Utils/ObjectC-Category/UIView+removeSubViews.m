//
//  UIView+removeSubViews.m
//  GameVideoShare
//
//  Created by chengzhifeng on 14-10-22.
//  Copyright (c) 2014年 netease. All rights reserved.
//

#import "UIView+removeSubViews.h"

@implementation UIView(removeSubViews)


-(void)removeAllSubViews{
    for (UIView *v in self.subviews) {
        [v removeFromSuperview];
    }
}

@end
