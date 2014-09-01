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
        button.frame = CGRectMake(4.5, 4.5, 35.0, 35.0);
        [button addTarget:self action:@selector(swapVoiceOrKeyBoardImage:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@"im_tab_voice"] forState:UIControlStateNormal];
        
        button.tag = 1;
        [self addSubview:button];
        
//        点击输入文字或者开始录音
        
       self.textViewBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(4.5+35.0+5.0, 4.5, 190.0, 35.0)];
        self.textViewBackgroundImageView.image =[UIImage imageNamed:@"im_box1"];
         self.textViewBackgroundImageView.image = [self.textViewBackgroundImageView.image resizableImageWithCapInsets:UIEdgeInsetsMake(24, 150, 24, 150) resizingMode:UIImageResizingModeStretch];
        self.textViewBackgroundImageView.layer.cornerRadius = 4.0;
        self.textViewBackgroundImageView.layer.masksToBounds = YES;
        [self addSubview:self.textViewBackgroundImageView];
        

        self.textView= [[UITextView alloc] initWithFrame:CGRectMake(4.5+35.0+5.0+3.0, 4.5+2.0, 190.0-6.0, 35.0 -4.0) textContainer:nil];

        self.textView.delegate = self;
        self.textView.font = [UIFont systemFontOfSize:16.0];
        self.textView.returnKeyType = UIReturnKeySend;
        [self addSubview:self.textView];
        
        UIButton *otherButton = [UIButton buttonWithType:UIButtonTypeCustom];
        otherButton.frame = CGRectMake(240, 4.5, 35.0, 35.0);
        [otherButton addTarget:self action:@selector(swapVoiceOrKeyBoardImage:) forControlEvents:UIControlEventTouchUpInside];
        [otherButton setImage:[UIImage imageNamed:@"im_tab_voice"] forState:UIControlStateNormal];
        otherButton.tag = 2;
        [self addSubview:otherButton];
        
        UIButton *lastButton = [UIButton buttonWithType:UIButtonTypeCustom];
        lastButton.frame = CGRectMake(280, 4.5, 35.0, 35.0);
        [lastButton addTarget:self action:@selector(swapVoiceOrKeyBoardImage:) forControlEvents:UIControlEventTouchUpInside];
        [lastButton setImage:[UIImage imageNamed:@"im_tab_voice"] forState:UIControlStateNormal];
        lastButton.tag = 3;
        [self addSubview:lastButton];
        
      
        
        
        
        
        
    }
    return self;
}
-(void)swapVoiceOrKeyBoardImage:(id)sender
{
    UIButton *button = (UIButton*)sender;
//        切换录音或者文字
    if (button.tag ==1){
        button.tag = 4;
        [button setImage:[UIImage imageNamed:@"im_tab_word"] forState:UIControlStateNormal];
        self.textViewBackgroundImageView.image = [UIImage imageNamed:@"im_box2"];
        [self.textView removeFromSuperview];
        self.textView.text = nil;
        if ([self.delegate respondsToSelector:@selector(didSwitchTextInputToVoiceInput)]) {
            [self.delegate didSwitchTextInputToVoiceInput];
        }
        
    }else if(button.tag ==2){
//        图片或者其他
    }else if (button.tag ==3){
//        图片或者其他
    }else if(button.tag ==4){
        button.tag =1;
        [button setImage:[UIImage imageNamed:@"im_tab_voice"] forState:UIControlStateNormal];
        [self addSubview:self.textView];
        self.textViewBackgroundImageView.image = [UIImage imageNamed:@"im_box1"];
        
        [self.textView becomeFirstResponder];
    }else{
        NSAssert(button.tag, @"button.tag is illegal");
    }
    
}

#pragma mark -textview delegate

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    NSLog(@"textViewDidBeginEditing");
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
        if ([self.delegate respondsToSelector:@selector(didReceiveTheInputViewHeightChanged)]) {
            [self.delegate didReceiveTheInputViewHeightChanged];
        }
    return YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    NSLog(@"textViewDidEndEditing");
}

@end
