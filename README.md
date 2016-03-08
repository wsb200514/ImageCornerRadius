# ImageCornerRadius
写了个基于UIImageView的Category实现图片圆角，避免离屏渲染问题


#### 1、最直接的方法如下，但会产生离屏渲染问题，影响性能
```
  UIImageView *iv_1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"test"]];
  iv_1.layer.cornerRadius=50;
  iv_1.clipsToBounds=YES;
  iv_1.frame=CGRectMake(30, 30, 100, 100);
  [self.view addSubview:iv_1];
```

### 2、在UIImage层面处理图片，会产生圆角偏差问题（）
```
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
```
```
  UIImageView *iv_2=[[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"test"] wp_imageWithCornerRadius:50]];
  iv_2.frame=CGRectMake(30, 180, 100, 100);
  [self.view addSubview:iv_2];
```

### 3、在UIImageView层面处理图片，目前看来还不错
```
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
```

#### 效果比较图（从上至下就是以上3中处理方法的结果，第二种结果明显圆角设置存在误差）
![image](https://github.com/wsb200514/ImageCornerRadius/blob/master/%E6%95%88%E6%9E%9C%E5%9B%BE%202016-03-08%2016.52.39.png)
