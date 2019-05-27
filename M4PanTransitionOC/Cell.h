//
//  Cell.h
//  M4PanTransitionOC
//
//  Created by Chen,Meisong on 2019/5/26.
//  Copyright © 2019 xyz.chenms. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Cell : UICollectionViewCell
@property (nonatomic, readonly) UIImageView *someContainer;
@property (nonatomic, readonly) UIImageView *someView;
@property (nonatomic, readonly) WKWebView *webView;
@end

NS_ASSUME_NONNULL_END
