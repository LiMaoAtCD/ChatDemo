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
-(void)didClickedSendButtonOnKeyboard:(NSString*)text;
-(void)AlienTextViewDidBeginEditing;
@end

@interface ALIENKeyBoardView : UIView<UITextViewDelegate>

@property (nonatomic,strong) UITextView * textView ;
@property (nonatomic,weak)id<keyBoardViewDelegate> delegate;

@property (nonatomic,strong) UIButton *CurrentButton;
@property (nonatomic,strong) UIButton *VoiceButton;
@property (nonatomic,strong) UIButton *EmojButton;
@property (nonatomic,strong) UIButton *AddtionButton;

@property (nonatomic,strong) NSMutableArray *statusArray;
@end
