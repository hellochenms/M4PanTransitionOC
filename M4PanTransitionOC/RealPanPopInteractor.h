//
//  RealPanPopInteractor.h
//  M4PanTransitionOC
//
//  Created by Chen,Meisong on 2019/5/27.
//  Copyright © 2019 xyz.chenms. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RealShareItemPopAnimator.h"

NS_ASSUME_NONNULL_BEGIN

@protocol RealPanPopInteractorDelegate;

@interface RealPanPopInteractor : UIPercentDrivenInteractiveTransition
@property (nonatomic, readonly) BOOL isInteracting;
@property (nonatomic) double minShouldFinishProgress;
@property (nonatomic) RealShareItemPopAnimator *animator;
@property (nonatomic, weak) id<RealPanPopInteractorDelegate> delegate;
+ (instancetype)transition;
- (void)bindViewController:(UIViewController *)popViewController;
@end

@protocol RealPanPopInteractorDelegate <NSObject>
- (void)willBeginPan:(RealPanPopInteractor *)interactor;
@end

NS_ASSUME_NONNULL_END
