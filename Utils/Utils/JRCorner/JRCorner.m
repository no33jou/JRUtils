//
//  JRCorner.m
//  RWAssistant
//
//  Created by 姚俊任 on 2016/12/21.
//  Copyright © 2016年 韩鹏帅. All rights reserved.
//

#import "JRCorner.h"

@implementation JRCorner
+ (UIImage *)dealImage:(UIImage *)img cornerRadius:(CGFloat)radius byRoundingCorners:(UIRectCorner)corner {
    // 1.CGDataProviderRef 把 CGImage 转 二进制流
    CGDataProviderRef provider = CGImageGetDataProvider(img.CGImage);
    void *imgData = (void *)CFDataGetBytePtr(CGDataProviderCopyData(provider));
    int width = img.size.width * img.scale;
    int height = img.size.height * img.scale;

    // 2.处理 imgData

    cornerImage(imgData, width, height, radius,corner);

    // 3.CGDataProviderRef 把 二进制流 转 CGImage
    CGDataProviderRef pv = CGDataProviderCreateWithData(NULL, imgData, width * height * 4, releaseData);
    CGImageRef content = CGImageCreate(width , height, 8, 32, 4 * width, CGColorSpaceCreateDeviceRGB(), kCGBitmapByteOrder32Big | kCGImageAlphaPremultipliedLast, pv, NULL, true, kCGRenderingIntentDefault);
    UIImage *result = [UIImage imageWithCGImage:content];
    CGDataProviderRelease(pv);      // 释放空间
    CGImageRelease(content);

    return result;
}

void releaseData(void *info, const void *data, size_t size) {
    free((void *)data);
}


// 裁剪圆角
void cornerImage(UInt32 *const img, int w, int h, CGFloat cornerRadius, UIRectCorner corner) {
    CGFloat c = cornerRadius;
    CGFloat min = w > h ? h : w;

    if (c < 0) { c = 0; }
    if (c > min * 0.5) { c = min * 0.5; }


    if(corner & UIRectCornerTopLeft){
        // 左上 y:[0, c), x:[x, c-y)
        for (int y=0; y<c; y++) {
            for (int x=0; x<c-y; x++) {
                UInt32 *p = img + y * w + x;    // p 32位指针，RGBA排列，各8位
                if (isCircle(c, c, c, x, y) == false) {
                    *p = 0;
                }
            }
        }
    }

    if (corner & UIRectCornerTopRight) {
        // 右上 y:[0, c), x:[w-c+y, w)
        int tmp = w-c;
        for (int y=0; y<c; y++) {
            for (int x=tmp+y; x<w; x++) {
                UInt32 *p = img + y * w + x;
                if (isCircle(w-c, c, c, x, y) == false) {
                    *p = 0;
                }
            }
        }
    }
    if (corner & UIRectCornerBottomLeft) {
        // 左下 y:[h-c, h), x:[0, y-h+c)
        int tmp = h-c;
        for (int y=h-c; y<h; y++) {
            for (int x=0; x<y-tmp; x++) {
                UInt32 *p = img + y * w + x;
                if (isCircle(c, h-c, c, x, y) == false) {
                    *p = 0;
                }
            }
        }
    }
    if (corner & UIRectCornerBottomRight) {
        // 右下 y~[h-c, h), x~[w-c+h-y, w)
        int tmp = w-c+h;
        for (int y=h-c; y<h; y++) {
            for (int x=tmp-y; x<w; x++) {
                UInt32 *p = img + y * w + x;
                if (isCircle(w-c, h-c, c, x, y) == false) {
                    *p = 0;
                }
            }
        }
    }
}

// 判断点 (px, py) 在不在圆心 (cx, cy) 半径 r 的圆内
static inline bool isCircle(float cx, float cy, float r, float px, float py) {
    if ((px-cx) * (px-cx) + (py-cy) * (py-cy) > r * r) {
        return false;
    }
    return true;
}


@end
