//
//  recentViewController.h
//  6-音乐播放器
//
//  Created by yanhai on 15/6/14.
//  Copyright (c) 2015年 yanhai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface recentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (retain, nonatomic) IBOutlet UITableView *recentTableView;



@end
