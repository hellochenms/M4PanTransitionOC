//
//  DetailViewController.m
//  M4PanTransitionOC
//
//  Created by Chen,Meisong on 2019/5/26.
//  Copyright © 2019 xyz.chenms. All rights reserved.
//

#import "DetailViewController.h"
#import "NormalPopAnimator.h"

@interface DetailViewController ()<UINavigationControllerDelegate>
@property (nonatomic) UIButton *popButton;
@property (nonatomic) NormalPopAnimator *normalPopAnimator;
@property (nonatomic) id<UINavigationControllerDelegate> originNaviDelegate;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.popButton];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.popButton.frame = CGRectMake(20, 64, 100, 40);
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
        return self.normalPopAnimator;
    }
    
    return nil;
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

@end
