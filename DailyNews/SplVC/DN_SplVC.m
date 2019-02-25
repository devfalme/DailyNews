//
//  DN_SplVC.m
//  DailyNews
//
//  Created by devfalme on 2019/1/7.
//  Copyright © 2019 devfalme. All rights reserved.
//

#import "DN_SplVC.h"

@interface DN_SplVC ()
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (nonatomic, copy) NSString *spider;
@end

@implementation DN_SplVC

ROUTER_PATH(@"splvc")

- (void)viewDidLoad {
    [super viewDidLoad];
    self.spider = @"SplVC";
    [UIView animateWithDuration:.6 animations:^{
        self.image.transform = CGAffineTransformMakeScale(1.5, 1.5);
        self.image.alpha = 0;
    } completion:^(BOOL finished) {
        if (isFirst) {
            typedef void (^Animation)(void);
            UIWindow *window = [UIApplication sharedApplication].delegate.window;
            
            Animation animation = ^{
                BOOL oldState = [UIView areAnimationsEnabled];
                [UIView setAnimationsEnabled:NO];
                window.rootViewController = [Router search:ROUTER_API(@"Guide")];
                [UIView setAnimationsEnabled:oldState];
            };
            
            [UIView transitionWithView:window
                              duration:0.5f
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:animation
                            completion:nil];
        }else{
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
    }];
}



@end
