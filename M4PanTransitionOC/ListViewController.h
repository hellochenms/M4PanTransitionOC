//
//  ListViewController.h
//  M4PanTransitionOC
//
//  Created by Chen,Meisong on 2019/5/26.
//  Copyright © 2019 xyz.chenms. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareItemAnimator.h"
#import "RealShareItemAnimator.h"

NS_ASSUME_NONNULL_BEGIN

@interface ListViewController : UIViewController<
ShareItemAnimatorable
, RealShareItemAnimatorable>

@end

NS_ASSUME_NONNULL_END
