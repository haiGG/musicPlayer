//
//  musicPlayViewController.h
//  6-音乐播放器
//
//  Created by yanhai on 15/6/15.
//  Copyright (c) 2015年 yanhai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface musicPlayViewController : UIViewController<AVAudioPlayerDelegate>
@property (retain, nonatomic) IBOutlet UIImageView *Image1;

@property (retain, nonatomic) IBOutlet UISlider *progressslider;
- (IBAction)startMusic:(id)sender;
- (IBAction)progress1:(id)sender;
@property (nonatomic,retain)AVAudioPlayer *musicPlay;
@property (nonatomic,retain) NSMutableArray *musicArray;
@property bool isplay;
@property bool fromRecentView;
@property (nonatomic,retain) UIAlertView *alert;
@property int flag;
@property int seg;
@property (retain, nonatomic) IBOutlet UILabel *lab1;
@property (retain, nonatomic) IBOutlet UILabel *lab2;
- (IBAction)lastMusicAction:(id)sender;
- (IBAction)nextMusicAction:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *pauseButton;
@property (retain, nonatomic) IBOutlet UILabel *authorLabel;
- (IBAction)collectAction:(id)sender;
- (IBAction)wayAction:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *way;
@property (retain, nonatomic) IBOutlet UIButton *collect;

@property (retain, nonatomic) IBOutlet UILabel *lb;
@property (retain, nonatomic) IBOutlet UILabel *lb1;
@property (retain, nonatomic) IBOutlet UILabel *lb2;


@property (nonatomic,retain) NSMutableArray *lrcList;

@property (nonatomic,retain) NSMutableArray *rootList;
@property int currentTime;
@property (nonatomic,retain) NSMutableArray *List1;
@property (nonatomic,retain) NSMutableArray *List2;
@end
