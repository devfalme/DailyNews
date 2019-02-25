//
//  DN_BaseVC.m
//  DailyNews
//
//  Created by devfalme on 2019/1/5.
//  Copyright © 2019 devfalme. All rights reserved.
//

#import "DN_BaseVC.h"

@interface DN_BaseVC ()

@end

@implementation DN_BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.supportedOrientationMask = UIInterfaceOrientationMaskPortrait;
    self.view.backgroundColor = lightColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[SDImageCache sharedImageCache] clearMemory];
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
