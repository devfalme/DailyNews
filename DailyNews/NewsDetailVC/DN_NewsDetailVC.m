//
//  DN_NewsDetailVC.m
//  DailyNews
//
//  Created by devfalme on 2019/1/5.
//  Copyright © 2019 devfalme. All rights reserved.
//

#import "DN_NewsDetailVC.h"
#import "DN_NewsDetailCell.h"
@interface DN_NewsDetailVC ()
@property (nonatomic, copy) NSString *newsId;
@property (nonatomic, retain) NSMutableArray<DN_NewsDetailModel *> *models;
@end

@implementation DN_NewsDetailVC

ROUTER_PATH(@"NewsDetailVC")

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        get(NewsDetail(self.newsId), ^(id data) {
            self.models = [NSMutableArray array];
            for (NSDictionary *dic in data[self.newsId]) {
                DN_NewsDetailModel *model = [[DN_NewsDetailModel alloc]initWithDict:dic];
                [self.models addObject:model];
            }
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
        }, ^{
            [self.tableView.mj_header endRefreshing];
        });
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DN_NewsDetailCell" bundle:nil] forCellReuseIdentifier:@"DN_NewsDetailCell"];
    
    [self.tableView.mj_header beginRefreshing];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DN_NewsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DN_NewsDetailCell"];
    [cell updateCellAppearanceWithIndexPath:indexPath];
    [(DN_NewsDetailCell *)cell model:self.models[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushURL:ROUTER_API(@"NewsContentVC") parameters:@{@"model":self.models[indexPath.row]} animated:YES completion:nil];
}
@end
