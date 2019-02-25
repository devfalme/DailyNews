//
//  DN_NewsYearsModel.h
//  DailyNews
//
//  Created by devfalme on 2019/1/11.
//  Copyright © 2019 devfalme. All rights reserved.
//

#import "DN_BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DN_NewsYearsModel : DN_BaseModel
@property (nonatomic, retain) NSURL *cover_thumb;
@property (nonatomic, retain) NSURL *cover_landscape;
@property (nonatomic, retain) NSURL *cover_landscape_hd;
@property (nonatomic, copy) NSString *content;
@property (nonatomic) NSInteger latitude;
@property (nonatomic) NSInteger longitude;
@property (nonatomic) NSInteger *news_count;
@property (nonatomic, copy) NSString *title;
@end

NS_ASSUME_NONNULL_END
