//
//  NoPopAnimator.h
//  M4PanTransitionOC
//
//  Created by Chen,Meisong on 2019/5/26.
//  Copyright © 2019 xyz.chenms. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NoPopAnimatorable;

@interface NoPopAnimator : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, weak, readonly) UIView *pseudoShareView;
@property (nonatomic, weak, readonly) id <UIViewControllerContextTransitioning> transitionContext;
@end

@protocol NoPopAnimatorable <NSObject>
- (UIView *)shareView;
@end

NS_ASSUME_NONNULL_END
