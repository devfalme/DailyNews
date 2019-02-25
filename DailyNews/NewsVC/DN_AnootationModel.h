//
//  DN_AnootationModel.h
//  DailyNews
//
//  Created by devfalme on 2019/1/6.
//  Copyright © 2019 devfalme. All rights reserved.
//

#import "DN_BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DN_AnootationModel : DN_BaseModel <MKAnnotation>
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;

+ (instancetype)coordinate:(CLLocationCoordinate2D)coordinate titile:(NSString *)titile;
@end

NS_ASSUME_NONNULL_END
