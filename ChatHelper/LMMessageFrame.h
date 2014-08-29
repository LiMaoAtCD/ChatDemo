//
//  MessageFrame.h
//  15-QQ聊天布局
//
//  Created by Liu Feng on 13-12-3.
//  Copyright (c) 2013年 Liu Feng. All rights reserved.
//

#define kMargin 10.0         //间隔
#define kIconWH 40.0         //头像宽高
#define kContentW 180.0      //内容宽度

#define kTimeMarginW 15.0    //时间文本与边框间隔宽度方向
#define kTimeMarginH 10.0    //时间文本与边框间隔高度方向

#define kContentLabelTop 10.0     //文本内容与按钮上边缘间隔
#define kContentLabelLeft 15.0    //文本内容与按钮左边缘间隔
#define kContentLabelBottom 10.0  //文本内容与按钮下边缘间隔
#define kContentLabelRight 15.0   //文本内容与按钮右边缘间隔

#define kContentImageTop 5.0
#define kContentImageLeft 5.0
#define kContentImageBottom 5.0
#define kContentImageRight 5.0

#define kTimeFont [UIFont systemFontOfSize:12] //时间字体
#define kContentFont [UIFont systemFontOfSize:18] //内容字体

#import <Foundation/Foundation.h>

@class LMMessage;

@interface LMMessageFrame : NSObject

@property (nonatomic, assign, readonly) CGRect avatarFrame;
@property (nonatomic, assign, readonly) CGRect timeFrame;
@property (nonatomic, assign, readonly) CGRect nameFrame;
@property (nonatomic, assign, readonly) CGRect contentFrame;

@property (nonatomic, assign, readonly) CGFloat cellHeight; //cell高度

@property (nonatomic, strong) LMMessage *message;

@property (nonatomic, assign) BOOL showTime;

@end
