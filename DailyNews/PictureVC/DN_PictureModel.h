//
//  DN_PictureModel.h
//  DailyNews
//
//  Created by devfalme on 2019/1/6.
//  Copyright © 2019 devfalme. All rights reserved.
//

#import "DN_BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DN_PictureModel : DN_BaseModel
@property (nonatomic, retain) NSURL *cover;
@property (nonatomic, retain) NSURL *cover_hd_568h;
@property (nonatomic, retain) NSURL *cover_hd_812h;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *pubdate;
@property (nonatomic, copy) NSString *content;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;

@property (nonatomic, copy) NSString *title_wechat;

@end

NS_ASSUME_NONNULL_END
