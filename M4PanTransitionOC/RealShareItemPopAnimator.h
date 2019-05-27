//
//  RealShareItemPopAnimator.h
//  M4PanTransitionOC
//
//  Created by Chen,Meisong on 2019/5/27.
//  Copyright © 2019 xyz.chenms. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RealShareItemPopAnimatorable;

@interface RealShareItemPopAnimator : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, weak, readonly) UIView *shareView;
@property (nonatomic, weak, readonly) id <UIViewControllerContextTransitioning> transitionContext;
@end

@protocol RealShareItemPopAnimatorable <NSObject>
- (UIView *)realShareView;
- (UIView *)realShareViewContainer;
@optional
- (void)didAddShareViewToContainer:(UIView *)shareView;
@end

NS_ASSUME_NONNULL_END
