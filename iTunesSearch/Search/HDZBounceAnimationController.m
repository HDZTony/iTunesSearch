//
//  HDZBounceAnimationController.m
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/8.
//  Copyright © 2018年 何东洲. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "HDZBounceAnimationController.h"
@interface HDZBounceAnimationController()<UIViewControllerAnimatedTransitioning>
@end
@implementation HDZBounceAnimationController

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    if (toViewController && toView) {
        UIView *containerView = transitionContext.containerView;
        toView.frame = [transitionContext finalFrameForViewController:toViewController];
        [containerView addSubview:toView];
        toView.transform  = CGAffineTransformMakeScale(0.7, 0.7);
        [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
            [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.334 animations:^{
                toView.transform = CGAffineTransformMakeScale(1.2, 1.2);
            }];
            [UIView addKeyframeWithRelativeStartTime:0.334 relativeDuration:0.333 animations:^{
                toView.transform = CGAffineTransformMakeScale(0.9, 0.9);
            }];
            [UIView addKeyframeWithRelativeStartTime:0.666 relativeDuration:0.333 animations:^{
                toView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            }];
            
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:finished];
        }];
    }
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.4;
}

@end
