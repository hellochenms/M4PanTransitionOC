//
//  DetailViewController.h
//  M4PanTransitionOC
//
//  Created by Chen,Meisong on 2019/5/26.
//  Copyright © 2019 xyz.chenms. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareItemAnimator.h"
#import "RealShareItemPopAnimator.h"
#import "M7ScreenEdgePanInteractiveTransition.h"
#import "RealPanPopInteractor.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController<
ShareItemAnimatorable
, RealShareItemPopAnimatorable
, RealPanPopInteractorDelegate
, M7ScreenEdgePanInteractiveTransitionDelegate>

@end

NS_ASSUME_NONNULL_END
