//
//  ShareItemAnimator.h
//  M4PanTransitionOC
//
//  Created by Chen,Meisong on 2019/5/26.
//  Copyright © 2019 xyz.chenms. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ShareItemAnimatorable;

@interface ShareItemAnimator : NSObject<UIViewControllerAnimatedTransitioning>

@end

@protocol ShareItemAnimatorable <NSObject>
- (UIView *)shareView;
@end

NS_ASSUME_NONNULL_END
