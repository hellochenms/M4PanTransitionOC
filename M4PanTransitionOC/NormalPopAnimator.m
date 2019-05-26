//
//  NormalPopAnimator.m
//  M4PanTransitionOC
//
//  Created by Chen,Meisong on 2019/5/26.
//  Copyright © 2019 xyz.chenms. All rights reserved.
//

#import "NormalPopAnimator.h"

@implementation NormalPopAnimator

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *container = transitionContext.containerView;
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect fromDestFrame = container.bounds;
    fromDestFrame.origin.x += container.bounds.size.width;
    
    [container insertSubview:toVC.view belowSubview:fromVC.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.frame = fromDestFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
