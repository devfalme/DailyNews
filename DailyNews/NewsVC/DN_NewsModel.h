//
//  DN_NewsModel.h
//  DailyNews
//
//  Created by devfalme on 2019/1/5.
//  Copyright © 2019 devfalme. All rights reserved.
//

#import "DN_BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DN_NewsModel : DN_BaseModel
@property (nonatomic, copy) NSString *newsId;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, retain) NSURL *thumbImage;
@property (nonatomic, retain) NSURL *hdImage;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *topic;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic, copy) NSString *topicId;
@end

NS_ASSUME_NONNULL_END
