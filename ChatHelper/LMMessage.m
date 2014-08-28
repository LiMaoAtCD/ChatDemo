//
//  LMMessage.m
//  ChatView
//
//  Created by limo on 14-3-11.
//  Copyright (c) 2014年 limo. All rights reserved.
//

#import "LMMessage.h"

@implementation LMMessage

- (void)setDictionary:(NSMutableDictionary *)dictionary{
    
    _dictionary = dictionary;
    
    self.avatar = dictionary[@"avatar"];
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



@end
