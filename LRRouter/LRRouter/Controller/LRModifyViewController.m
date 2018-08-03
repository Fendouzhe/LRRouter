//
//  LRModifyViewController.m
//  LRRouter
//
//  Created by 宇中 on 2018/8/3.
//  Copyright © 2018年 广州宇中网络科技有限公司. All rights reserved.
//

#import "LRModifyViewController.h"
#import "LRBaseViewController.h"
#import "LRRouter.h"

@interface LRModifyViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textFiled;

@end

@implementation LRModifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改";
    self.textFiled.text = [self.params valueForKey:@"content"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"🔍" style:0 target:self action:@selector(right)];
}

- (void)right{
    
    //LRBaseViewController *search = [[LRRouter sharedInstance] openUrl:@"http://Index/search" params:@{@"key":@"88"}];
    LRBaseViewController *search = [[LRRouter sharedInstance] performTarget:@"Index" action:@"search" params:@{@"key":@"88"}];
    [self.navigationController pushViewController:search animated:YES];
}

- (IBAction)save:(id)sender {
    if (self.block) {
        self.block(self.textFiled.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


@end
