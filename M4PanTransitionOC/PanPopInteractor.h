//
//  PanPopInteractor.h
//  M4PanTransitionOC
//
//  Created by Chen,Meisong on 2019/5/26.
//  Copyright © 2019 xyz.chenms. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoPopAnimator.h"

NS_ASSUME_NONNULL_BEGIN
@protocol PanPopInteractorable;

@interface PanPopInteractor : UIPercentDrivenInteractiveTransition
@property (nonatomic, readonly) BOOL isInteracting;
@property (nonatomic) double minShouldFinishProgress;
@property (nonatomic) NoPopAnimator *animator;
+ (instancetype)transition;
- (void)bindViewController:(UIViewController *)popViewController;
@end

@protocol PanPopInteractorable <NSObject>
- (UIView *)shareView;
@end

NS_ASSUME_NONNULL_END
