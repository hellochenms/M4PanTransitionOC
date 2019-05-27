//
//  RealShareItemAnimator.h
//  M4PanTransitionOC
//
//  Created by Chen,Meisong on 2019/5/27.
//  Copyright © 2019 xyz.chenms. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RealShareItemAnimatorable;

@interface RealShareItemAnimator : NSObject<UIViewControllerAnimatedTransitioning>

@end

@protocol RealShareItemAnimatorable <NSObject>
- (UIView *)realShareView;
- (UIView *)realShareViewContainer;
@optional
- (void)didAddShareViewToContainer:(UIView *)shareView;
@end

NS_ASSUME_NONNULL_END
