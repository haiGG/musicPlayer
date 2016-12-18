//
//  MUSICViewController.m
//  6-音乐播放器
//
//  Created by yanhai on 15/6/10.
//  Copyright (c) 2015年 yanhai. All rights reserved.
//

#import "MUSICViewController.h"
#import "musicPlayViewController.h"
#import "userDefineViewController.h"
#import "recentViewController.h"
#import "AppDelegate.h"
#import "recentViewController.h"
#import "Music.h"

@interface MUSICViewController ()

@end

@implementation MUSICViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //设置点击图片1响应的事件
    self.image1.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTapped1)];
    [self.image1 addGestureRecognizer:singleTap1];//点击图片事件
    
    //设置最近播放图片事件
    self.image2.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(photoTapped2)];
    [self.image2 addGestureRecognizer:tap2];

}

//自定义列表事件
- (void)photoTapped1
{
    
    userDefineViewController *userDefineView = [[userDefineViewController alloc]initWithNibName:@"userDefineViewController" bundle:nil];
    UINavigationController *nav = [[[UINavigationController alloc]initWithRootViewController:(userDefineView)]autorelease];
    [self presentViewController:nav animated:YES completion:nil];
    [userDefineView release];
    
}

//最近播放事件
- (void)photoTapped2
{
   // NSLog(@"s");
    recentViewController *recent = [[[recentViewController alloc]initWithNibName:@"recentViewController" bundle:nil]autorelease];
    UINavigationController *nav = [[[UINavigationController alloc]initWithRootViewController:recent]autorelease];
    [self presentViewController:nav animated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UItableviewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    return appDelegate.musicArray.count;
#warning test
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"1232";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        
    }
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    Music *music = [appDelegate.musicArray objectAtIndex:indexPath.row];
    cell.textLabel.text = music.musicname;
  
    cell.imageView.image =[UIImage imageNamed:music.musicPic];
    
    cell.detailTextLabel.text = music.author;
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    musicPlayViewController *musicplayView = [[[musicPlayViewController alloc]initWithNibName:@"musicPlayViewController" bundle:nil]autorelease];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:musicplayView];
    musicplayView.flag = (int)indexPath.row;
    musicplayView.musicArray = app.musicArray;
    musicplayView.fromRecentView == NO;
    [self presentViewController:nav animated:YES completion:nil];
  
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [_image1 release];
    [_image2 release];
    [super dealloc];
}
@end
