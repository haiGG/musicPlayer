//
//  MVViewController.m
//  6-音乐播放器
//
//  Created by yanhai on 15/6/24.
//  Copyright (c) 2015年 yanhai. All rights reserved.
//

#import "MVViewController.h"

@interface MVViewController ()

@end

@implementation MVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //设置左边返回导航按钮
    
    UIBarButtonItem *leftItem1 = [[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(backAction)]autorelease];
    
    self.navigationItem.leftBarButtonItem = leftItem1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
