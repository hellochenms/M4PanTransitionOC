//
//  M7ScreenEdgePanInteractiveTransition.h
//  MHelloTransition
//
//  Created by chenms on 17/7/31.
//  Copyright © 2017年 chenms.m2. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol M7ScreenEdgePanInteractiveTransitionDelegate;

@interface M7ScreenEdgePanInteractiveTransition : UIPercentDrivenInteractiveTransition
@property (nonatomic, readonly) BOOL isInteracting;
@property (nonatomic) double minShouldFinishProgress;
@property (nonatomic, weak) id<M7ScreenEdgePanInteractiveTransitionDelegate> delegate;
+ (instancetype)transition;
- (void)bindViewController:(UIViewController *)popViewController;
@end

@protocol M7ScreenEdgePanInteractiveTransitionDelegate <NSObject>
- (void)willBeginEdgePan:(M7ScreenEdgePanInteractiveTransition *)interactor;
@end
