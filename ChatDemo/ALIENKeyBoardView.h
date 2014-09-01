//
//  ALIENKeyBoardView.h
//  ChatDemo
//
//  Created by AlienLi on 14-8-29.
//  Copyright (c) 2014年 AlienLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol keyBoardViewDelegate <NSObject>

@optional
-(void)didReceiveTheInputViewHeightChanged;
-(void)didSwitchTextInputToVoiceInput;

@end

@interface ALIENKeyBoardView : UIView<UITextViewDelegate>

@property (nonatomic,strong) UIImageView *textViewBackgroundImageView;
@property (nonatomic,strong)UITextView * textView ;
@property (nonatomic,weak)id<keyBoardViewDelegate> delegate;
@end
