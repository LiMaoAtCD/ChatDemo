//
//  LMMessageFrame.m
//  ChatView
//
//  Created by limo on 14-3-11.
//  Copyright (c) 2014年 limo. All rights reserved.
//

#import "LMMessageFrame.h"
#import "LMMessage.h"


@implementation LMMessageFrame

- (void)setMessage:(LMMessage *)message{
    
    _message = message;
    
    // 0、获取屏幕宽度
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    
    // 1、计算时间的位置

    if(_message.time){
        CGFloat timeY = kMargin;
        
        CGSize timeSize = [_message.time sizeWithAttributes:@{UIFontDescriptorSizeAttribute: @"16"}];
        
        CGFloat timeX = (screenW - timeSize.width) / 2;
        
        _timeFrame = CGRectMake(timeX, timeY, timeSize.width + kTimeMarginW, timeSize.height + kTimeMarginH);
    }
    
    // 2、计算头像位置
    CGFloat iconX = kMargin;
    
    // 2.1 如果是自己发得，头像在右边
    CGFloat iconY;
    
    if (_message.messageType == MessageFromMe ||
        _message.messageType ==ImageFromMe ||
        _message.messageType == AudioFromMe) {
        iconX = screenW - kMargin - kIconWH;
        
        iconY = CGRectGetMaxY(_timeFrame) + kMargin;
        _avatarFrame = CGRectMake(iconX, iconY, kIconWH, kIconWH);
        
    }else{
        iconY = CGRectGetMaxY(_timeFrame) + kMargin;
        _avatarFrame = CGRectMake(iconX, iconY, kIconWH, kIconWH);
    }
    // 3、计算内容位置
    
    switch (_message.messageType) {
        
        case MessageFromMe:
        {
            NSDictionary *attribute = @{ NSFontAttributeName:kContentFont};
            
            CGSize contentSize = [_message.text boundingRectWithSize:CGSizeMake(kContentW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
            
            CGFloat contentX = iconX - kMargin - contentSize.width - kContentLeft - kContentRight;
            CGFloat contentY = iconY;

            _contentFrame = CGRectMake(contentX, contentY, contentSize.width + kContentLeft + kContentRight, contentSize.height + kContentTop + kContentBottom);
        }
            break;
        case MessageFromOther:{
            
            CGFloat contentX = CGRectGetMaxX(_avatarFrame) + kMargin;
            CGFloat contentY=iconY ;

            NSDictionary *attribute = @{NSFontAttributeName:kContentFont};
            CGSize contentSize = [_message.text boundingRectWithSize:CGSizeMake(kContentW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
            
            _contentFrame = CGRectMake(contentX, contentY, contentSize.width + kContentLeft + kContentRight, contentSize.height + kContentTop + kContentBottom);
        }
            break;
        case ImageFromMe:
        {
            CGSize contentSize = _message.image.size;
            
            CGFloat contentX = iconX - kMargin - contentSize.width - kContentLeft - kContentRight;
            CGFloat contentY =iconY;

            _contentFrame = CGRectMake(contentX, contentY, contentSize.width + kContentLeft + kContentRight, contentSize.height + kContentTop + kContentBottom);
        }
            break;
            
        case ImageFromOther:
        {
            CGFloat contentX = CGRectGetMaxX(_avatarFrame) + kMargin;
            CGFloat contentY ;

                contentY = iconY;


            CGSize contentSize = _message.image.size;
            _contentFrame = CGRectMake(contentX, contentY, contentSize.width + kContentLeft + kContentRight, contentSize.height + kContentTop + kContentBottom);
        }
            break;
        case AudioFromMe:{
            _contentFrame = CGRectMake(80, iconY, 100, 20);
        }
            break;
            
        case AudioFromOther:{
            
            _contentFrame = CGRectMake(100, iconY, 100, 20);
        }
            break;
            
    }
    
    // 4、计算高度
    _cellHeight = MAX(CGRectGetMaxY(_contentFrame), CGRectGetMaxY(_avatarFrame))  + kMargin;
    if (_message.messageType==ImageFromMe || _message.messageType==ImageFromOther) {
        
    _cellHeight = 220;
    }
}
@end