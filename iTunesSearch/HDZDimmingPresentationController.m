//
//  HDZDimmingPresentationController.m
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/4.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import "HDZDimmingPresentationController.h"
#import "HDZGradientView.h"
@interface HDZDimmingPresentationController()
@property (nonatomic, strong) HDZGradientView *dimmingView;
@end
@implementation HDZDimmingPresentationController
-(HDZGradientView *)dimmingView{
    if (nil == _dimmingView) {
        _dimmingView = [[HDZGradientView alloc] initWithFrame:CGRectZero];
    }
    return _dimmingView;
}

-(BOOL)shouldRemovePresentersView{
    return NO;
}
-(void)presentationTransitionWillBegin{
    self.dimmingView.frame = self.containerView.bounds;
    [self.containerView insertSubview:self.dimmingView atIndex:0];
    self.dimmingView.alpha = 0;
   id<UIViewControllerTransitionCoordinator> coordinator =   self.presentedViewController.transitionCoordinator ;
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.alpha = 1;
    } completion:nil];    
}
-(void)dismissalTransitionWillBegin{
    id<UIViewControllerTransitionCoordinator> coordinator = self.presentedViewController.transitionCoordinator;
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.alpha = 0;
    } completion:nil];
}

@end
