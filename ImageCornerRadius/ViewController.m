//
//  ViewController.m
//  ImageCornerRadius
//
//  Created by 魏素宝 on 16/3/8.
//  Copyright © 2016年 SUBAOWEI. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+CornerRadius.h"
#import "UIImageView+CornerRadius.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 测试1-原始方式，有离屏渲染问题
    UIImageView *iv_1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"test"]];
    iv_1.layer.cornerRadius=50;
    iv_1.clipsToBounds=YES;
    iv_1.frame=CGRectMake(30, 30, 100, 100);
    [self.view addSubview:iv_1];
    
    // 测试2-UIImage的category，存在图片圆角误差问题
    UIImageView *iv_2=[[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"test"] wp_imageWithCornerRadius:50]];
    iv_2.frame=CGRectMake(30, 180, 100, 100);
    [self.view addSubview:iv_2];
    
    // 测试3-UIImageView的category，解决问题
    UIImageView *iv_3=[[UIImageView alloc]initWithRect:CGRectMake(30, 330, 100, 100) Image:[UIImage imageNamed:@"test"] Radius:50];
    [self.view addSubview:iv_3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
