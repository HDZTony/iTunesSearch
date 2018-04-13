//
//  UIView+Frame.m
//  03-MeiTuan(搭建项目环境)
//
//  Created by Apple on 16/9/6.
//  Copyright © 2016年 yunjia. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
- (void)setHdz_x:(CGFloat)yj_x
{
    CGRect frame = self.frame;
    frame.origin.x = yj_x;
    // 设置UIView的x值
    self.frame = frame;
}

- (CGFloat)hdz_x
{
    // 返回UIView的x值
    return self.frame.origin.x;
}

- (void)setHdz_y:(CGFloat)yj_y
{
    CGRect frame = self.frame;
    frame.origin.y = yj_y;
    self.frame = frame;
}

- (CGFloat)hdz_y
{
    return self.frame.origin.y;
}

- (void)setHdz_width:(CGFloat)yj_width
{
    CGRect frame = self.frame;
    frame.size.width = yj_width;
    self.frame = frame;
}

- (CGFloat)hdz_width
{
    return self.frame.size.width;
}

- (void)setHdz_height:(CGFloat)yj_height
{
    CGRect frame = self.frame;
    frame.size.height = yj_height;
    self.frame = frame;
}

- (CGFloat)hdz_height
{
    return self.frame.size.height;
}

- (void)setHdz_centerX:(CGFloat)yj_centerX
{
    CGPoint center = self.center;
    center.x = yj_centerX;
    self.center = center;
}

- (CGFloat)hdz_centerX
{
    return self.center.x;
}

- (void)setHdz_centerY:(CGFloat)yj_centerY
{
    CGPoint center = self.center;
    center.y = yj_centerY;
    self.center = center;
}

- (CGFloat)hdz_centerY
{
    return self.center.y;
}







@end

