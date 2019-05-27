//
//  DetailViewController.m
//  M4PanTransitionOC
//
//  Created by Chen,Meisong on 2019/5/26.
//  Copyright © 2019 xyz.chenms. All rights reserved.
//

#import "DetailViewController.h"
#import "NormalPopAnimator.h"
#import "NoPopAnimator.h"
#import "PanPopInteractor.h"

@interface DetailViewController ()<
UINavigationControllerDelegate>
@property (nonatomic) UIButton *popButton;
@property (nonatomic) UIView *imageContainer;
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UILabel *someLabel;
@property (nonatomic) NormalPopAnimator *normalPopAnimator;
@property (nonatomic) id<UINavigationControllerDelegate> originNaviDelegate;
@property (nonatomic) M7ScreenEdgePanInteractiveTransition *screenEdgePanInteractor;
@property (nonatomic) NoPopAnimator *noPopAnimator;
@property (nonatomic) PanPopInteractor *panPopInteractor;
@property (nonatomic) RealShareItemPopAnimator *realShareItemPopAnimator;
@property (nonatomic) RealPanPopInteractor *realPanPopInteractor;

@property (nonatomic, weak) id<UIViewControllerAnimatedTransitioning> curPopAnimator;

@property (nonatomic, weak) UIView *rShareView;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.popButton];
    [self.view addSubview:self.imageContainer];
//    [self.imageContainer addSubview:self.imageView];
    [self.view addSubview:self.someLabel];
    
    [self.screenEdgePanInteractor bindViewController:self];
//    [self.panPopInteractor bindViewController:self];
    [self.realPanPopInteractor bindViewController:self];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.popButton.frame = CGRectMake(20, 64, 100, 40);
    self.imageContainer.frame = CGRectMake(20, CGRectGetMaxY(self.popButton.frame), 300, 200);
//    self.imageView.frame = self.imageContainer.bounds;
    self.someLabel.frame = CGRectMake(20, CGRectGetMaxY(self.imageContainer.frame), 300, 40);
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
        NSLog(@"【m2】self.curPopAnimator:%@  %s", self.curPopAnimator, __func__);
        return self.curPopAnimator;
    }
    
    return nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    NSLog(@"【m2】animationController:%@  %s", animationController, __func__);
    if (animationController == self.noPopAnimator
        && self.panPopInteractor.isInteracting) {
        self.panPopInteractor.animator = animationController;

        return self.panPopInteractor;
    } else if (animationController == self.realShareItemPopAnimator
               && self.realPanPopInteractor.isInteracting) {
        self.realPanPopInteractor.animator = animationController;
        
        return self.realPanPopInteractor;
    } else if (animationController == self.normalPopAnimator) {
        return self.screenEdgePanInteractor;
    }

    return nil;
}

#pragma mark - ShareItemAnimatorable
- (UIView *)shareView {
    [self.view layoutIfNeeded];
    
    return self.imageContainer;
}

#pragma mark - RealShareItemAnimatorable
- (UIView *)realShareView {
//    [self.view layoutIfNeeded];
    
    return self.rShareView;
}

- (UIView *)realShareViewContainer {
    [self.view layoutIfNeeded];
    
    return self.imageContainer;
}

- (void)didAddShareViewToContainer:(UIView *)shareView {
    self.rShareView = shareView;
}


#pragma mark - RealPanPopInteractorDelegate
- (void)willBeginPan:(RealPanPopInteractor *)interactor {
    self.curPopAnimator = self.realShareItemPopAnimator;
}
#pragma mark - M7ScreenEdgePanInteractiveTransitionDelegate
- (void)willBeginEdgePan:(M7ScreenEdgePanInteractiveTransition *)interactor {
    self.curPopAnimator = self.normalPopAnimator;
}

#pragma mark - Event
- (void)onTapPop {
    self.curPopAnimator = self.normalPopAnimator;
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
        _screenEdgePanInteractor.delegate = self;
    }
    
    return _screenEdgePanInteractor;
}
- (NoPopAnimator *)noPopAnimator {
    if (!_noPopAnimator) {
        _noPopAnimator = [NoPopAnimator new];
    }
    
    return _noPopAnimator;
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
- (UIView *)imageContainer {
    if (!_imageContainer) {
        _imageContainer = [UIView new];
    }
    
    return _imageContainer;
}
- (RealShareItemPopAnimator *)realShareItemPopAnimator {
    if (!_realShareItemPopAnimator) {
        _realShareItemPopAnimator = [RealShareItemPopAnimator new];
    }
    
    return _realShareItemPopAnimator;
}
- (RealPanPopInteractor *)realPanPopInteractor {
    if (!_realPanPopInteractor) {
        _realPanPopInteractor = [RealPanPopInteractor new];
        _realPanPopInteractor.delegate = self;
    }
    
    return _realPanPopInteractor;
}
@end
