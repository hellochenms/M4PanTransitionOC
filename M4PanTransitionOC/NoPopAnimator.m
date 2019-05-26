//
//  NoPopAnimator.m
//  M4PanTransitionOC
//
//  Created by Chen,Meisong on 2019/5/26.
//  Copyright © 2019 xyz.chenms. All rights reserved.
//

#import "NoPopAnimator.h"

@interface NoPopAnimator ()
@property (nonatomic, weak) UIView *pseudoShareView;
@property (nonatomic, weak) id <UIViewControllerContextTransitioning> transitionContext;
@end

@implementation NoPopAnimator
#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    self.transitionContext = transitionContext;
    
    UIView *container = transitionContext.containerView;
    UIViewController<NoPopAnimatorable> *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromShareView = [fromVC shareView];
    CGRect fromShareFrame = [fromShareView.superview convertRect:fromShareView.frame toView:container];
    fromShareView.hidden = YES;
    fromVC.view.alpha = 0.01;
    
    UIViewController<NoPopAnimatorable> *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toShareView = [toVC shareView];
    CGRect toShareFrame = [toShareView.superview convertRect:toShareView.frame toView:container];
    [container insertSubview:toVC.view belowSubview:fromVC.view];
    toShareView.hidden = YES;
    
    UIView *pseudoShareView = [fromShareView snapshotViewAfterScreenUpdates:NO];
    pseudoShareView.frame = fromShareFrame;
    [container addSubview:pseudoShareView];
    self.pseudoShareView = pseudoShareView;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.alpha = 0;
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            fromVC.view.alpha = 1;
        }
        [pseudoShareView removeFromSuperview];
        fromShareView.hidden = NO;
        toShareView.hidden = NO;
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
