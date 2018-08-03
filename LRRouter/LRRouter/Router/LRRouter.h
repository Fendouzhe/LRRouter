//
//  OCRouter.h
//  OCRouter
//
//  Created by leilurong on 2018/1/24.
//  Copyright © 2018年 LR. All rights reserved.
//

#import <UIKit/UIKit.h>

// target-action 两个参数来确定target 和 action NSDictionary para
@interface LRRouter : NSObject

// 单例
+ (instancetype)sharedInstance;

// url
- (id)openUrl:(NSString *)urlStr;

// url params
- (id)openUrl:(NSString *)urlStr params:(NSDictionary *)params;

// 返回值id
// 外部调用, 通过target和action来唯一确认一个类里面的方法
- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params;

@end
