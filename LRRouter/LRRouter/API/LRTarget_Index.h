//
//  LRTarget_Index.h
//  Pods
//
//  Created by leilurong on 2018/2/4.
//
//

#import <Foundation/Foundation.h>

@interface LRTarget_Index : NSObject

// http://Index/home?useName=zhangshan&password=123
- (id)action_home:(NSDictionary *)params;

- (id)action_search:(NSDictionary *)params;

- (id)notFound:(NSDictionary *)params;

@end
