//
//  DN_BaseNavigationVC.m
//  DailyNews
//
//  Created by devfalme on 2019/1/5.
//  Copyright © 2019 devfalme. All rights reserved.
//

#import "DN_BaseNavigationVC.h"

@implementation DN_BaseNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationBar.translucent = NO;
    [self.navigationBar setShadowImage:[UIImage new]];
    self.extendedLayoutIncludesOpaqueBars = YES;
}

@end
