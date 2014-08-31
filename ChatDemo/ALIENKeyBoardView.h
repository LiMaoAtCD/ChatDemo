//
//  ALIENKeyBoardView.h
//  ChatDemo
//
//  Created by AlienLi on 14-8-29.
//  Copyright (c) 2014年 AlienLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALIENKeyBoardView : UIView<UITextViewDelegate>

@property (nonatomic,strong) UIImageView *textViewBackgroundImageView;
@property (nonatomic,strong)UITextView * textView ;
@end
