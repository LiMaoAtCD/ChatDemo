//
//  ALIENKeyBoardView.m
//  ChatDemo
//
//  Created by AlienLi on 14-8-29.
//  Copyright (c) 2014年 AlienLi. All rights reserved.
//

#import "ALIENKeyBoardView.h"

@implementation ALIENKeyBoardView

//物件间隔
static const float kMarginX = 4.5;
static const float kMarginY = 4.5;
//第一个按钮xy
static const float kImageHeight = 35.0;
static const float kImageWidth = 35.0;
//


//textView background
static const float ktextViewBGMarginToSuper = 7.0;
static const float ktextViewBGHeight = 28.0;
static const float ktextViewBGWidth = 190.0;

//textview & background view 间隔
static const float kMarginTVAndBK_X = 2.0;
//static const float kMarginTVAndBK_Y = 3.0;

//textView font
static const float kFontSize = 16.0;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        
        self.frame = CGRectMake(frame.origin.x, frame.origin.y,frame.size.width, 44.0);
//        切换声音或者文本按钮
        _VoiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _VoiceButton.frame = CGRectMake(kMarginX, kMarginY, kImageWidth, kImageHeight);
        [_VoiceButton addTarget:self action:@selector(swapVoiceOrKeyBoardImage:) forControlEvents:UIControlEventTouchUpInside];
        [_VoiceButton setImage:[UIImage imageNamed:@"im_tab_voice"] forState:UIControlStateNormal];
        _VoiceButton.tag = inputViewTypeTagVoice;
        [self addSubview:_VoiceButton];
        
//        点击输入文字或者开始录音
        
//       self.textViewBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kMarginX+kImageWidth+kMarginX, ktextViewBGMarginToSuper, ktextViewBGWidth, ktextViewBGHeight)];
//        
//         self.textViewBackgroundImageView.image = [[UIImage imageNamed:@"im_box1"] resizableImageWithCapInsets:UIEdgeInsetsMake(24, 150, 15, 150) resizingMode:UIImageResizingModeStretch];
//
//        [self addSubview:self.textViewBackgroundImageView];
        

        self.textView = [[UITextView alloc] initWithFrame:CGRectMake(kMarginX+kImageWidth+kMarginX+kMarginTVAndBK_X, ktextViewBGMarginToSuper, ktextViewBGWidth- 1.5*kMarginTVAndBK_X, 30.) textContainer:nil];
        [self.textView.layer setBorderWidth:1.0];
        self.textView.layer.cornerRadius = 3.0;
        self.textView.layer.masksToBounds = YES;
        [self.textView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        self.textView.delegate = self;
        self.textView.font = [UIFont systemFontOfSize:kFontSize];
        self.textView.returnKeyType = UIReturnKeySend;
        
        [self addSubview:self.textView];
        
        _EmojButton= [UIButton buttonWithType:UIButtonTypeCustom];
        _EmojButton.frame = CGRectMake(240, 4.5, 35.0, 35.0);
        [_EmojButton addTarget:self action:@selector(swapVoiceOrKeyBoardImage:) forControlEvents:UIControlEventTouchUpInside];
        [_EmojButton setImage:[UIImage imageNamed:@"im_emoji@2x"] forState:UIControlStateNormal];
        _EmojButton.tag = inputViewTypeTagEmoj;
        [self addSubview:_EmojButton];
        
        _AddtionButton= [UIButton buttonWithType:UIButtonTypeCustom];
        _AddtionButton.frame = CGRectMake(280, 4.5, 35.0, 35.0);
        [_AddtionButton addTarget:self action:@selector(swapVoiceOrKeyBoardImage:) forControlEvents:UIControlEventTouchUpInside];
        [_AddtionButton setImage:[UIImage imageNamed:@"im_tab_plus"] forState:UIControlStateNormal];
        _AddtionButton.tag = inputViewTypeTagOther;
        [self addSubview:_AddtionButton];
        
        _statusArray =[ @[@0,@0,@0]mutableCopy];
 
    }
    return self;
}
static BOOL clickButton = NO;

-(void)swapVoiceOrKeyBoardImage:(id)sender
{
    clickButton = YES;
    self.CurrentButton = (UIButton*)sender;
    
    if (self.CurrentButton == self.VoiceButton) {
        if ([_statusArray[0]integerValue]== 0) {
            _statusArray = [@[@1,@0,@0] mutableCopy];
//            录音
            
            [_VoiceButton setImage:[UIImage imageNamed:@"im_tab_word"] forState:UIControlStateNormal];
            [_EmojButton setImage:[UIImage imageNamed:@"im_emoji@2x"] forState:UIControlStateNormal];
            [_AddtionButton setImage:[UIImage imageNamed:@"im_tab_plus"] forState:UIControlStateNormal];
            
            if ([self.delegate respondsToSelector:@selector(didSwitchTextInputORVoiceInput:)]) {
                   [self.delegate didSwitchTextInputORVoiceInput:inputViewTypeTagVoice];
            }
            clickButton = NO;
            
        }else{
//            键盘
            [self xxxxxx];
            [self.textView becomeFirstResponder];

            
        }
    } else if (self.CurrentButton == self.EmojButton){
        if ([_statusArray[1]integerValue]== 0) {
            _statusArray = [@[@0,@1,@0] mutableCopy];
            //            表情
            [_VoiceButton setImage:[UIImage imageNamed:@"im_tab_voice"] forState:UIControlStateNormal];
            [_EmojButton setImage:[UIImage imageNamed:@"im_tab_word"] forState:UIControlStateNormal];
            [_AddtionButton setImage:[UIImage imageNamed:@"im_tab_plus"] forState:UIControlStateNormal];
            if ([self.delegate respondsToSelector:@selector(didSwitchTextInputORVoiceInput:)]) {
                [self.delegate didSwitchTextInputORVoiceInput:inputViewTypeTagEmoj];
            }
            clickButton = NO;
            
        }else{
            //            键盘
            [self xxxxxx];
            [self.textView becomeFirstResponder];
        }
    
    }else{
        if ([_statusArray[2]integerValue]== 0) {
            _statusArray = [@[@0,@0,@1] mutableCopy];
            //            附加
            [_VoiceButton setImage:[UIImage imageNamed:@"im_tab_voice"] forState:UIControlStateNormal];
            [_EmojButton setImage:[UIImage imageNamed:@"im_emoji@2x"] forState:UIControlStateNormal];
            [_AddtionButton setImage:[UIImage imageNamed:@"im_tab_word"] forState:UIControlStateNormal];
            if ([self.delegate respondsToSelector:@selector(didSwitchTextInputORVoiceInput:)]) {
                [self.delegate didSwitchTextInputORVoiceInput:inputViewTypeTagOther];
            }
            clickButton = NO;
            
        }else{
            //            键盘
            [self xxxxxx];
            [self.textView becomeFirstResponder];
        }
    }
}

-(void)xxxxxx
{
    _statusArray = [@[@0,@0,@0] mutableCopy];
    [_VoiceButton setImage:[UIImage imageNamed:@"im_tab_voice"] forState:UIControlStateNormal];
    [_EmojButton setImage:[UIImage imageNamed:@"im_emoji@2x"] forState:UIControlStateNormal];
    [_AddtionButton setImage:[UIImage imageNamed:@"im_tab_plus"] forState:UIControlStateNormal];
    clickButton = YES;
}
#pragma mark -textview delegate


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        
//        点击发送
        
        if ([self.delegate respondsToSelector:@selector(didClickedSendButtonOnKeyboard:)]&&
            ![textView.text isEqualToString:@""]) {
            
            [self.delegate didClickedSendButtonOnKeyboard:textView.text];
            textView.text = nil;
        }
        return NO;
    }
    
    return YES;
    

}

//开始textview 编辑

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if (clickButton == NO) {
        [self xxxxxx];
    }
    if([self.delegate respondsToSelector:@selector(AlienTextViewDidBeginEditing)])
    {
//        如果直接点击textView按钮

        [self.delegate AlienTextViewDidBeginEditing];
    }
}


//输入变化改变高度

-(void)textViewDidChange:(UITextView *)textView
{
    
    if ([self.delegate respondsToSelector:@selector(didReceiveTheInputViewHeightChanged)]) {
        [self.delegate didReceiveTheInputViewHeightChanged];
    }
}


@end
