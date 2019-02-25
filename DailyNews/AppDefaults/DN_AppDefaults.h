//
//  DN_AppDefaults.h
//  DailyNews
//
//  Created by devfalme on 2019/1/5.
//  Copyright © 2019 devfalme. All rights reserved.
//

#ifndef DN_AppDefaults_h
#define DN_AppDefaults_h

#define NewsList(page) [NSString stringWithFormat:@"http://idaily-cdn.idai.ly/api/list/v3/iphone/zh-hant?page=%@&ver=iphone&app_ver=81&app_timestamp=%@", page, today]
#define NewsDetail(newsId) [NSString stringWithFormat:@"http://idaily-cdn.idai.ly/api/news/related/%@/zh-hant?ver=iphone&app_ver=81&app_timestamp=%@", newsId, today]

#define PictureDetail(key, page) [NSString stringWithFormat:@"http://paper-cdn.2q10.com/api/list/%@/zh-hant?page=%@", key, page]

extern NSString *today;

extern UIColor *lightColor;
extern UIColor *grayColor;
extern UIColor *darkColor;

extern BOOL isIphoneX;
extern BOOL isFirst;
extern void appSetup(NSDictionary *launchOptions);

extern void disableDump(void);

extern void post(NSString *url, NSDictionary *parameter, void(^success)(id data), void(^fail)(void));
extern void get(NSString *url, void(^success)(id data), void(^fail)(void));

extern UIViewController * rootVC(void);


#endif /* DN_AppDefaults_h */
