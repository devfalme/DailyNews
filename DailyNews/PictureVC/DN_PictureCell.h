//
//  DN_PictureCell.h
//  DailyNews
//
//  Created by devfalme on 2019/1/6.
//  Copyright © 2019 devfalme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DN_PictureModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DN_PictureCell : UICollectionViewCell

- (void)model:(DN_PictureModel *)model save:(void(^)(void))save share:(void(^)(void))share;



@end

NS_ASSUME_NONNULL_END
