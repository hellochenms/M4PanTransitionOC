//
//  RealShareItemAnimator.m
//  M4PanTransitionOC
//
//  Created by Chen,Meisong on 2019/5/27.
//  Copyright © 2019 xyz.chenms. All rights reserved.
//

#import "RealShareItemAnimator.h"

@implementation RealShareItemAnimator
#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *container = transitionContext.containerView;
    
    UIViewController<RealShareItemAnimatorable> *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromShareContainer = [fromVC realShareViewContainer];
    CGRect fromShareContainerFrame = [fromShareContainer.superview convertRect:fromShareContainer.frame toView:container];
    UIView *shareView = [fromVC realShareView];
    
    UIViewController<RealShareItemAnimatorable> *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toShareContainer = [toVC realShareViewContainer];
    CGRect toShareContainerFrame = [toShareContainer.superview convertRect:toShareContainer.frame toView:container];
    [container addSubview:toVC.view];
    
    [shareView removeFromSuperview];
    shareView.frame = fromShareContainerFrame;
    [container addSubview:shareView];
    
    toVC.view.alpha = 0;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        shareView.frame = toShareContainerFrame;
        toVC.view.alpha = 1;
    } completion:^(BOOL finished) {
        if (![transitionContext transitionWasCancelled]) {
            [shareView removeFromSuperview];
            shareView.frame = toShareContainer.bounds;
            [toShareContainer addSubview:shareView];
            if ([toVC respondsToSelector:@selector(didAddShareViewToContainer:)]) {
                [toVC didAddShareViewToContainer:shareView];
            }
        } else {
            [shareView removeFromSuperview];
            shareView.frame = fromShareContainer.bounds;
            [fromShareContainer addSubview:shareView];
            if ([fromVC respondsToSelector:@selector(didAddShareViewToContainer:)]) {
                [fromVC didAddShareViewToContainer:shareView];
            }
        }
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
