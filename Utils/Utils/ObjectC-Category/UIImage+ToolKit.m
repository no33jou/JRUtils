//
//  UIImage+ToolKit.m
//  GameVideoShare
//
//  Created by xzysun on 15/2/6.
//  Copyright (c) 2015年 netease. All rights reserved.
//

#import "UIImage+ToolKit.h"

@implementation UIImage (ToolKit)

#pragma mark - Fix Orientation
+ (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


#pragma mark - Cut Image
//根据截取比例来剪切图片
+(UIImage *)cutImage:(UIImage *)orignImage withLeft:(CGFloat)left withRight:(CGFloat)right withTop:(CGFloat)top withBottom:(CGFloat)bottom
{
    CGSize imageSize = orignImage.size;
    imageSize.width = imageSize.width * orignImage.scale;
    imageSize.height = imageSize.height * orignImage.scale;
    
    CGFloat x = imageSize.width * left;
    CGFloat y = imageSize.height * top;
    CGFloat w = imageSize.width * right - x;
    CGFloat h = imageSize.height * bottom -y;
    
    CGRect rect = CGRectMake(x, y, w, h);
    CGImageRef imageRef = CGImageCreateWithImageInRect([orignImage CGImage], rect);
    UIImage *cutImage =[UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return cutImage;
}

#pragma mark - Rotate Image
CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
CGFloat RadiansToDegrees(CGFloat radians) {return radians * 180/M_PI;};

- (UIImage *)imageRotatedByRadians:(CGFloat)radians
{
    return [self imageRotatedByDegrees:RadiansToDegrees(radians)];
}

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees
{
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(DegreesToRadians(degrees));
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    CGContextRotateCTM(bitmap, DegreesToRadians(degrees));
    
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
    
    UIImage *resImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resImage;
}

#pragma mark - Ellipse 
//不要边框，只把图片变成圆形
+ (UIImage *)ellipseImage:(UIImage *)image withInset:(CGFloat)inset
{
    return [self ellipseImage:image withInset:inset withBorderWidth:0 withBorderColor:[UIColor clearColor]];
}

+ (UIImage *)ellipseImage:(UIImage *)image withInset:(CGFloat)inset withBorderWidth:(CGFloat)width withBorderColor:(UIColor*)color
{
    //注意屏幕的分辨率
    CGFloat screenScale = [UIScreen mainScreen].scale;
    CGFloat imageScale = image.scale;
    
    CGSize newSize = CGSizeMake(image.size.width*imageScale, image.size.height*imageScale);
    UIGraphicsBeginImageContext(newSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(inset * screenScale, inset * screenScale, image.size.width * imageScale - inset * 2.0f * screenScale , image.size.height * imageScale - inset * 2.0f * screenScale);
    
    //defence
    if (context == nil) {
        return nil;
    }
    
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    [image drawInRect:rect];
    
    if (width > 0) {
        CGContextSetStrokeColorWithColor(context, color.CGColor);
        CGContextSetLineCap(context,kCGLineCapButt);
        CGContextSetLineWidth(context, width  * screenScale);
        CGContextAddEllipseInRect(context, CGRectMake((inset + width/2) * screenScale, (inset +  width/2) * screenScale, image.size.width * imageScale - width * screenScale- inset * 2.0f*screenScale, image.size.height*imageScale - width*screenScale - inset * 2.0f * screenScale));//在这个框中画圆
        
        CGContextStrokePath(context);
    }
    
    
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

//在外围画边框
+ (UIImage *)ellipseImage:(UIImage *)image withBorderWidth:(CGFloat)borderWidth withBorderColor:(UIColor*)color
{
    //注意屏幕的分辨率
    CGFloat screenScale = [UIScreen mainScreen].scale;
    CGFloat imageScale = image.scale;
    
    //newSize以像素为单位。borderwidth以点为单位。
    CGSize newSize = CGSizeMake(image.size.width*imageScale + borderWidth*2*screenScale, image.size.height*imageScale + borderWidth*2*screenScale);
    UIGraphicsBeginImageContext(newSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //defence
    if (context == nil) {
        return nil;
    }
    
    //画边框
    if (borderWidth > 0) {
        CGContextSetStrokeColorWithColor(context, color.CGColor);
        CGContextSetLineCap(context,kCGLineCapRound);
        CGContextSetLineWidth(context, borderWidth * screenScale);
        CGRect borderRect = CGRectMake(borderWidth * screenScale/2.0f, borderWidth *screenScale/2.0f, image.size.width*imageScale + borderWidth*screenScale, image.size.height*imageScale + borderWidth*screenScale);
        CGContextAddEllipseInRect(context, borderRect);//在这个框中画圆
        CGContextStrokePath(context);
    }
    
    //画圆形图
    CGRect rect = CGRectMake(borderWidth * screenScale, borderWidth * screenScale, image.size.width *imageScale, image.size.height* imageScale);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    [image drawInRect:rect];
    
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newimg;
}



/**
 * 根据CIImage生成指定大小的UIImage
 *
 * @param image CIImage
 * @param size 图片宽度
 */
+(UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}
@end
