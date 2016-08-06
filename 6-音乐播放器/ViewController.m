//
//  ViewController.m
//  6-音乐播放器
//
//  Created by yanhai on 15/6/10.
//  Copyright (c) 2015年 yanhai. All rights reserved.
//

#import "ViewController.h"
#import "MUSICViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.time = 1;
    
    // Do any additional setup after loading the view from its nib.
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(TimeAction:) userInfo:nil repeats:YES];
}

- (void)TimeAction:(NSTimer *)timer
{
   // NSLog(@"time");
    self.time --;
    if(self.time == 0)
    {
        MUSICViewController *musicView = [[MUSICViewController alloc]initWithNibName:@"MUSICViewController" bundle:nil];
        [self presentViewController:musicView animated:YES completion:nil];
        [musicView release];
        [timer invalidate];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
