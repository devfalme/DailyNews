//
//  DN_NewsCell.h
//  DailyNews
//
//  Created by devfalme on 2019/1/6.
//  Copyright © 2019 devfalme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DN_NewsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DN_NewsCell : UICollectionViewCell

- (void)model:(DN_NewsModel *)model action:(void(^)(void))action;

@end

NS_ASSUME_NONNULL_END
