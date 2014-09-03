//
//  ALIENKeyBoardView.h
//  ChatDemo
//
//  Created by AlienLi on 14-8-29.
//  Copyright (c) 2014年 AlienLi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, inputViewTypeTag) {
    inputViewTypeTagVoice = 0,
    inputViewTypeTagKeyboard,
    inputViewTypeTagEmoj,
    inputViewTypeTagOther
};

@protocol keyBoardViewDelegate <NSObject>

@optional

-(void)didReceiveTheInputViewHeightChanged;
-(void)didSwitchTextInputORVoiceInput:(inputViewTypeTag)inputType;
-(void)didClickedSendButtonOnKeyboard;
-(void)AlienTextViewDidBeginEditing;
@end

@interface ALIENKeyBoardView : UIView<UITextViewDelegate>

@property (nonatomic,strong) UIImageView *textViewBackgroundImageView;
@property (nonatomic,strong)UITextView * textView ;
@property (nonatomic,weak)id<keyBoardViewDelegate> delegate;


@property (nonatomic,strong)UIView *originalInputView;
@property (nonatomic,strong)UIView *voiceInputView;
@property (nonatomic,strong) UIButton *inputButton;

@end
