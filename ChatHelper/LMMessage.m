//
//  LMMessage.m
//  ChatView
//
//  Created by limo on 14-3-11.
//  Copyright (c) 2014年 limo. All rights reserved.
//

#import "LMMessage.h"

@implementation LMMessage

- (void)setDictionary:(NSDictionary *)dictionary{
    
    _dictionary = dictionary;
    
    NSString *avatarName = dictionary[@"avatar"];
    self.avatar = [UIImage imageNamed:avatarName];
    
    self.time = dictionary[@"time"];
    self.text = dictionary[@"text"];
    self.originalImageUrl  = dictionary[@"originalImageUrl"];
    self.messageType = [dictionary[@"messageType"] intValue];
    
//    self.isGroup = [dictionary[@"isGroup"] boolValue];
//    if (self.type==0 || self.type == 2 || self.type ==4) {
//        self.avatar = nil;
//    }
//    if (dictionary[@"name"]) {
//        self.name = dictionary[@"name"];
//    }
}
-(instancetype)initWithContent:(NSDictionary*)dictionary
{
    if (!self) {
        self = [[LMMessage alloc] init];
    }
//    名字
    if (dictionary[@"name"]) {
        self.name = dictionary[@"name"];
        self.isGroupChat = YES;
    }else{
        self.isGroupChat = NO;
    }
    
//    头像
    NSString *avatarName = dictionary[@"avatar"];
    
#warning 此处应该改为加载一个头像URL地址
    self.avatar = [UIImage imageNamed:avatarName];
    
//    消息类型
    if(!dictionary[@"messageType"]){
        NSAssert(!dictionary[@"messageType"], @"messageType can't be nil");

    }
    self.messageType = [dictionary[@"messageType"] intValue];
    
//   时间
    if (dictionary[@"time"]) {
        self.time = dictionary[@"time"];
    }

    
    if (dictionary[@"text"]) {
        // 如果是文字
        self.text = dictionary[@"text"];
    } else if(dictionary[@"image"]){
        //如果是图片
#warning 此处应该改为图片URL地址
        NSString *imageString =  dictionary[@"image"];
        self.image = [UIImage imageNamed:imageString];
        self.originalImageUrl  = dictionary[@"originalImageUrl"];
    }
    if (dictionary[@"audio"]) {
        // 如果是语音
        self.audioData = dictionary[@"audio"];
        
    }
    
    
    return self;
}


@end
