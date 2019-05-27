//
//  Cell.m
//  M4PanTransitionOC
//
//  Created by Chen,Meisong on 2019/5/26.
//  Copyright © 2019 xyz.chenms. All rights reserved.
//

#import "Cell.h"


@interface Cell ()
@property (nonatomic) UIImageView *someContainer;
@property (nonatomic) UIImageView *someView;
@property (nonatomic) WKWebView *webView;
@end

@implementation Cell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.someContainer];
//        [self.someContainer addSubview:self.someView];
        [self.someContainer addSubview:self.webView];
        
        NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"1" ofType:@"gif"]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.someContainer.frame = self.contentView.bounds;
    self.someView.frame = self.someContainer.bounds;
    self.webView.frame = self.someContainer.bounds;
}

#pragma mark - Getter
- (UIImageView *)someContainer {
    if (!_someContainer) {
        _someContainer = [UIImageView new];
    }
    
    return _someContainer;
}

- (UIImageView *)someView {
    if (!_someView) {
        _someView = [UIImageView new];
        _someView.backgroundColor = [UIColor blueColor];
    }
    
    return _someView;
}
- (WKWebView *)webView {
    if (!_webView) {
        _webView = [WKWebView new];
        _webView.layer.borderColor = [UIColor blueColor].CGColor;
        _webView.layer.borderWidth = 1;
        _webView.userInteractionEnabled = NO;
    }
    
    return _webView;
}
@end
