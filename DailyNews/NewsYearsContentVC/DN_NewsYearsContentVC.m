//
//  DN_NewsYearsContentVC.m
//  DailyNews
//
//  Created by devfalme on 2019/1/11.
//  Copyright © 2019 devfalme. All rights reserved.
//

#import "DN_NewsYearsContentVC.h"
#import "DN_NewsYearsContentCell.h"

@interface DN_NewsYearsContentVC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, retain) NSMutableArray<DN_NewsYearsModel *> *models;
@property (nonatomic) NSInteger row;
@end

@implementation DN_NewsYearsContentVC

ROUTER_PATH(@"NewsYearsContentVC")

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.models[0].title;
    self.collectionView.pagingEnabled = YES;
    [self.collectionView registerNib:[UINib nibWithNibName:@"DN_NewsYearsContentCell" bundle:nil] forCellWithReuseIdentifier:@"DN_NewsYearsContentCell"];
    [self.view layoutIfNeeded];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.row inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.models.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DN_NewsYearsContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DN_NewsYearsContentCell" forIndexPath:indexPath];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    DN_NewsYearsModel *model = self.models[indexPath.row];
    [(DN_NewsYearsContentCell *)cell model:model];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SCREEN_WIDTH, collectionView.qmui_height - 10);
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

@end
