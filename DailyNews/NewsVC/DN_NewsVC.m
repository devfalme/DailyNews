//
//  DN_NewsVC.m
//  DailyNews
//
//  Created by devfalme on 2019/1/5.
//  Copyright © 2019 devfalme. All rights reserved.
//

#import "DN_NewsVC.h"
#import "DN_NewsCell.h"
#import "DN_NewsDetailVC.h"
#import "UICollectionView+SideRefresh.h"
#import "DN_NewsFlowLayout.h"

#import "UIViewController+CWLateralSlide.h"

@interface DN_NewsVC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, retain) NSMutableArray<DN_NewsModel *> *models;
@property (nonatomic, retain) NSIndexPath *selectIndexPath;

@property (nonatomic, retain) UICollectionView *collectionView;

@property (nonatomic) NSUInteger page;

@property (nonatomic, retain) UIViewController *leftVC;
@end

@implementation DN_NewsVC

ROUTER_PATH(@"NewsVC")


- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.models = [NSMutableArray array];
    [self layoutCollectionView];
    
    [self loadData];
    
    self.leftVC = [Router search:ROUTER_API(@"NewsLeftVC") parameters:@{@"selectAction":^(NSString *key) {
        [self.navigationController pushURL:ROUTER_API(@"NewsYearsVC") parameters:@{@"key":key} animated:YES completion:nil];
    }}];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"Years1"]forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10.0);
        make.top.equalTo(self.view).offset(isIphoneX?44:20);
        make.size.mas_equalTo(CGSizeMake(34, 34));
    }];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        CWLateralSlideConfiguration *cfg = [[CWLateralSlideConfiguration alloc]initWithDistance:230 maskAlpha:.5 scaleY:100 direction:CWDrawerTransitionFromLeft backImage:nil];
        [self cw_showDrawerViewController:self.leftVC animationType:CWDrawerAnimationTypeMask configuration:cfg];
    }];
    
}

- (void)layoutCollectionView {
    DN_NewsFlowLayout *layout = [[DN_NewsFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = lightColor;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = YES;
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(isIphoneX?44:20);
        make.left.bottom.right.equalTo(self.view);
    }];
    [self.collectionView registerNib:[UINib nibWithNibName:@"DN_NewsCell" bundle:nil] forCellWithReuseIdentifier:@"DN_NewsCell"];
    
        self.collectionView.sideRefreshHeader = [SideRefreshHeader refreshWithLoadAction:^{
            get(NewsList(@(1)), ^(id data) {
                self.models = [NSMutableArray array];
                self.page = 2;
                for (NSDictionary *dic in data) {
                    if (dic[@"is_banner"]) {
                        continue;
                    }
                    [self.models addObject:[[DN_NewsModel alloc]initWithDict:dic]];
                }
                [self.collectionView.sideRefreshHeader endLoading];
                [self.collectionView reloadData];
            }, ^{
                self.showError(@"請求數據失敗");
                [self.collectionView.sideRefreshHeader endLoading];
            });
        }];
    
    
        self.collectionView.sideRefreshFooter = [SideRefreshFooter refreshWithLoadAction:^{
            get(NewsList(@(self.page)), ^(id data) {
                self.page +=1;
                for (NSDictionary *dic in data) {
                    if (dic[@"is_banner"]) {
                        continue;
                    }
                    [self.models addObject:[[DN_NewsModel alloc]initWithDict:dic]];
                }
                [self.collectionView.sideRefreshFooter endLoading];
                [self.collectionView reloadData];
            }, ^{
                self.showError(@"請求數據失敗");
                [self.collectionView.sideRefreshFooter endLoading];
            });
        }];
    //
    //
}


- (void)loadData {
    
#ifdef DEBUG
    
    self.models = [NSMutableArray array];
    NSArray *datas = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"news.plist" ofType:nil]];

    for (NSDictionary *dict in datas) {
        if (dict[@"is_banner"]) {
            continue;
        }
        DN_NewsModel *model = [[DN_NewsModel alloc]initWithDict:dict];
        [self.models addObject:model];
    }
    [self.collectionView.sideRefreshHeader endLoading];
    [self.collectionView reloadData];
#else
    NSString *imageName = [NSString stringWithFormat:@"Loading%d", arc4random_uniform(11) + 1];
    [self showEmptyViewWithLoading:YES image:[UIImage imageNamed:imageName] text:@"數據加載中..." detailText:nil buttonTitle:nil buttonAction:nil];
    get(NewsList(@(1)), ^(id data) {
        self.models = [NSMutableArray array];
        self.page = 2;
        for (NSDictionary *dic in data) {
            if (dic[@"is_banner"]) {
                continue;
            }
            [self.models addObject:[[DN_NewsModel alloc]initWithDict:dic]];
        }
        [self hideEmptyView];
        [self.collectionView reloadData];
    }, ^{
        self.showError(@"請求數據失敗, 請右拉再次請求數據");
        [self hideEmptyView];
    });
#endif
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.models.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DN_NewsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DN_NewsCell" forIndexPath:indexPath];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    DN_NewsModel *model = self.models[indexPath.row];
    [(DN_NewsCell *)cell model:model action:^{
        [self.navigationController pushURL:ROUTER_API(@"NewsDetailVC")
                                parameters:@{@"hidesBottomBarWhenPushed":@(YES), @"newsId":model.newsId, @"title":model.title}
                                  animated:YES
                                completion:nil];
    }];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SCREEN_WIDTH, collectionView.qmui_height);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (BOOL)preferredNavigationBarHidden {
    return YES;
}
@end
