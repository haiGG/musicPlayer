//
//  musicPlayViewController.m
//  6-音乐播放器
//
//  Created by yanhai on 15/6/15.
//  Copyright (c) 2015年 yanhai. All rights reserved.
//

#import "musicPlayViewController.h"
#import "MUSICViewController.h"
#import "Music.h"
#import "AppDelegate.h"
#import "MVViewController.h"
@interface musicPlayViewController ()

@end

@implementation musicPlayViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    
    Music *music = [self.musicArray objectAtIndex:self.flag];//把选中的音乐接收过来
   
    //******************更新最近播放列表****************
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    
    
    if(self.fromRecentView == NO)
    {
        int temp = (int)[app.recentArray indexOfObject:[self.musicArray objectAtIndex:self.flag]];
        if(temp >= 0)
        {
           [app.recentArray removeObject:[self.musicArray objectAtIndex:self.flag]];
        }
        
        [app.recentArray insertObject:[self.musicArray objectAtIndex:self.flag] atIndex:0];
        
    }
    
  
    //********************准备播放音乐********************
    
    
    NSString *path = [[NSBundle mainBundle]pathForResource:music.musicname ofType:@"mp3"];

    
    NSURL *musicURL = [NSURL fileURLWithPath:path];
  
    self.musicPlay = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:nil];
    self.musicPlay.delegate = self;
    [self.musicPlay prepareToPlay];
    
   
    self.Image1.image = [UIImage imageNamed:music.musicPic] ;
    
    //*****************设置左边返回导航按钮*************
    
    UIBarButtonItem *leftItem1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(backAction)];
    
    self.navigationItem.leftBarButtonItem = leftItem1;
    
    //***************设置导航栏音乐名字和歌手****************
    
    self.navigationItem.title = music.musicname;
    self.authorLabel.text = music.author;
    
    //*******************设置自定义右边导航显示歌词的按钮*******
    
    UIBarButtonItem *rirhtButton = [[UIBarButtonItem alloc]initWithTitle:@"MV"style:UIBarButtonItemStyleBordered target:self action:@selector(MVAction)];
    
    self.navigationItem.rightBarButtonItem = rirhtButton;
    
    //******************进度条增长****************
    self.progressslider.minimumValue = 0;
    
    self.progressslider.maximumValue = self.musicPlay.duration;
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(slideValueAction) userInfo:nil repeats:YES];
    
    //**********************设置音乐时长******************
    self.lab2.text = [NSString stringWithFormat:@"%d:%d",(int)self.musicPlay.duration/60,(int)self.musicPlay.duration%60];
     [self.musicPlay play];
    self.isplay = YES;
    [self.pauseButton setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    
    //******************设置自定义列表按钮状态************
   if(music.isCollected == NO)
   {
      [self.collect setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
   }
    else
    {
       [self.collect setImage:[UIImage imageNamed:@"collected"] forState:UIControlStateNormal];
    }
   // music.isCollected = NO;
    
    
    
    
    //*****************解析显示歌词********************
    self.currentTime = 0;//当前歌词计时重置为0
    self.lb.text = nil;
    self.lb1.text = nil;
    self.lb2.text = nil;
    NSString *lrcname = music.musicname;
    NSString *path1 = [[NSBundle mainBundle]pathForResource:lrcname ofType:@"lrc"];
   
    
    self.lrcList= [[NSMutableArray alloc]init];
    NSString *LRCFileStr = [[NSString alloc]initWithContentsOfFile:path1 encoding:NSUTF8StringEncoding error:nil];
   
    self.rootList = [[NSMutableArray alloc]init];
    NSArray *array = [LRCFileStr componentsSeparatedByString:@"\n"];
  
    for (int i = 0; i < array.count; i++) {
        NSString *tempStr = [array objectAtIndex:i];
        NSArray *lineArray = [tempStr componentsSeparatedByString:@"]"];
        for (int j = 0; j < [lineArray count]-1; j ++) {
            
            if ([lineArray[j] length] > 8) {
                NSMutableDictionary *rootDic = [[NSMutableDictionary alloc]init];
                NSString *str1 = [tempStr substringWithRange:NSMakeRange(3, 1)];
                NSString *str2 = [tempStr substringWithRange:NSMakeRange(6, 1)];
                if ([str1 isEqualToString:@":"] && [str2 isEqualToString:@"."]) {
                    NSString *lrcStr = [lineArray lastObject];
                    NSString *timeStr = [[lineArray objectAtIndex:j] substringWithRange:NSMakeRange(1, 8)];//分割区间求歌词时间
                    //把时间 和 歌词 加入词典
                    
                    [rootDic setObject:lrcStr forKey:@"lrc"];
                    [rootDic setObject:timeStr forKey:@"lrctime"];
                    
                    
                    [self.rootList addObject:rootDic];
                }
            }
        }
    }
    
    self.List1 = [[NSMutableArray alloc]init];
    self.List2 = [[NSMutableArray alloc]init];
    for(int i = 0;i < self.rootList.count;i++)
    {
        NSDictionary *dict = [self.rootList objectAtIndex:i];
        [self.List1 addObject:[dict valueForKey:@"lrctime"]];
        [self.List2 addObject:[dict valueForKey:@"lrc"]];
        
    }
    
   //歌词
    for (int i = 0; i < [self.List1 count]; i++)
    {
        
        NSArray *array = [self.List1[i] componentsSeparatedByString:@":"];//把时间转换成秒
        int currentTime = [array[0] intValue] * 60 + [array[1] intValue] ;
        
        [self.List1 replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d",currentTime]];
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.seg = 1;//默认为循环播放
    [self.way setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//***********************进入MV页面******************
- (void)MVAction
{
    MVViewController *MVView = [[[MVViewController alloc]initWithNibName:@"MVViewController" bundle:nil]autorelease];
    UINavigationController *nav = [[[UINavigationController alloc]initWithRootViewController:MVView]autorelease];
    [self presentViewController:nav animated:YES completion:^{
        [self.musicPlay stop];
        
          [self.pauseButton setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
            [self.musicPlay stop];
            self.isplay = NO;
        
    }];
   
}

//********************进度条随音乐增长*************
- (void)slideValueAction

{
    self.lab1.text = [NSString stringWithFormat:@"%d:%d",(int)self.musicPlay.currentTime/60,(int)self.musicPlay.currentTime%60];
    
    self.progressslider.value = self.musicPlay.currentTime;
    
    
    //歌词同步显示
    self.currentTime = (int)self.musicPlay.currentTime;
    for(NSString *as in self.List1)
    {
        if(self.currentTime == [as intValue])
        {
            int a = (int)[self.List1 indexOfObject:as];
            self.lb.text = [self.List2 objectAtIndex:a];
            if(a > 0 && a < self.List1.count - 1)
            {
                self.lb1.text = [self.List2 objectAtIndex:a - 1];
                self.lb2.text = [self.List2 objectAtIndex:a + 1];
            }
            
        }
    }
}

//**********************返回上页****************
- (void)backAction

{
    
    [self.musicPlay stop];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//********************播放玩自动进入下一曲******************
#pragma mark - AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    
   
    switch (self.seg) {
        case 1:
            //循环
            if(self.flag == (self.musicArray.count - 1 ))
            {
                self.flag = 0;
                
            }
            else
            {
                self.flag = self.flag + 1;
                
            }
            break;
        case 2:
            //顺序
            if(self.flag == (self.musicArray.count - 1 ))
            {
                [self.musicPlay stop];
            }
            else
            {
                self.flag = self.flag + 1;
            }
            break;
            
        case 3:
            //随机
            self.flag = arc4random()%(self.musicArray.count);
            break;
        case 4:
            //单曲
            
            break;
        default:
            break;
    }
    
    
    [self viewWillAppear:YES];
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
    [_Image1 release];
    [_progressslider release];
    [_lab1 release];
    [_lab2 release];
    [_pauseButton release];
    [_authorLabel release];
    [_way release];
    [_collect release];
    [_lb release];
    [_lb1 release];
    [_lb2 release];
    [super dealloc];
}

//*********************暂停/播放按钮***********************
- (IBAction)startMusic:(id)sender
{
    
    
    if(self.isplay == YES)
    {   [self.pauseButton setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        [self.musicPlay stop];
        self.isplay = NO;
    }
    else
    {
        [self.pauseButton setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        [self.musicPlay play];
        self.isplay = YES;
    }
    
}


//***************************拖动进度条改变播放时间**************
- (IBAction)progress1:(id)sender
{
    self.musicPlay.currentTime = self.progressslider.value;
    //歌词同步显示
    self.currentTime = (int)self.progressslider.value;
    for(NSString *as in self.List1)
    {
        if(self.currentTime == [as intValue])
        {
            int a = (int)[self.List1 indexOfObject:as];
            
            self.lb.text = [self.List2 objectAtIndex:a];
            if(a > 0 && a < self.List1.count - 1)
            {
                self.lb1.text = [self.List2 objectAtIndex:a - 1];
                self.lb2.text = [self.List2 objectAtIndex:a + 1];
            }
            
        }
    }
}

//***********************点击进入上一曲***************
- (IBAction)lastMusicAction:(id)sender
{
    [self.musicPlay stop];
    switch (self.seg) {
        case 1:
            //循环
            if(self.flag == 0)
            {
                self.flag = (int)(self.musicArray.count - 1 );
                
            }
            else
            {
                self.flag = self.flag - 1;
                
            }
            break;
        case 2:
            //顺序
            if(self.flag == 0)
            {
                
                
                UIAlertView *alert2 = [[UIAlertView alloc]initWithTitle:@"提示" message:@"已经是第一首歌了!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert2 show];
            }
            else
            {
                self.flag = self.flag - 1;
            }
            break;
            
        case 3:
            //随机
            self.flag = arc4random()%(self.musicArray.count);
            break;
        case 4:
            //单曲
            if(self.flag == 0)
            {
                self.flag = (int)self.musicArray.count - 1 ;
            }
            else
            {
                self.flag = self.flag - 1;
            }
            break;
        default:
            break;
    }
    
    
    [self viewWillAppear:YES];

    
}
//************************点击进入下一曲********************
- (IBAction)nextMusicAction:(id)sender
{
    [self.musicPlay stop];
    switch (self.seg) {
        case 1:
            //循环
            if(self.flag == (self.musicArray.count - 1 ))
            {
                self.flag = 0;
            
            }
            else
            {
                self.flag = self.flag + 1;
                
            }
            break;
        case 2:
            //顺序
            if(self.flag == (self.musicArray.count - 1 ))
            {
                
                [self.musicPlay stop];
                UIAlertView *alert2 = [[UIAlertView alloc]initWithTitle:@"提示" message:@"已经是最后一首歌了!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
               [alert2 show];
            }
            else
            {
                self.flag = self.flag + 1;
            }
            break;
            
        case 3:
            //随机
            self.flag = arc4random()%(self.musicArray.count);
            break;
        case 4:
            //单曲
            if(self.flag == (self.musicArray.count - 1 ))
            {
                 self.flag = 0;
            }
            else
            {
                self.flag = self.flag + 1;
            }
            break;
        default:
            break;
    }
    
    
    [self viewWillAppear:YES];
    
 
  
}

//***********************添加/删除 到自定义列表*******************
- (IBAction)collectAction:(id)sender
{
    if(self.musicArray.count <= 0)
    {
        UIAlertView *hinder = [[UIAlertView alloc]initWithTitle:@"提示" message:@"自定义列表已无歌曲请从别处添加" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [hinder show];
    }
    else
    {
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        Music *music = [self.musicArray objectAtIndex:self.flag];
        if(music.isCollected == NO)
        {
            //添加到自定义列表
            
            [app.defineArray addObject:music];
            //NSLog(@"%@",app.defineArray);
            
            //alertview
            [self.collect setImage:[UIImage imageNamed:@"collected"] forState:UIControlStateNormal];
            music.isCollected = YES;
            self.alert = [[UIAlertView alloc]initWithTitle:nil message:@"已添加到列表" delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
            
            [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(alertDismiss) userInfo:nil repeats:NO];
            [self.alert show];
            
        }
        else
        {
            //从自定义列表删除
            
            
            [app.defineArray removeObject:music];
            // NSLog(@"%@",app.defineArray);
            [self.collect setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
            music.isCollected = NO;
            self.alert = [[UIAlertView alloc]initWithTitle:nil message:@"已从列表移除" delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
            
            [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(alertDismiss) userInfo:nil repeats:NO];
            [self.alert show];
 
        }
    }
    
}

- (void)alertDismiss       //alert ***自动消失***
{
    [self.alert dismissWithClickedButtonIndex:0 animated:YES];
}
//**************************选择播放方式*******************
- (IBAction)wayAction:(id)sender
{
    switch (self.seg) {
  case 1:
            self.seg = 2;
            [self.way setImage:[UIImage imageNamed:@"sequen"] forState:UIControlStateNormal];
            self.alert = [[UIAlertView alloc]initWithTitle:nil message:@"顺序播放" delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
            
            [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(alertDismiss) userInfo:nil repeats:NO];
            [self.alert show];
    break;
    case 2:
            self.seg = 3;
            [self.way setImage:[UIImage imageNamed:@"random"] forState:UIControlStateNormal];
            self.alert = [[UIAlertView alloc]initWithTitle:nil message:@"随机播放" delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
            
            [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(alertDismiss) userInfo:nil repeats:NO];
            [self.alert show];
            break;
            
        case 3:
        self.seg = 4;
            [self.way setImage:[UIImage imageNamed:@"single"] forState:UIControlStateNormal];
            self.alert = [[UIAlertView alloc]initWithTitle:nil message:@"单曲播放" delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
            
            [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(alertDismiss) userInfo:nil repeats:NO];
            [self.alert show];
            break;
    case 4:
            self.seg = 1;
            [self.way setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
            self.alert = [[UIAlertView alloc]initWithTitle:nil message:@"循环播放" delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
            
            [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(alertDismiss) userInfo:nil repeats:NO];
            [self.alert show];
            break;
  default:
    break;
}
}


@end
