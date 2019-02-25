//
//  DN_Network.h
//  DailyNews
//
//  Created by devfalme on 2019/1/6.
//  Copyright © 2019 devfalme. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DN_Network : NSObject

+ (void)post:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(NSDictionary *))success fail:(void(^)(void))fail;
+ (void)get:(NSString *)url success:(void(^)(NSDictionary *))success fail:(void(^)(void))fail;





@end

NS_ASSUME_NONNULL_END
