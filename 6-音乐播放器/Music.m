//
//  Music.m
//  6-音乐播放器
//
//  Created by yanhai on 15/6/14.
//  Copyright (c) 2015年 yanhai. All rights reserved.
//

#import "Music.h"

@implementation Music
- (instancetype)initWithname:(NSString *)aname picture:(NSString *)apic AUthor:(NSString *)aauthor
{
    self.musicname = aname;
    self.musicPic = apic;
    self.isCollected = NO;
    self.author = aauthor;
    return self;
}
- (NSString *)description
{
    return self.musicname;
}
@end
