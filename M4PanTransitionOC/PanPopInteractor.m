//
//  PanPopInteractor.m
//  M4PanTransitionOC
//
//  Created by Chen,Meisong on 2019/5/26.
//  Copyright © 2019 xyz.chenms. All rights reserved.
//

#import "PanPopInteractor.h"

static double const kMinShouldFinishProgress = .5;

@interface PanPopInteractor ()
@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic) BOOL shouldFinish;
@property (nonatomic) BOOL isInteracting;
@property (nonatomic) double panTotalWidth;
@property (nonatomic) CGPoint lastTranslation;
@end

@implementation PanPopInteractor
+ (instancetype)transition {
    return [PanPopInteractor new];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _minShouldFinishProgress = kMinShouldFinishProgress;
    }
    
    return self;
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
            self.panTotalWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
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
//            double progress = translation.x / self.panTotalWidth;
//            progress = fmin(fmax(progress, 0), 1.0);
//            self.shouldFinish = (progress >= self.minShouldFinishProgress);
//            [self updateInteractiveTransition:progress];
            
            self.lastTranslation = translation;
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
//            if (!self.shouldFinish || pan.state == UIGestureRecognizerStateCancelled) {
//                [self cancelInteractiveTransition];
//            } else {
//                [self finishInteractiveTransition];
//            }
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
                                     NSLog(@"【m2】cancelInteractiveTransition  %s", __func__);
//                                     [self.animator.transitionContext completeTransition:NO];
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
                                     NSLog(@"【m2】finishInteractiveTransition  %s", __func__);
//                                     [self.animator.transitionContext completeTransition:YES];
                                 }];
            }
            
            self.panTotalWidth = 0;
            self.isInteracting = NO;
            break;
        }
        default:
            break;
    }
}

#pragma mark - Setter
- (void)setMinShouldFinishProgress:(double)minShouldFinishProgress {
    _minShouldFinishProgress = fmin(fmax(minShouldFinishProgress, .1), .9);
}

@end
