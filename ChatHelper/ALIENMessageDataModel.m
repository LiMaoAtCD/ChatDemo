//
//  ALIENMessageDataModel.m
//  ChatDemo
//
//  Created by AlienLi on 14-9-3.
//  Copyright (c) 2014年 AlienLi. All rights reserved.
//

#import "ALIENMessageDataModel.h"
#import "LMMessage.h"
@implementation ALIENMessageDataModel

-(id)initWithDataModel
{
        self = [[ALIENMessageDataModel alloc] init];
        self.dataArray =
                        [
                         @[
                           @{
                             @"messageType":@(MessageFromOther),
                             
                             @"text":@"Okay,target's locked",
                             @"time":@"2014-08-29",
                             @"avatar":@"1.png",
                             @"name":@"火枪"
                             },
                           
                           @{
                               @"messageType":@(MessageFromOther),
                            @"text":@"dada014-08-2014-08-2014-08-2014-08-2014-08-2014-08-2014-08-2014-08-2",
                               @"time":@"2014-08-29",
                               @"avatar":@"scene",
                               @"name":@"小小"
                               },
                           
                           @{
                               @"messageType":@(MessageFromMe),
                               @"text":@"杀火枪",
                               @"time":@"2014-08-30",
                               @"avatar":@"1"
                               },
                   
                           @{
                               @"text":@"我就是牛逼我就是牛逼我就是牛逼我就是牛逼我就是牛逼我就是牛逼我就是牛逼我就是牛逼我就是牛逼我就是牛逼我就是牛逼",
                               @"time":@"2014-08-29",
                               @"avatar":@"1",
                               @"messageType":@(MessageFromMe)
                               },
                           @{
                               @"audio":[NSData data],
                               @"avatar":@"scene",
                               @"time":@"2014-08-29",
                               @"messageType":@(AudioFromOther),
                            },
                           @{
                               @"audio":[NSData data],
                               @"avatar":@"scene",
                               @"time":@"2014-08-29",
                               @"messageType":@(AudioFromMe),
                            },
                    
                           @{
                               @"image":@"scene",
                               @"time":@"2014-08-29",
                               @"avatar":@"1",
                               @"messageType":@(ImageFromOther)
                          
                          },
                        @{@"image":@"scene",
                          @"time":@"2014-08-29",
                          @"avatar":@"1",
                          @"messageType":@(ImageFromMe),
                          }]mutableCopy];
    return self;
}


@end
