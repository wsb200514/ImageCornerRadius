//
//  UIImage+CornerRadius.m
//  ImageCornerRadius
//
//  Created by 魏素宝 on 16/3/8.
//  Copyright © 2016年 SUBAOWEI. All rights reserved.
//

#import "UIImage+CornerRadius.h"

@implementation UIImage (CornerRadius)
/**
 *  把原始图片切成圆角的函数，利用bezier的一个方法绘制
 *
 *  @param radius 圆角半径
 *
 *  @return 返回新的带有圆角的图片
 */
-(UIImage *) wp_imageWithCornerRadius:(CGFloat)radius{
    // 构造图片的rect
    CGRect rect=(CGRect){0,0,self.size};
    // 创建上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);
    // 利用bezier的一个函数写path路径
    CGContextAddPath(UIGraphicsGetCurrentContext(), [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    // 切割
    CGContextClip(UIGraphicsGetCurrentContext());
    // 画出新的来
    [self drawInRect:rect];
    // 获取新图片
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    // 返回新图片
    return image;
}
@end
