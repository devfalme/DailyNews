//
//  DN_NewsModel.m
//  DailyNews
//
//  Created by devfalme on 2019/1/5.
//  Copyright © 2019 devfalme. All rights reserved.
//

#import "DN_NewsModel.h"

@implementation DN_NewsModel
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    if (dic[@"tags"]) {
        self.topic = [NSString stringWithFormat:@"%@", dic[@"tags"][0][@"name"]];
        self.topicId = [NSString stringWithFormat:@"%@", dic[@"tags"][0][@"id"]];
    }
    
    if (!self.thumbImage) {
        self.thumbImage = [NSURL URLWithString:[NSString stringWithFormat:@"%@", dic[@"cover_sq"]]];
    }
    if (!self.hdImage) {
        self.hdImage = [NSURL URLWithString:[NSString stringWithFormat:@"%@", dic[@"cover_sq_hd"]]];
    }
    return YES;
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"date":@"title",
             @"thumbImage":@"cover_landscape",
             @"hdImage":@"cover_landscape_hd",
             @"content":@"content",
             @"title":@"ui_sets.caption_subtitle",
             @"newsId":@"guid"
             };
}



@end
