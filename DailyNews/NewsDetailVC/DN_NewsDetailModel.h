//
//  DN_NewsDetailModel.h
//  DailyNews
//
//  Created by devfalme on 2019/1/6.
//  Copyright © 2019 devfalme. All rights reserved.
//

#import "DN_BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DN_NewsDetailModel : DN_BaseModel

@property (nonatomic, copy) NSString *pubdate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *link_source;

@end

NS_ASSUME_NONNULL_END
