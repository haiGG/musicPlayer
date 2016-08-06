//
//  userDefineViewController.m
//  6-音乐播放器
//
//  Created by yanhai on 15/6/14.
//  Copyright (c) 2015年 yanhai. All rights reserved.
//

#import "userDefineViewController.h"
#import "AppDelegate.h"
#import "Music.h"
#import "musicPlayViewController.h"
@interface userDefineViewController ()

@end

@implementation userDefineViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.UserTableView.dataSource = self;
    self.UserTableView.delegate = self;
    [self.UserTableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *leftItem1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(UserDefineBackAction)];
    self.navigationItem.leftBarButtonItem = leftItem1;
    self.navigationItem.title = @"自定义列表";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)UserDefineBackAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    return app.defineArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"1235";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        
    }
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    Music *music = [app.defineArray objectAtIndex:indexPath.row];
    cell.textLabel.text = music.musicname;
    cell.imageView.image = [UIImage imageNamed:music.musicPic];
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
   
    musicplayView.musicArray = app.defineArray;
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
   
    [_UserTableView release];
    [super dealloc];
}
@end
