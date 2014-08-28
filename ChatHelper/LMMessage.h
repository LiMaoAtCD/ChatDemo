//
//  LMMessage.h
//  ChatView
//
//  Created by limo on 14-3-11.
//  Copyright (c) 2014年 limo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    MessageFromMe = 0, // 自己发的
    MessageFromOther, //别人发得
    ImageFromMe,
    ImageFromOther,
    AudioFromMe,
    AudioFromOther
} MessageType;

@interface LMMessage : NSObject
//message包含头像，时间，文字，图片，声音，原图，类型，名字，群聊
@property (nonatomic, strong) UIImage *avatar;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSData *audioData;
@property (nonatomic, copy) NSString *headUrl;

@property (nonatomic, copy) NSString *originalImageUrl;
@property (nonatomic, assign) MessageType messageType;

//@property (nonatomic, copy) NSString *name;
//@property (nonatomic, assign) BOOL isGroup;

@property (nonatomic, strong) NSMutableDictionary *dictionary;

@end
