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
static const float ktextViewBGMarginToSuper = 8.0;
static const float ktextViewBGHeight = 28.0;
static const float ktextViewBGWidth = 190.0;

//textview & background view 间隔
static const float kMarginTVAndBK_X = 2.0;
static const float kMarginTVAndBK_Y = 3.0;

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
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(kMarginX, kMarginY, kImageWidth, kImageHeight);
        [button addTarget:self action:@selector(swapVoiceOrKeyBoardImage:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@"im_tab_voice"] forState:UIControlStateNormal];
        button.tag = inputViewTypeTagVoice;
        [self addSubview:button];
//        点击输入文字或者开始录音
       self.textViewBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kMarginX+kImageWidth+kMarginX, ktextViewBGMarginToSuper, ktextViewBGWidth, ktextViewBGHeight)];
        self.textViewBackgroundImageView.image =[UIImage imageNamed:@"im_box1"];
         self.textViewBackgroundImageView.image = [self.textViewBackgroundImageView.image resizableImageWithCapInsets:UIEdgeInsetsMake(24, 150, 24, 150) resizingMode:UIImageResizingModeStretch];

        [self addSubview:self.textViewBackgroundImageView];
        

        self.textView= [[UITextView alloc] initWithFrame:CGRectMake(kMarginX+kImageWidth+kMarginX+kMarginTVAndBK_X, ktextViewBGMarginToSuper+kMarginTVAndBK_Y, ktextViewBGWidth- 1.5*kMarginTVAndBK_X, ktextViewBGHeight- 2*kMarginTVAndBK_Y) textContainer:nil];

        self.textView.delegate = self;
        self.textView.font = [UIFont systemFontOfSize:kFontSize];
        self.textView.returnKeyType = UIReturnKeySend;
        
        [self addSubview:self.textView];
        
        UIButton *otherButton = [UIButton buttonWithType:UIButtonTypeCustom];
        otherButton.frame = CGRectMake(240, 4.5, 35.0, 35.0);
        [otherButton addTarget:self action:@selector(swapVoiceOrKeyBoardImage:) forControlEvents:UIControlEventTouchUpInside];
        [otherButton setImage:[UIImage imageNamed:@"im_tab_plus"] forState:UIControlStateNormal];
        otherButton.tag = inputViewTypeTagEmoj;
        [self addSubview:otherButton];
        
        UIButton *lastButton = [UIButton buttonWithType:UIButtonTypeCustom];
        lastButton.frame = CGRectMake(280, 4.5, 35.0, 35.0);
        [lastButton addTarget:self action:@selector(swapVoiceOrKeyBoardImage:) forControlEvents:UIControlEventTouchUpInside];
        [lastButton setImage:[UIImage imageNamed:@"im_tab_plus"] forState:UIControlStateNormal];
        lastButton.tag = inputViewTypeTagOther;
        [self addSubview:lastButton];
        
        
        self.voiceInputView = [[UIView alloc] initWithFrame:CGRectMake(0, 216, 320, 216)];
        
        self.voiceInputView.backgroundColor = [UIColor yellowColor];
        
        UIView *voice = [[UIView alloc] initWithFrame:CGRectMake(320/2-100/2, 216/2-100/2, 100, 100)];
        voice.backgroundColor = [UIColor blackColor];

//        UITapGestureRecognizer *tap = [UITapGestureRecognizer alloc] initWithTarget:self action:@selector(<#selector#>)
        [self.voiceInputView addSubview:voice];
        
//
 
        
        
    }
    return self;
}
static inputViewTypeTag preTag;


-(void)swapVoiceOrKeyBoardImage:(id)sender
{
    self.inputButton = (UIButton*)sender;
//
    if (self.inputButton.tag == inputViewTypeTagVoice){
//        切换到录音视图
        self.inputButton.tag = inputViewTypeTagKeyboard;
        preTag = inputViewTypeTagVoice;
        [self.inputButton setImage:[UIImage imageNamed:@"im_tab_word"] forState:UIControlStateNormal];

        if ([self.delegate respondsToSelector:@selector(didSwitchTextInputORVoiceInput:)]) {
            [self.delegate didSwitchTextInputORVoiceInput:inputViewTypeTagVoice];
        }
        
    }else if(self.inputButton.tag ==inputViewTypeTagEmoj){
//        图片或者其他
        self.inputButton.tag = inputViewTypeTagKeyboard;
        preTag = inputViewTypeTagEmoj;
        [self.inputButton setImage:[UIImage imageNamed:@"im_tab_word"] forState:UIControlStateNormal];
        
        
    }else if (self.inputButton.tag ==inputViewTypeTagOther){
//        图片或者其他
    }else if(self.inputButton.tag == inputViewTypeTagKeyboard){
        
        if ( preTag == inputViewTypeTagVoice) {
            
//            self.inputButton.tag = inputViewTypeTagVoice;
//            [self.inputButton setImage:[UIImage imageNamed:@"im_tab_voice"] forState:UIControlStateNormal];

//            if ([self.delegate respondsToSelector:@selector(didSwitchTextInputORVoiceInput:)]) {
//                [self.delegate didSwitchTextInputORVoiceInput:inputViewTypeTagKeyboard];
//            }
            [self.textView becomeFirstResponder];
            self.inputButton.tag = inputViewTypeTagVoice;
            
        }

    }else{
        NSAssert(self.inputButton.tag, @"button.tag is illegal");
    }
    
}

#pragma mark -textview delegate


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        textView.text = nil;
        
        [textView resignFirstResponder];
        if ([self.delegate respondsToSelector:@selector(didClickedSendButtonOnKeyboard)]) {
            [self.delegate didClickedSendButtonOnKeyboard];
        }
        return NO;
    }else{
        if ([self.delegate respondsToSelector:@selector(didReceiveTheInputViewHeightChanged)]) {
            [self.delegate didReceiveTheInputViewHeightChanged];
        }
        return YES;
    }

}
//开始textview 编辑

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    
    if([self.delegate respondsToSelector:@selector(AlienTextViewDidBeginEditing)])
    {
//        如果直接点击textView按钮
                preTag = inputViewTypeTagVoice;
                self.inputButton.tag = inputViewTypeTagKeyboard;
                [self.inputButton setImage:[UIImage imageNamed:@"im_tab_voice"] forState:UIControlStateNormal];
                [self.delegate AlienTextViewDidBeginEditing];
    }
}

@end
