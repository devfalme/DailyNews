//
//  DN_TabbarVC.m
//  DailyNews
//
//  Created by devfalme on 2019/1/5.
//  Copyright © 2019 devfalme. All rights reserved.
//

#import "DN_TabbarVC.h"
#import "DN_BaseNavigationVC.h"
@interface DN_TabbarVC ()

@end

@implementation DN_TabbarVC

ROUTER_PATH(@"TabbarVC")


- (void)viewDidLoad {
    [super viewDidLoad];
    UIViewController *news = [Router search:ROUTER_API(@"NewsVC")];
    [self setViewController:news title:@"咨詢" image:@"News" selectImage:@"NewsHighlight"];
    
    UIViewController *picVC = [Router search:ROUTER_API(@"PictureVC")];
    [self setViewController:picVC title:@"畫報" image:@"Picture" selectImage:@"PictureHighlight"];
}

#pragma mark - 添加子控制器
-(void)setViewController:(UIViewController *)viewController title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage {
    static NSInteger index = 0;
    viewController.tabBarItem.title = title;
    viewController.title = title;
    viewController.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.tag = index;
    index++;
    

    DN_BaseNavigationVC *nav = [[DN_BaseNavigationVC alloc]initWithRootViewController:viewController];
    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor qmui_colorWithHexString:@"9FA4AC"]} forState:UIControlStateNormal];
    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor qmui_colorWithHexString:@"43415B"]} forState:UIControlStateSelected];
    
    [self addChildViewController:nav];
}


@end
