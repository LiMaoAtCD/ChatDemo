//
//  ChatViewController.h
//  ChatDemo
//
//  Created by AlienLi on 14-8-28.
//  Copyright (c) 2014年 AlienLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALIENMessageDataModel;

@interface ChatViewController : UIViewController

@property (nonatomic,strong) UIImageView *chatBackGroundImageView;
@property (nonatomic,strong) ALIENMessageDataModel *dataModel;

-(void)setImageStyleOfChatBackGround:(UIImage*)image;
@end
