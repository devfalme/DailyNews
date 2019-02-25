//
//  DN_GuideVC.m
//  DailyNews
//
//  Created by devfalme on 2019/1/11.
//  Copyright © 2019 devfalme. All rights reserved.
//

#import "DN_GuideVC.h"

@interface DN_GuideVC ()

@end

@implementation DN_GuideVC

ROUTER_PATH(@"Guide")

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)turnTo:(id)sender {
    typedef void (^Animation)(void);
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    
    Animation animation = ^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        window.rootViewController = [Router search:ROUTER_API(@"TabbarVC")];
        [UIView setAnimationsEnabled:oldState];
    };
    
    [UIView transitionWithView:window
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:animation
                    completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
