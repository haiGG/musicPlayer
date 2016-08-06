//
//  AppDelegate.h
//  6-音乐播放器
//
//  Created by yanhai on 15/6/10.
//  Copyright (c) 2015年 yanhai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain) NSMutableArray *musicArray;
@property (nonatomic,retain) NSMutableArray *defineArray;
@property (nonatomic,retain) NSMutableArray *recentArray;

@end

