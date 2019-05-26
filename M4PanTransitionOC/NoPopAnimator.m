//
//  NoPopAnimator.m
//  M4PanTransitionOC
//
//  Created by Chen,Meisong on 2019/5/26.
//  Copyright © 2019 xyz.chenms. All rights reserved.
//

#import "NoPopAnimator.h"

@implementation NoPopAnimator
#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 2;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *container = transitionContext.containerView;
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect fromDestFrame = container.bounds;
    fromDestFrame.origin.x += container.bounds.size.width;
    
    fromVC.view.alpha = 0.01;
    NSLog(@"【m2】  %s", __func__);
    [container insertSubview:toVC.view belowSubview:fromVC.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.alpha = 0;
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            fromVC.view.alpha = 1;
        }
        NSLog(@"【m2】  %s", __func__);
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}
@end
