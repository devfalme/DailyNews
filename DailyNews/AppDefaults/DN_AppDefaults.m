//
//  DN_AppDefaults.c
//  DailyNews
//
//  Created by devfalme on 2019/1/5.
//  Copyright © 2019 devfalme. All rights reserved.
//

#import "DN_AppDefaults.h"
#import "DN_Network.h"
#import <dlfcn.h>
#import <sys/types.h>
#import <UMCPush/UMPush/UMessage.h>
typedef int (*ptrace_ptr_t)(int _request, pid_t _pid, caddr_t _addr, int _data);

#if !defined(PT_DENY_ATTACH)
#define PT_DENY_ATTACH 31
#endif

UIColor *lightColor = NULL;
UIColor *grayColor = NULL;
UIColor *darkColor = NULL;

NSString *today = NULL;

BOOL isIphoneX = NO;
BOOL isFirst = NO;

void disableDump(void) {
    void* handle = dlopen(0, RTLD_GLOBAL | RTLD_NOW);
    ptrace_ptr_t ptrace_ptr = dlsym(handle, "ptrace");
    ptrace_ptr(PT_DENY_ATTACH, 0, 0, 0);
    dlclose(handle);
}


void appSetup(NSDictionary *launchOptions) {
    RouterStart;
    UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
    entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionSound|UMessageAuthorizationOptionAlert;
    
    UNNotificationAction *action1_ios10 = [UNNotificationAction actionWithIdentifier:@"action1_identifier" title:@"打开应用" options:UNNotificationActionOptionForeground];
    UNNotificationAction *action2_ios10 = [UNNotificationAction actionWithIdentifier:@"action2_identifier" title:@"忽略" options:UNNotificationActionOptionForeground];
    UNNotificationCategory *category1_ios10 = [UNNotificationCategory categoryWithIdentifier:@"category1" actions:@[action1_ios10,action2_ios10]   intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
    NSSet *categories = [NSSet setWithObjects:category1_ios10, nil];
    entity.categories=categories;
    
    [UNUserNotificationCenter currentNotificationCenter].delegate = (id <UNUserNotificationCenterDelegate>)[UIApplication sharedApplication].delegate;
    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
        }else{
        }
    }];
   [UMessage setBadgeClear:YES];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    today = @((int)[[NSDate date] timeIntervalSince1970]).stringValue;
    
    if (![userDefaults objectForKey:@"first"]) {
        isFirst = YES;
        [userDefaults setObject:@"YES" forKey:@"first"];
    }else{
        isFirst = NO;
    }
    
    [Router registerWebviewController:@"WebViewController"];
    lightColor = UIColor.whiteColor;
    grayColor = [UIColor qmui_colorWithHexString:@"9FA4AC"];
    darkColor = [UIColor qmui_colorWithHexString:@"43415B"];
    if ([[UIApplication sharedApplication] statusBarFrame].size.height > 20) {
        isIphoneX = YES;
    }
}

void post(NSString *url, NSDictionary *parameter, void(^success)(id data), void(^fail)(void)) {
    [DN_Network post:url parameters:parameter success:success fail:fail];
}

void get(NSString *url, void(^success)(id data), void(^fail)(void)) {
    [DN_Network get:url success:success fail:fail];
}


UIViewController * rootVC(void) {
    
    return [Router search:ROUTER_API(@"splvc")];
}
