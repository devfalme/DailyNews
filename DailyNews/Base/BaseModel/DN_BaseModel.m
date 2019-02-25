//
//  DN_BaseModel.m
//  DailyNews
//
//  Created by devfalme on 2019/1/5.
//  Copyright © 2019 devfalme. All rights reserved.
//

#import "DN_BaseModel.h"
#import <YYModel/YYModel.h>
@implementation DN_BaseModel
- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self yy_modelSetWithDictionary:dict];
    }return self;
}
@end
