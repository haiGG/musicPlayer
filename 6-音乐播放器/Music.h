//
//  Music.h
//  6-音乐播放器
//
//  Created by yanhai on 15/6/14.
//  Copyright (c) 2015年 yanhai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Music : NSObject
@property (nonatomic,copy) NSString *musicname;
@property (nonatomic,retain) NSString *musicPic;
@property (nonatomic,copy) NSString *author;
@property bool isCollected;
- (instancetype)initWithname:(NSString *)aname picture:(NSString *)apic AUthor:(NSString *)aauthor;
- (NSString *)description;
@end
