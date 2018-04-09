//
//  HDZGradientView.m
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/5.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import "HDZGradientView.h"

@implementation HDZGradientView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGFloat components[] = {0.0,0.0,0.0,0.3,0.0,0.0,0.0,0.7};
    CGFloat locations[] = {0,1};
   CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, 2);
    CGFloat x = CGRectGetMidX(self.bounds);
    CGFloat y = CGRectGetMidY(self.bounds);
    CGPoint centerPoint = CGPointMake(x, y);
    CGFloat radius = MAX(x, y);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawRadialGradient(context, gradient, centerPoint, 0, centerPoint, radius, kCGGradientDrawsAfterEndLocation);
    
}


@end
