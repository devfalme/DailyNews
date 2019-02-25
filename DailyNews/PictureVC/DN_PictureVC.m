//
//  DN_PictureVC.m
//  DailyNews
//
//  Created by devfalme on 2019/1/6.
//  Copyright © 2019 devfalme. All rights reserved.
//

#import "DN_PictureVC.h"
#import "DN_PictureCell.h"
#import "UICollectionView+SideRefresh.h"
#import <AFNetworking/AFNetworking.h>
#import <Photos/Photos.h>
#import "UIViewController+CWLateralSlide.h"

@interface DN_PictureVC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, retain) NSMutableArray<DN_PictureModel *> *models;
@property (nonatomic, retain) UICollectionView *collectionView;

@property (nonatomic, retain) UIViewController *leftVC;
@property (nonatomic) NSUInteger page;
@end

@implementation DN_PictureVC
ROUTER_PATH(@"PictureVC")

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.models = [NSMutableArray array];
    [self layoutCollectionView];
    
    self.leftVC = [Router search:ROUTER_API(@"PictureLeftVC") parameters:@{@"selectAction":^(NSString *key) {
        [self.navigationController pushURL:ROUTER_API(@"PictureContentVC") parameters:@{@"key":key} animated:YES completion:nil];
    }}];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"webControl4"]forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view).offset(isIphoneX?44:20);
        make.size.mas_equalTo(CGSizeMake(49, 49));
    }];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        CWLateralSlideConfiguration *cfg = [[CWLateralSlideConfiguration alloc]initWithDistance:230 maskAlpha:.5 scaleY:100 direction:CWDrawerTransitionFromLeft backImage:nil];
        [self cw_showDrawerViewController:self.leftVC animationType:CWDrawerAnimationTypeMask configuration:cfg];
    }];
    [self loadData];
}

- (void)firstGuide {
    UIImageView *image = [[UIImageView alloc]init];
    image.animationImages = @[[UIImage imageNamed:@"Up1"],[UIImage imageNamed:@"Up2"],[UIImage imageNamed:@"Up3"],[UIImage imageNamed:@"Up4"]];
    image.animationDuration = 1.5;
    image.animationRepeatCount = 0;
    [self.view addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-20.0);
        make.size.mas_equalTo(CGSizeMake(40.0, 40.0));
    }];
    
    [image startAnimating];
    
//    if (@available(iOS 10.0, *)) {
    [[NSTimer timerWithTimeInterval:4.0 repeats:NO block:^(NSTimer * _Nonnull timer) {
        isFirst = NO;
        [image stopAnimating];
        [image removeFromSuperview];
        [timer invalidate];
    }] fire] ;
//    } else {
    
//    }
}

- (void)layoutCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
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
    [self.collectionView registerNib:[UINib nibWithNibName:@"DN_PictureCell" bundle:nil] forCellWithReuseIdentifier:@"DN_PictureCell"];
    self.collectionView.sideRefreshHeader = [SideRefreshHeader refreshWithLoadAction:^{
        get(PictureDetail(@"today_plus", @(1)), ^(id data) {
            self.models = [NSMutableArray array];
            self.page = 2;
            for (NSDictionary *dic in data) {
                if (!dic[@"cover"]) {
                    continue;
                }
                [self.models addObject:[[DN_PictureModel alloc]initWithDict:dic]];
            }
            if (isFirst) {
                [self firstGuide];
            }
            [self.collectionView.sideRefreshHeader endLoading];
            [self.collectionView reloadData];
        }, ^{
            self.showError(@"請求數據失敗");
            [self.collectionView.sideRefreshHeader endLoading];
        });
    }];
    
    
    self.collectionView.sideRefreshFooter = [SideRefreshFooter refreshWithLoadAction:^{
        get(PictureDetail(@"today_plus", @(self.page)), ^(id data) {
            
            self.page += 1;
            for (NSDictionary *dic in data) {
                if (!dic[@"cover"]) {
                    continue;
                }
                [self.models addObject:[[DN_PictureModel alloc]initWithDict:dic]];
            }
            [self.collectionView.sideRefreshFooter endLoading];
            [self.collectionView reloadData];
        }, ^{
            self.showError(@"請求數據失敗");
            [self.collectionView.sideRefreshFooter endLoading];
        });
    }];
    


}


- (void)loadData {
#ifdef DEBUG
    self.models = [NSMutableArray array];
    NSArray *datas = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"picture.plist" ofType:nil]];

    for (NSDictionary *dict in datas) {
        DN_PictureModel *model = [[DN_PictureModel alloc]initWithDict:dict];
        [self.models addObject:model];
    }
    [self.collectionView.sideRefreshHeader endLoading];
    [self.collectionView reloadData];
#else
    NSString *imageName = [NSString stringWithFormat:@"Loading%d", arc4random_uniform(11) + 1];
    [self showEmptyViewWithLoading:YES image:[UIImage imageNamed:imageName] text:@"數據加載中..." detailText:nil buttonTitle:nil buttonAction:nil];
    
    get(PictureDetail(@"today_plus", @(1)), ^(id data) {
        self.models = [NSMutableArray array];
        self.page = 2;
        for (NSDictionary *dic in data) {
            if (!dic[@"cover"]) {
                continue;
            }
            [self.models addObject:[[DN_PictureModel alloc]initWithDict:dic]];
        }
        if (isFirst) {
            [self firstGuide];
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
    DN_PictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DN_PictureCell" forIndexPath:indexPath];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    DN_PictureModel *model = self.models[indexPath.row];
    [(DN_PictureCell *)cell model:model save:^{
        [self saveImage:isIphoneX?model.cover_hd_812h:model.cover_hd_568h];
    } share:^{
        NSURL *url = model.cover_hd_568h;
        UIImage *image = [UIImage imageNamed:@"Share"];
        NSString *str = model.title_wechat;
        NSArray *activityItems = @[str,image,url];
        UIActivityViewController *activityViewController =
        [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
        [self presentViewController:activityViewController animated:YES completion:nil];
        [activityViewController setCompletionWithItemsHandler:^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
            if (completed) {
                self.showSuccess(@"分享成功！");
            }
        }];
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


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if(error){
        self.showError(@"保存失敗");
    }else{
        self.showSuccess(@"保存成功");
    }
}

- (void)downloadImage:(NSURL *)url {
    AFHTTPSessionManager *a = [AFHTTPSessionManager manager];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    NSURLSessionDownloadTask *task = [a downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSString *progress = [NSString stringWithFormat:@"%d%%", (int)((CGFloat)downloadProgress.completedUnitCount/(CGFloat)downloadProgress.totalUnitCount * 100)];
        self.showProgress(progress);
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        NSString *fileName = [NSString stringWithFormat:@"%@%@", @([[NSDate date] timeIntervalSince1970]), [response suggestedFilename]];
        NSURL *url = [documentsDirectoryURL URLByAppendingPathComponent:fileName];
        return url;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        self.hidenProgress();
        NSData *data = [NSData dataWithContentsOfURL:filePath];
        UIImage *img = [UIImage imageWithData:data];
        UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }];
    [task resume];
}

- (void)saveImage:(NSURL *)url {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusNotDetermined || status == PHAuthorizationStatusAuthorized) {
            self.showProgress(@"0%");
            [self downloadImage:url];
        }else{
            self.showError(@"請在系統設置中開啟相冊權限");
        }
    }];
}

- (BOOL)preferredNavigationBarHidden {
    return YES;
}
@end
