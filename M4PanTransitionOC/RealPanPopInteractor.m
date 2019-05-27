//
//  RealPanPopInteractor.m
//  M4PanTransitionOC
//
//  Created by Chen,Meisong on 2019/5/27.
//  Copyright © 2019 xyz.chenms. All rights reserved.
//

#import "RealPanPopInteractor.h"

@interface RealPanPopInteractor ()
@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic) BOOL isInteracting;
@property (nonatomic) CGPoint lastTranslation;
@end

@implementation RealPanPopInteractor
+ (instancetype)transition {
    return [RealPanPopInteractor new];
}

#pragma mark - Public
- (void)bindViewController:(UIViewController<RealShareItemPopAnimatorable> *)popViewController {
    self.viewController = popViewController;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan:)];
    self.viewController.view.userInteractionEnabled = YES;
    [[popViewController realShareViewContainer] addGestureRecognizer:pan];
}

#pragma mark - Event
- (void)onPan:(UIPanGestureRecognizer *)pan {
    CGPoint translation = [pan translationInView:pan.view];
//    NSLog(@"【m2】translation:%@  %s", NSStringFromCGPoint(translation), __func__);
    switch (pan.state) {
        case UIGestureRecognizerStateBegan: {
            NSLog(@"【m2】【【【【【【【【【【【【【  %s", __func__);
            if ([self.delegate respondsToSelector:@selector(willBeginPan:)]) {
                [self.delegate willBeginPan:self];
            }
            self.isInteracting = YES;
            self.lastTranslation = translation;
            [self.viewController
             .navigationController popViewControllerAnimated:YES];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            UIViewController *fromVC = [self.animator.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
            CGPoint center = self.animator.shareView.center;
            CGPoint change = CGPointMake(translation.x - self.lastTranslation.x, translation.y - self.lastTranslation.y);
            center.x += change.x;
            center.y += change.y;
            self.animator.shareView.center = center;
            self.lastTranslation = translation;
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            NSLog(@"【m2】】】】】】】】】】】】】  %s", __func__);
            CGPoint velocity = [pan velocityInView:pan.view];
            if (velocity.x <= 0) {
                UIView *container = self.animator.transitionContext.containerView;
                UIViewController<RealShareItemPopAnimatorable> *fromVC = [self.animator.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
                UIView *fromShareContainer = [fromVC realShareViewContainer];
                CGRect fromShareContainerFrame = [fromShareContainer.superview convertRect:fromShareContainer.frame toView:container];
                [UIView animateWithDuration:0.25
                                 animations:^{
                                     self.animator.shareView.frame = fromShareContainerFrame;
                                 } completion:^(BOOL finished) {
                                     [self cancelInteractiveTransition];
                                 }];
            } else {
                UIView *container = self.animator.transitionContext.containerView;
                UIViewController<RealShareItemPopAnimatorable> *toVC = [self.animator.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
                UIView *toShareContainer = [toVC realShareViewContainer];
                CGRect toShareContainerFrame = [toShareContainer.superview convertRect:toShareContainer.frame toView:container];
                [UIView animateWithDuration:0.25
                                 animations:^{
                                     self.animator.shareView.frame = toShareContainerFrame;
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
