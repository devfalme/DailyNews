//
//  DN_NewsYearsVC.m
//  DailyNews
//
//  Created by devfalme on 2019/1/11.
//  Copyright © 2019 devfalme. All rights reserved.
//

#import "DN_NewsYearsVC.h"
#import "DN_NewsYearsHeaderView.h"
#import "DN_NewsYearsCell.h"
#import "DN_NewsYearSectionView.h"

@interface DN_NewsYearsVC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, copy) NSString *key;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, retain) NSArray <NSDictionary<NSString *, NSArray<DN_NewsYearsModel *> *> *>*models;

@end

@implementation DN_NewsYearsVC

ROUTER_PATH(@"NewsYearsVC")


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"%@年度資訊", self.key];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"DN_NewsYearsHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"DN_NewsYearsHeaderView"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"DN_NewsYearSectionView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"DN_NewsYearSectionView"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"DN_NewsYearsCell" bundle:nil] forCellWithReuseIdentifier:@"DN_NewsYearsCell"];
    
    
    
    [self loadData];
}

- (void)loadData {
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@Group", self.key] ofType:@"plist"];
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *models = [NSMutableArray array];
    for (NSDictionary *i in arr) {
        NSArray *obj = [i allValues][0];
        NSMutableArray *modelArr = [NSMutableArray array];
        for (NSDictionary *x in obj) {
            DN_NewsYearsModel *model = [[DN_NewsYearsModel alloc]initWithDict:x];
            [modelArr addObject:model];
        }
        NSDictionary *modelDic = [NSDictionary dictionaryWithObject:modelArr forKey:[i allKeys][0]];
        [models addObject:modelDic];
    }
    [models insertObject:[NSDictionary dictionary] atIndex:0];
    self.models = models;
    [self.collectionView reloadData];
}


- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section) {
        [(DN_NewsYearsCell *)cell model:[self.models[indexPath.section] allValues][0][indexPath.row]];
    }
}


- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [(DN_NewsYearsHeaderView *)view title:self.key];
    }else{
        [(DN_NewsYearSectionView *)view title:[self.models[indexPath.section] allValues][0][0].title];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.models.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section) {
        return [self.models[section] allValues][0].count;
    }else{
        return 0;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section) {
        DN_NewsYearsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DN_NewsYearsCell" forIndexPath:indexPath];
        return cell;
    }else{
        return [UICollectionViewCell new];
        
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        DN_NewsYearsHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"DN_NewsYearsHeaderView" forIndexPath:indexPath];
        return headerView;
    }else{
        DN_NewsYearSectionView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"DN_NewsYearSectionView" forIndexPath:indexPath];
        return headerView;
    }
    
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((SCREEN_WIDTH - 60.0) / 3.0, ((SCREEN_WIDTH - 60.0) / 3.0)/3.0*2.0);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 20, 0, 20);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section) {
        return CGSizeMake(SCREEN_WIDTH, 40.0);
    }else{
        return CGSizeMake(SCREEN_WIDTH, (SCREEN_WIDTH - 40.0)/15.0 * 7.0 + 10.0);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *arr = [self.models[indexPath.section] allValues][0];
    [self.navigationController pushURL:ROUTER_API(@"NewsYearsContentVC") parameters:@{@"models":arr, @"row":@(indexPath.row)} animated:YES completion:nil];
}

@end
