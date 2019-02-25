//
//  DN_PictureLeftVC.m
//  DailyNews
//
//  Created by devfalme on 2019/1/7.
//  Copyright © 2019 devfalme. All rights reserved.
//

#import "DN_PictureLeftVC.h"

@interface DN_PictureLeftVC () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSArray<NSString *> *titles;
@property (nonatomic, retain) NSArray<NSString *> *keys;
@property (nonatomic, copy) void(^selectAction)(NSString *title);
@end

@implementation DN_PictureLeftVC

ROUTER_PATH(@"PictureLeftVC")

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
                        @"城市",
                        @"宇宙",
                        @"藝術",
                        @"動物",
                        @"文明",
                        @"人物",
                        @"文化",
                        @"自然",
                        @"風尚",
                        @"紋理",
                        ];
    }return _titles;
}
- (NSArray<NSString *> *)keys {
    if (!_keys) {
        self.keys = @[
                        @"city_plus",
                        @"universe_plus",
                        @"art_plus",
                        @"animal_plus",
                        @"nk_plus",
                        @"people_plus",
                        @"culture_plus",
                        @"nature_plus",
                        @"fashion_plus",
                        @"pattern_plus",
                        ];
    }return _keys;
}
@end
