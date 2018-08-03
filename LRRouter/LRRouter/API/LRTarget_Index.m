//
//  LRTarget_Index.m
//  Pods
//
//  Created by leilurong on 2018/2/4.
//
//

#import "LRTarget_Index.h"
#import "LRModifyViewController.h"
#import "LRSearchViewController.h"

@implementation LRTarget_Index

- (id)notFound:(NSDictionary *)params{
    NSLog(@"---没有找到对应控制器--- params = %@",params);
    return [UIViewController new];
}

- (id)action_home:(NSDictionary *)params {
    
    NSLog(@"params = %@",params);
    // 首页
    LRModifyViewController *vc = [[LRModifyViewController alloc] init];
    vc.params = params;
    return vc;
}

- (id)action_search:(NSDictionary *)params{
    NSLog(@"params = %@",params);
    //搜索
    LRSearchViewController *vc = [[LRSearchViewController alloc] init];
    vc.params = params;
    return vc;
}

@end
