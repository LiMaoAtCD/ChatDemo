//
//  LMTableViewCell.m
//  ChatView
//
//  Created by limo on 14-3-11.
//  Copyright (c) 2014年 limo. All rights reserved.
//

#import "LMTableViewCell.h"
#import "LMMessage.h"
#import "LMMessageFrame.h"

@interface LMTableViewCell()
{
    UIButton     *_timeBtn;
    UILabel      *_name;
    UIImageView  *avatar;
    UIImageView *contentImage;
    UIButton    *_contentBtn;

}

@end
@implementation LMTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
//#warning 必须先设置为clearColor，否则tableView的背景会被遮住
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        // 1、创建时间按钮
        _timeBtn = [[UIButton alloc] init];
        
        [_timeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _timeBtn.titleLabel.font = kTimeFont;
        _timeBtn.enabled = NO;
        _timeBtn.backgroundColor = [UIColor clearColor];
        _timeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _timeBtn.userInteractionEnabled = NO;
        
        [self.contentView addSubview:_timeBtn];

        // 2、创建头像
        avatar = [[UIImageView alloc] init];

        // 3、创建内容
        _contentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_contentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _contentBtn.titleLabel.font = kContentFont;
        _contentBtn.titleLabel.numberOfLines = 0;

        
        [_contentBtn addTarget:self action:@selector(clickToShowOriginalImageOrPlayAudio:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_contentBtn];

    }
    return self;
}


- (void)setMessageFrame:(LMMessageFrame *)messageFrame{
    
    _messageFrame = messageFrame;
    LMMessage *message = _messageFrame.message;
//     1、设置时间
    
    [_timeBtn setTitle:message.time forState:UIControlStateNormal];
    _timeBtn.frame = _messageFrame.timeFrame;
    
//     2、设置头像
    avatar.image = message.avatar;
    avatar.frame = _messageFrame.avatarFrame;
    avatar.layer.cornerRadius = _messageFrame.avatarFrame.size.height>_messageFrame.avatarFrame.size.width?_messageFrame.avatarFrame.size.height/2:_messageFrame.avatarFrame.size.width/2;
    avatar.layer.masksToBounds = YES;
    
    [self.contentView addSubview:avatar];

    
//     3、设置内容
    switch (message.messageType) {
        case MessageFromMe:
        {
//            设置tag
            _contentBtn.tag = MessageFromMe;
//            设置内容
            [self setCellContent:message on:_contentBtn];
//            设置内容frame
            _contentBtn.frame = _messageFrame.contentFrame;
            _contentBtn.contentEdgeInsets = UIEdgeInsetsMake(kContentLabelTop, kContentLabelLeft, kContentLabelBottom, kContentLabelRight);
            
            UIImage *backGroundImage =[UIImage imageNamed:@"tal_box_bk_1"];
            UIEdgeInsets insets =UIEdgeInsetsMake(18, 7, 5, 19);
            backGroundImage = [backGroundImage resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];

//            设置背景颜色（一张图片）
            [_contentBtn setBackgroundImage:backGroundImage forState:UIControlStateNormal];
        }
            break;
        case MessageFromOther:
        {
            _contentBtn.tag = MessageFromOther;
            
            [self setCellContent:message on:_contentBtn];
            _contentBtn.frame = _messageFrame.contentFrame;
            
            _contentBtn.contentEdgeInsets = UIEdgeInsetsMake(kContentLabelTop, kContentLabelLeft, kContentLabelBottom, kContentLabelRight);
            
            UIImage *normal=[UIImage imageNamed:@"tal_box_bk"];
            UIEdgeInsets insets =UIEdgeInsetsMake(18, 19, 5, 7);
            normal = [normal resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
            [_contentBtn setBackgroundImage:normal forState:UIControlStateNormal];

        }
            break;
        case ImageFromMe:
        {
            _contentBtn.tag = ImageFromMe;
            
            [self setCellContent:message on:_contentBtn];
            
            
            _contentBtn.contentEdgeInsets = UIEdgeInsetsMake(kContentImageTop, kContentImageLeft, kContentImageBottom, kContentImageRight+2);
            
            _contentBtn.frame = _messageFrame.contentFrame;
            
            

//            添加背景
            UIImage *backGroundImage =[UIImage imageNamed:@"tal_box_bk_1"];
            UIEdgeInsets insets =UIEdgeInsetsMake(18, 7, 5, 19);
            backGroundImage = [backGroundImage resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
            
            //            设置背景颜色（一张图片）
            [_contentBtn setBackgroundImage:backGroundImage forState:UIControlStateNormal];
           
        }
            break;
        case ImageFromOther:
        {
            _contentBtn.tag = ImageFromOther;
            [self setCellContent:message on:_contentBtn];
            
             _contentBtn.frame = _messageFrame.contentFrame;
            _contentBtn.contentEdgeInsets = UIEdgeInsetsMake(kContentImageTop, kContentImageLeft+2, kContentImageBottom, kContentImageRight);
           

            
            UIImage *normal=[UIImage imageNamed:@"tal_box_bk"];
            UIEdgeInsets insets =UIEdgeInsetsMake(18, 19, 5, 7);
            normal = [normal resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
            [_contentBtn setBackgroundImage:normal forState:UIControlStateNormal];


        }
            break;
        case AudioFromMe:
        {
            _contentBtn.tag = AudioFromMe;
//            _contentBtn.contentEdgeInsets = UIEdgeInsetsMake(kContentTop, kContentLeft, kContentBottom, kContentRight);
            _contentBtn.frame = CGRectMake(_messageFrame.contentFrame.origin.x+80, _messageFrame.contentFrame.origin.y+2, 200, 40);
            
            UIImage *normal;
            UIImageView * img =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 107, 35)];
            normal = [UIImage imageNamed:@"IMFromMe"];
            [img setImage:normal];

            
            NSArray* myImages = [NSArray arrayWithObjects:
                                 [UIImage imageNamed:@"im_my_talk_1"],
                                 [UIImage imageNamed:@"im_my_talk_2"],
                                 [UIImage imageNamed:@"im_my_talk_3"],nil];
            img.animationImages = myImages;
            
            
            img.animationDuration = 0.45;//设置动画时间
            img.animationRepeatCount = 3;//设置动画次数 0 表示无限
            [img setTag:3];
            [_contentBtn addSubview:img];
        }
            break;
        case AudioFromOther:
        {
//            _contentBtn.contentEdgeInsets = UIEdgeInsetsMake(kContentTop, kContentLeft, kContentBottom, kContentRight);
            _contentBtn.frame = CGRectMake(_messageFrame.contentFrame.origin.x-45, _messageFrame.contentFrame.origin.y, 200, 35);
            [[_contentBtn viewWithTag:911] removeFromSuperview];
            UIImage *normal ;
            UIImageView * img =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 107, 35)];
            normal = [UIImage imageNamed:@"im_talk_3"];
            normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.7];
            [img setImage:normal];

            
            NSArray* myImages = [NSArray arrayWithObjects:
                        [UIImage imageNamed:@"im_talk_1"],
                        [UIImage imageNamed:@"im_talk_2"],
                        [UIImage imageNamed:@"im_talk_3"],nil];
            img.animationImages = myImages;
            
            
            img.animationDuration = 0.45;//设置动画时间
            img.animationRepeatCount = 3;//设置动画次数 0 表示无限
            [img setTag:3];
            [_contentBtn addSubview:img];
        }
            break;

    }

}

#pragma mark -show original image

-(void)clickToShowOriginalImageOrPlayAudio:(id)sender
{
    UIButton* button = (UIButton *)sender;
    switch (button.tag) {
        case ImageFromOther:{
        
        }
            break;
        case ImageFromMe:{
        
        }

            break;
            
        case  AudioFromMe:{
        
        }
            break;
        case AudioFromOther:{
        
        }
            break;
            
        default:
            
            break;
    }
}



-(void)setCellContent:(LMMessage*)message on:(UIButton*)button{
    if (button.tag == MessageFromMe||
        button.tag == MessageFromOther) {
        [button setTitle:message.text forState:UIControlStateNormal];
        [button setImage:nil forState:UIControlStateNormal];
    }else if(button.tag ==ImageFromMe||
             button.tag == ImageFromOther ){
        [button setTitle:nil forState:UIControlStateNormal];
        [button setImage:message.image forState:UIControlStateNormal];

    }
}


@end
