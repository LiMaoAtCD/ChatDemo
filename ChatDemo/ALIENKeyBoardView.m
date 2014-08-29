//
//  ALIENKeyBoardView.m
//  ChatDemo
//
//  Created by AlienLi on 14-8-29.
//  Copyright (c) 2014年 AlienLi. All rights reserved.
//

#import "ALIENKeyBoardView.h"

@implementation ALIENKeyBoardView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame = CGRectMake(frame.origin.x, frame.origin.y,frame.size.width, 44.0);
//        切换声音或者文本按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(5, 5, 34, 34);
        [button addTarget:self action:@selector(swapVoiceOrKeyBoardImage:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@"keyboardTiny"] forState:UIControlStateNormal];
        
        [self addSubview:button];
//        点击输入文字或者开始录音
        UIImageView *textViewBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 150, 34)];
        textViewBackgroundImageView.image =[UIImage imageNamed:@"textViewBackground"];
        [self addSubview:textViewBackgroundImageView];
        
        UITextView * textView = [[UITextView alloc]initWithFrame:CGRectMake(5, 5, 150, 34) textContainer:[[NSTextContainer alloc] initWithSize:CGSizeMake(150, 34)]];
        
        [self addSubview:textView];
//        
        UIButton *otherButton = [UIButton buttonWithType:UIButtonTypeCustom];
        otherButton.frame = CGRectMake(250, 5, 34, 34);
        [otherButton addTarget:self action:@selector(swapVoiceOrKeyBoardImage:) forControlEvents:UIControlEventTouchUpInside];
        [otherButton setImage:[UIImage imageNamed:@"keyboardTiny"] forState:UIControlStateNormal];
        
        [self addSubview:button];
        
        
        
        
        
    }
    return self;
}
-(void)swapVoiceOrKeyBoardImage:(id)sender
{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
