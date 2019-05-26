//
//  PanPopInteractor.h
//  M4PanTransitionOC
//
//  Created by Chen,Meisong on 2019/5/26.
//  Copyright © 2019 xyz.chenms. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PanPopInteractor : UIPercentDrivenInteractiveTransition
@property (nonatomic, readonly) BOOL isInteracting;
@property (nonatomic) double minShouldFinishProgress;
+ (instancetype)transition;
- (void)bindViewController:(UIViewController *)popViewController;
@end

NS_ASSUME_NONNULL_END
