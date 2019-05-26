//
//  ShareItemAnimator.m
//  M4PanTransitionOC
//
//  Created by Chen,Meisong on 2019/5/26.
//  Copyright © 2019 xyz.chenms. All rights reserved.
//

#import "ShareItemAnimator.h"

@interface ShareItemAnimator ()

@end

@implementation ShareItemAnimator
#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *container = transitionContext.containerView;
    UIViewController<ShareItemAnimatorable> *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromShareView = [fromVC shareView];
    CGRect fromShareFrame = [fromShareView.superview convertRect:fromShareView.frame toView:container];
    fromShareView.hidden = YES;
    
    UIViewController<ShareItemAnimatorable> *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toShareView = [toVC shareView];
    CGRect toShareFrame = [toShareView.superview convertRect:toShareView.frame toView:container];
    [container addSubview:toVC.view];
    toShareView.hidden = YES;
    toVC.view.alpha = 0;
    
    UIView *pseudoShareView = [fromShareView snapshotViewAfterScreenUpdates:NO];
    pseudoShareView.frame = fromShareFrame;
    [container addSubview:pseudoShareView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        pseudoShareView.frame = toShareFrame;
        toVC.view.alpha = 1;
    } completion:^(BOOL finished) {
        [pseudoShareView removeFromSuperview];
        fromShareView.hidden = NO;
        toShareView.hidden = NO;
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}
@end
