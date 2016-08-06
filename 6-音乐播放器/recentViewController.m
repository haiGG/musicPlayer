//
//  recentViewController.m
//  6-音乐播放器
//
//  Created by yanhai on 15/6/14.
//  Copyright (c) 2015年 yanhai. All rights reserved.
//

#import "recentViewController.h"
#import "AppDelegate.h"
#import "Music.h"
#import "musicPlayViewController.h"
@interface recentViewController ()

@end

@implementation recentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *leftItem1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(UserDefineBackAction)];
    self.navigationItem.leftBarButtonItem = leftItem1;
    self.navigationItem.title = @"最近播放";
}

- (void)UserDefineBackAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma MArk - UItableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    AppDelegate *app = [[UIApplication sharedApplication]delegate];
    
    return app.recentArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellID = @"1234";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        
    }
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    Music *music = [app.recentArray objectAtIndex:indexPath.row];
    cell.textLabel.text = music.musicname;
    cell.imageView.image = [UIImage imageNamed:music.musicPic];
    cell.detailTextLabel.text = music.author;
    return cell;
 
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    
    musicPlayViewController *musicplayView = [[[musicPlayViewController alloc]initWithNibName:@"musicPlayViewController" bundle:nil]autorelease];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:musicplayView];
    musicplayView.flag = (int)indexPath.row;
    musicplayView.musicArray = app.recentArray;
    musicplayView.fromRecentView = YES;
    [self presentViewController:nav animated:YES completion:nil];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
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
   
    [_recentTableView release];
    [super dealloc];
}
@end
