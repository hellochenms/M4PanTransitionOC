//
//  ListViewController.m
//  M4PanTransitionOC
//
//  Created by Chen,Meisong on 2019/5/26.
//  Copyright © 2019 xyz.chenms. All rights reserved.
//

#import "ListViewController.h"
#import "M4TempListGenerator.h"
#import "Cell.h"
#import "DetailViewController.h"
#import "PushAnimator.h"
#import "ShareItemAnimator.h"

static NSString * const kCellIdentifier = @"kCellIdentifier";

@interface ListViewController ()<
UICollectionViewDataSource
, UICollectionViewDelegate
, UINavigationControllerDelegate
, ShareItemAnimatorable>
@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) NSArray *datas;
@property (nonatomic) PushAnimator *pushAnimator;
@property (nonatomic) ShareItemAnimator *shareItemAnimator;
@property (nonatomic) id<UINavigationControllerDelegate> originNaviDelegate;
@property (nonatomic) NSIndexPath *selectedIndexPath;
@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.collectionView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.collectionView.frame = self.view.bounds;
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
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.datas count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndexPath = indexPath;
    
    DetailViewController *detailVC = [DetailViewController new];
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - UINavigationControllerDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  {
    if (operation == UINavigationControllerOperationPush) {
        return self.shareItemAnimator;
    }
    
    return nil;
}

#pragma mark - ShareItemAnimatorable
- (UIView *)shareView {
    Cell *cell = (Cell *)[self.collectionView cellForItemAtIndexPath:self.selectedIndexPath];
    
    return cell.someView;
}

#pragma mark - Getter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(150, 150);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[Cell class] forCellWithReuseIdentifier:kCellIdentifier];
    }
    
    return _collectionView;
}

- (NSArray *)datas {
    if (!_datas) {
        _datas = [M4TempListGenerator indexArrayForCount:80];
    }
    
    return _datas;
}

- (PushAnimator *)pushAnimator {
    if (!_pushAnimator) {
        _pushAnimator = [PushAnimator new];
    }
    
    return _pushAnimator;
}

- (ShareItemAnimator *)shareItemAnimator {
    if (!_shareItemAnimator) {
        _shareItemAnimator = [ShareItemAnimator new];
    }
    
    return _shareItemAnimator;
}
@end
