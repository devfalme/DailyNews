//
//  DN_AnootationModel.m
//  DailyNews
//
//  Created by devfalme on 2019/1/6.
//  Copyright © 2019 devfalme. All rights reserved.
//

#import "DN_AnootationModel.h"

@implementation DN_AnootationModel
+ (instancetype)coordinate:(CLLocationCoordinate2D)coordinate titile:(NSString *)titile {
    DN_AnootationModel *model = [[DN_AnootationModel alloc]init];
    model.coordinate = coordinate;
    model.title = titile;
    return model;
}
@end
