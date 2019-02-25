//
//  DN_NewsDetailCell.h
//  DailyNews
//
//  Created by devfalme on 2019/1/6.
//  Copyright © 2019 devfalme. All rights reserved.
//

#import "QMUITableViewCell.h"
#import "DN_NewsDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DN_NewsDetailCell : QMUITableViewCell


- (void)model:(DN_NewsDetailModel *)model;

@end

NS_ASSUME_NONNULL_END
