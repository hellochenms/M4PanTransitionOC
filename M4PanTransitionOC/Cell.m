//
//  Cell.m
//  M4PanTransitionOC
//
//  Created by Chen,Meisong on 2019/5/26.
//  Copyright © 2019 xyz.chenms. All rights reserved.
//

#import "Cell.h"

@interface Cell ()
@property (nonatomic) UIImageView *someView;
@end

@implementation Cell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.someView];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.someView.frame = self.contentView.bounds;
}

#pragma mark - Getter
- (UIImageView *)someView {
    if (!_someView) {
        _someView = [UIImageView new];
        _someView.backgroundColor = [UIColor blueColor];
    }
    
    return _someView;
}

@end
