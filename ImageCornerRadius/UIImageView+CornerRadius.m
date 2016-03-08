//
//  UIImageView+CornerRadius.m
//  ImageCornerRadius
//
//  Created by 魏素宝 on 16/3/8.
//  Copyright © 2016年 SUBAOWEI. All rights reserved.
//

#import "UIImageView+CornerRadius.h"

@implementation UIImageView (CornerRadius)
/**
 *  返回带有圆角图片的imageView
 *
 *  @param rect   imageView的尺寸
 *  @param img    图片
 *  @param radius 半径
 *
 *  @return 返回带有圆角图片的ImageView
 */
-(UIImageView *)initWithRect:(CGRect)rect Image:(UIImage *)img Radius:(CGFloat)radius{
    // 先得到带有圆角的图片
    CGRect imgRect=(CGRect){0,0,rect.size};
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    CGContextAddPath(UIGraphicsGetCurrentContext(), [UIBezierPath bezierPathWithRoundedRect:imgRect cornerRadius:radius].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    [img drawInRect:imgRect];
    UIImage *newImg=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // 把新图片和rect赋值给imageView
    UIImageView *iv=[[UIImageView alloc]initWithFrame:rect];
    iv.image=newImg;
    // 返回imageView
    return iv;
}
@end
