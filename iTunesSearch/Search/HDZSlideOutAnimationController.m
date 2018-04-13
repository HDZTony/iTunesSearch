//
//  HDZSlideOutAnimationController.m
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/9.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import "HDZSlideOutAnimationController.h"
#import <UIKit/UIKit.h>
@interface HDZSlideOutAnimationController()<UIViewControllerAnimatedTransitioning>
@end
@implementation HDZSlideOutAnimationController

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *contanierView = transitionContext.containerView;
    NSTimeInterval time = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:time animations:^{
        CGPoint templateCenter = fromView.center;
        templateCenter.y = fromView.center.y - contanierView.bounds.size.height;
        fromView.center = templateCenter;
        fromView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:finished];
    }];
    
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

@end
