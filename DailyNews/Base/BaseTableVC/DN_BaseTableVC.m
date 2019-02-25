//
//  DN_BaseTableVC.m
//  DailyNews
//
//  Created by devfalme on 2019/1/5.
//  Copyright © 2019 devfalme. All rights reserved.
//

#import "DN_BaseTableVC.h"

@interface DN_BaseTableVC ()

@end

@implementation DN_BaseTableVC

//- (void)viewWillDisappear:(BOOL)animated {
//    [[IQKeyboardManager sharedManager] resignFirstResponder];
//    self.hideHud();
//    [super viewWillDisappear:animated];
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[SDImageCache sharedImageCache] clearMemory];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = lightColor;
    self.tableView.backgroundColor = lightColor;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.supportedOrientationMask = UIInterfaceOrientationMaskPortrait;
}


- (BOOL)shouldCustomizeNavigationBarTransitionIfHideable {
    return YES;
}

- (nullable UIColor *)titleViewTintColor {
    return darkColor;
}

- (nullable UIColor *)navigationBarBarTintColor {
    return lightColor;
}

- (nullable UIColor *)navigationBarTintColor {
    return darkColor;
}

@end
