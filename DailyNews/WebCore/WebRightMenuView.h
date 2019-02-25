//
//  WebRightMenuView.h
//  DailyNews
//
//  Created by devfalme on 2019/1/5.
//  Copyright © 2019 devfalme. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebRightMenuView : UIView

@property (nonatomic, assign) CGRect hiddenFrame;
@property (nonatomic, assign) CGRect showFrame;

- (void)showMenuAnimation;
- (void)hiddenMenuAnimation;


@end

NS_ASSUME_NONNULL_END
