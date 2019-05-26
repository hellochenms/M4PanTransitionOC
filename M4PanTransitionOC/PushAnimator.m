//
//  PushAnimator.m
//  M4PanTransitionOC
//
//  Created by Chen,Meisong on 2019/5/26.
//  Copyright © 2019 xyz.chenms. All rights reserved.
//

#import "PushAnimator.h"

@implementation PushAnimator

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *container = transitionContext.containerView;
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect toSrcFrame = container.bounds;
    toSrcFrame.origin.y += container.bounds.size.height;
    toVC.view.frame = toSrcFrame;
    [container addSubview:toVC.view];
    
    CGRect toDestFrame = container.bounds;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toVC.view.frame = toDestFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
