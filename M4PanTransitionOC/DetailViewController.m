//
//  DetailViewController.m
//  M4PanTransitionOC
//
//  Created by Chen,Meisong on 2019/5/26.
//  Copyright © 2019 xyz.chenms. All rights reserved.
//

#import "DetailViewController.h"
#import "NormalPopAnimator.h"
#import "M7ScreenEdgePanInteractiveTransition.h"
#import "NoPopAnimator.h"
#import "PanPopInteractor.h"
#import "ShareItemAnimator.h"

@interface DetailViewController ()<
UINavigationControllerDelegate
, ShareItemAnimatorable>
@property (nonatomic) UIButton *popButton;
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UILabel *someLabel;
@property (nonatomic) NormalPopAnimator *normalPopAnimator;
@property (nonatomic) id<UINavigationControllerDelegate> originNaviDelegate;
@property (nonatomic) M7ScreenEdgePanInteractiveTransition *screenEdgePanInteractor;
@property (nonatomic) NoPopAnimator *popAnimator;
@property (nonatomic) PanPopInteractor *panPopInteractor;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.popButton];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.someLabel];
    
//    [self.screenEdgePanInteractor bindViewController:self];
    [self.panPopInteractor bindViewController:self];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.popButton.frame = CGRectMake(20, 64, 100, 40);
    self.imageView.frame = CGRectMake(20, CGRectGetMaxY(self.popButton.frame), 300, 200);
    self.someLabel.frame = CGRectMake(20, CGRectGetMaxY(self.imageView.frame), 300, 40);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.originNaviDelegate = self.navigationController.delegate;
    self.navigationController.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.delegate = self.originNaviDelegate;
}

#pragma mark - UINavigationControllerDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  {
    if (operation == UINavigationControllerOperationPop) {
        return self.popAnimator;
    }
    
    return nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    if (animationController == self.popAnimator
        && self.panPopInteractor.isInteracting) {
        self.panPopInteractor.animator = self.popAnimator;
        
        return self.panPopInteractor;
    }

    return nil;
}

#pragma mark - ShareItemAnimatorable
- (UIView *)shareView {
    [self.view layoutIfNeeded];
    
    return self.imageView;
}

#pragma mark - Event
- (void)onTapPop {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Getter
- (UIButton *)popButton {
    if (!_popButton) {
        _popButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_popButton setTitle:@"Pop" forState:UIControlStateNormal];
        [_popButton addTarget:self action:@selector(onTapPop) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _popButton;
}

- (NormalPopAnimator *)normalPopAnimator {
    if (!_normalPopAnimator) {
        _normalPopAnimator = [NormalPopAnimator new];
    }
    
    return _normalPopAnimator;
}

- (M7ScreenEdgePanInteractiveTransition *)screenEdgePanInteractor {
    if (!_screenEdgePanInteractor) {
        _screenEdgePanInteractor = [M7ScreenEdgePanInteractiveTransition new];
    }
    
    return _screenEdgePanInteractor;
}
- (NoPopAnimator *)popAnimator {
    if (!_popAnimator) {
        _popAnimator = [NoPopAnimator new];
    }
    
    return _popAnimator;
}
- (PanPopInteractor *)panPopInteractor {
    if (!_panPopInteractor) {
        _panPopInteractor = [PanPopInteractor new];
    }
    
    return _panPopInteractor;
}
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.backgroundColor = [UIColor redColor];
    }
    
    return _imageView;
}
- (UILabel *)someLabel {
    if (!_someLabel) {
        _someLabel = [UILabel new];
        _someLabel.text = @"就是占个位置";
    }
    
    return _someLabel;
}
@end
