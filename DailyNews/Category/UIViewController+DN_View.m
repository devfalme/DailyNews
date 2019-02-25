//
//  UIViewController+DN_View.m
//  DailyNews
//
//  Created by devfalme on 2019/1/6.
//  Copyright © 2019 devfalme. All rights reserved.
//

#import "UIViewController+DN_View.h"
#import <objc/runtime.h>
static char *_tips = "tips";
@implementation UIViewController (DN_View)
- (void(^)(NSString *))showLoading {
    return ^void(NSString *aMsg) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [QMUITips hideAllTips];
            QMUITips *tips = [QMUITips showLoading:aMsg inView:DefaultTipsParentView];
            QMUIToastBackgroundView *backgroundView = (QMUIToastBackgroundView *)tips.backgroundView;
            backgroundView.shouldBlurBackgroundView = YES;
            backgroundView.styleColor = [UIColor qmui_colorWithHexString:@"FEFEFE"];
            tips.tintColor = darkColor;
            
        });
        
    };
}

- (void(^)(NSString *))showProgress {
    return ^void(NSString *aMsg) {
        dispatch_async(dispatch_get_main_queue(), ^{
            QMUITips *tips = objc_getAssociatedObject(self, _tips);
            if (tips) {
                [tips showLoading:@"正在下載高清圖片..." detailText:aMsg];
            }else{
                QMUITips *tips = [QMUITips showLoading:@"正在下載高清圖片..." detailText:aMsg inView:DefaultTipsParentView];
                QMUIToastBackgroundView *backgroundView = (QMUIToastBackgroundView *)tips.backgroundView;
                backgroundView.shouldBlurBackgroundView = YES;
                backgroundView.styleColor = [UIColor qmui_colorWithHexString:@"FEFEFE"];
                tips.tintColor = darkColor;
                objc_setAssociatedObject(self, _tips, tips, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        });
        
    };
}

- (void (^)(void))hidenProgress {
    return ^void() {
        dispatch_async(dispatch_get_main_queue(), ^{
            [QMUITips hideAllTips];
            objc_setAssociatedObject(self, _tips, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        });
    };
}

- (void (^)(NSString *))showText {
    return ^void(NSString *aMsg) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [QMUITips hideAllTips];
            QMUITips *tips = [QMUITips showInfo:aMsg];
            QMUIToastBackgroundView *backgroundView = (QMUIToastBackgroundView *)tips.backgroundView;
            backgroundView.shouldBlurBackgroundView = YES;
            backgroundView.styleColor = [UIColor qmui_colorWithHexString:@"FEFEFE"];
            tips.tintColor = darkColor;
        });
    };
}

- (void (^)(void))hideHud {
    return ^void() {
        dispatch_async(dispatch_get_main_queue(), ^{
            [QMUITips hideAllTips];
        });
    };
}
- (void (^)(NSInteger))hideHudWhen {
    return ^void(NSInteger aTime) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(aTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [QMUITips hideAllTips];
        });
    };
}

- (void (^)(NSString *))showError {
    return ^void(NSString *aMsg) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [QMUITips hideAllTips];
            QMUITips *tips = [QMUITips showError:aMsg];
            QMUIToastBackgroundView *backgroundView = (QMUIToastBackgroundView *)tips.backgroundView;
            backgroundView.shouldBlurBackgroundView = YES;
            backgroundView.styleColor = [UIColor qmui_colorWithHexString:@"FEFEFE"];
            tips.tintColor = darkColor;
        });
    };
}

- (void (^)(NSString *))showSuccess {
    return ^void(NSString *aMsg) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [QMUITips hideAllTips];
            QMUITips *tips = [QMUITips showSucceed:aMsg];
            QMUIToastBackgroundView *backgroundView = (QMUIToastBackgroundView *)tips.backgroundView;
            backgroundView.shouldBlurBackgroundView = YES;
            backgroundView.styleColor = [UIColor qmui_colorWithHexString:@"FEFEFE"];
            tips.tintColor = darkColor;
        });
    };
}
@end
