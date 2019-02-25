//
//  UIViewController+DN_View.h
//  DailyNews
//
//  Created by devfalme on 2019/1/6.
//  Copyright © 2019 devfalme. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (DN_View)
@property (nonatomic, readonly, copy) void(^showLoading)(NSString *msg);
@property (nonatomic, readonly, copy) void(^showText)(NSString *msg);
@property (nonatomic, readonly, copy) void(^hideHud)(void);
@property (nonatomic, readonly, copy) void(^hideHudWhen)(NSInteger time);
@property (nonatomic, readonly, copy) void(^showError)(NSString *msg);
@property (nonatomic, readonly, copy) void(^showSuccess)(NSString *msg);
@property (nonatomic, readonly, copy) void(^showProgress)(NSString *msg);
@property (nonatomic, readonly, copy) void(^hidenProgress)(void);
@end

NS_ASSUME_NONNULL_END
