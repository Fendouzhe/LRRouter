//
//  OCRouter.m
//  OCRouter
//
//  Created by leilurong on 2018/1/24.
//  Copyright © 2018年 LR. All rights reserved.
//

#import "LRRouter.h"

@implementation LRRouter

+ (instancetype)sharedInstance
{
    static LRRouter *mediator;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mediator = [[LRRouter alloc] init];
    });
    return mediator;
}

// http://Index/home?useName=zhangshan&password=123
- (id)openUrl:(NSString *)urlStr {
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    NSLog(@"url.query = %@",url.query);// url.query = useName=zhangshan&password=123
    NSLog(@"url.path = %@",url.path);//   url.path = /home
    NSLog(@"url.host = %@",url.host);//   url.host = Index
    
    // url.query = useName=zhangshan&password=123
    NSString *urlString = url.query;
    
    // 切割字符串
    for (NSString *param in [urlString componentsSeparatedByString:@"&"]) {
        //分割键值成数组
        NSArray *elts = [param componentsSeparatedByString:@"="];
        if (elts.count < 2) continue;
        id fristEle = [elts firstObject];
        id lastEle = [elts lastObject];
        if (fristEle && lastEle) {
            [params setObject:lastEle forKey:fristEle];
        }
    }
    /*
    //url.path = /home
    NSString *actionName = [url.path stringByReplacingOccurrencesOfString:@"/" withString:@""];
    
    if ([actionName hasPrefix:@"native"]) return @(NO);
     
    //url.host = Index
    id result = [self performTarget:url.host action:actionName params:params];
    
    return result;
     */
    return [self openUrl:urlStr params:params];
}

- (id)openUrl:(NSString *)urlStr params:(NSDictionary *)params{
    
    NSURL *url = [NSURL URLWithString:urlStr];
    //url.path = /home
    NSString *actionName = [url.path stringByReplacingOccurrencesOfString:@"/" withString:@""];
    
    //if ([actionName hasPrefix:@"native"]) return @(NO);
    
    //url.host = Index
    id result = [self performTarget:url.host action:actionName params:params];
    
    return result;
}

- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params {
    
    // 这个目标的类名字符串 LRTarget_Index
    NSString *targetClassString = [NSString stringWithFormat:@"LRTarget_%@",targetName];
    // 这个目标的方法名字符串 action_home
    NSString *actionMethondString = [NSString stringWithFormat:@"action_%@:",actionName];
    
    Class targetClass = NSClassFromString(targetClassString);
    NSObject *target = [[targetClass alloc] init];
    
    SEL action = NSSelectorFromString(actionMethondString);
    
    // 判断 是否有实现
    if ([target respondsToSelector:action]) {
        
        return [self safePerformAction:action target:target params:params];
        
    } else {
        
        SEL action = NSSelectorFromString(@"notFound:");
        if ([target respondsToSelector:action]) {
            return [self safePerformAction:action target:target params:params];
        } else {
            return nil;
        }
    }
}


// 1.通过对象调用指定的方法
// 2.传参
- (id)safePerformAction:(SEL)action target:(NSObject *)target params:(NSDictionary *)params {
    
    NSMethodSignature *methodSig = [target methodSignatureForSelector:action];
    if (methodSig == nil) return nil;
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
}

@end


