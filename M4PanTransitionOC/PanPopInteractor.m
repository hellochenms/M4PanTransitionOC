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
    switch (pan.state) {
        case UIGestureRecognizerStateBegan: {
            self.isInteracting = YES;
            self.panTotalWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
            [self.viewController
             .navigationController popViewControllerAnimated:YES];
            break;
        }
        case UIGestureRecognizerStateChanged: {
//            double progress = translation.x / self.panTotalWidth;
//            progress = fmin(fmax(progress, 0), 1.0);
//            self.shouldFinish = (progress >= self.minShouldFinishProgress);
//            [self updateInteractiveTransition:progress];
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
                [self cancelInteractiveTransition];
            } else {
                [self finishInteractiveTransition];
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
