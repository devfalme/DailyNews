//
//  DN_NewsLeftVC.m
//  DailyNews
//
//  Created by devfalme on 2019/1/11.
//  Copyright © 2019 devfalme. All rights reserved.
//

#import "DN_NewsLeftVC.h"

@interface DN_NewsLeftVC () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSArray<NSString *> *titles;
@property (nonatomic, retain) NSArray<NSString *> *keys;
@property (nonatomic, copy) void(^selectAction)(NSString *title);
@end

@implementation DN_NewsLeftVC

ROUTER_PATH(@"NewsLeftVC")

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.titles[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self dismissViewControllerAnimated:YES completion:^{
        self.selectAction(self.keys[indexPath.row]);
    }];
    
}

- (NSArray<NSString *> *)titles {
    if (!_titles) {
        self.titles = @[
                        @"2018年度特別冊",
                        @"2017年度特別冊",
                        ];
    }return _titles;
}
- (NSArray<NSString *> *)keys {
    if (!_keys) {
        self.keys = @[
                      @"2018",
                      @"2017",
                      ];
    }return _keys;
}
@end
