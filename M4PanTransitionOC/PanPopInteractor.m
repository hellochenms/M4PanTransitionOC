//
//  PanPopInteractor.m
//  M4PanTransitionOC
//
//  Created by Chen,Meisong on 2019/5/26.
//  Copyright © 2019 xyz.chenms. All rights reserved.
//

#import "PanPopInteractor.h"

@interface PanPopInteractor ()
@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic) BOOL isInteracting;
@property (nonatomic) CGPoint lastTranslation;
@end

@implementation PanPopInteractor
+ (instancetype)transition {
    return [PanPopInteractor new];
}

#pragma mark - Public
- (void)bindViewController:(UIViewController *)popViewController {
    self.viewController = popViewController;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan:)];
    self.viewController.view.userInteractionEnabled = YES;
    [self.viewController.view addGestureRecognizer:pan];
}

#pragma mark - Event
- (void)onPan:(UIPanGestureRecognizer *)pan {
    CGPoint translation = [pan translationInView:pan.view];
//    NSLog(@"【m2】translation:%@  %s", NSStringFromCGPoint(translation), __func__);
    switch (pan.state) {
        case UIGestureRecognizerStateBegan: {
            self.isInteracting = YES;
            self.lastTranslation = translation;
            [self.viewController
             .navigationController popViewControllerAnimated:YES];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            UIViewController *fromVC = [self.animator.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
            CGPoint center = self.animator.pseudoShareView.center;
            CGPoint change = CGPointMake(translation.x - self.lastTranslation.x, translation.y - self.lastTranslation.y);
            center.x += change.x;
            center.y += change.y;
            self.animator.pseudoShareView.center = center;
            self.lastTranslation = translation;
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            CGPoint velocity = [pan velocityInView:pan.view];
            if (velocity.x <= 0) {
                UIView *container = self.animator.transitionContext.containerView;
                UIViewController<NoPopAnimatorable> *fromVC = [self.animator.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
                UIView *fromShareView = [fromVC shareView];
                CGRect fromShareFrame = [fromShareView.superview convertRect:fromShareView.frame toView:container];
                [UIView animateWithDuration:0.25
                                 animations:^{
                                     self.animator.pseudoShareView.frame = fromShareFrame;
                                 } completion:^(BOOL finished) {
                                     [self cancelInteractiveTransition];
                                 }];
            } else {
                UIView *container = self.animator.transitionContext.containerView;
                UIViewController<NoPopAnimatorable> *toVC = [self.animator.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
                UIView *toShareView = [toVC shareView];
                CGRect toShareFrame = [toShareView.superview convertRect:toShareView.frame toView:container];
                [UIView animateWithDuration:0.25
                                 animations:^{
                                     self.animator.pseudoShareView.frame = toShareFrame;
                                 } completion:^(BOOL finished) {
                                     [self updateInteractiveTransition:1];
                                     [self finishInteractiveTransition];
                                 }];
            }
            
            self.isInteracting = NO;
            break;
        }
        default:
            break;
    }
}

@end
