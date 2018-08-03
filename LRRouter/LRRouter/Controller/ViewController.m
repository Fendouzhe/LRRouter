//
//  ViewController.m
//  LRRouter
//
//  Created by 宇中 on 2018/8/3.
//  Copyright © 2018年 广州宇中网络科技有限公司. All rights reserved.
//

#import "ViewController.h"
#import "LRBaseViewController.h"
#import "LRRouter.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *content;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.content.text = @"8888";
}


- (IBAction)push:(id)sender {
    
    LRBaseViewController *modify = [[LRRouter sharedInstance] openUrl:@"http://Index/home" params:@{@"content":self.content.text}];
    __weak typeof(self) weakSelf = self;
    modify.block = ^(id data) {
        NSLog(@"data = %@",data);
        weakSelf.content.text = data;
    };
    [self.navigationController pushViewController:modify animated:YES];
    
}


@end
