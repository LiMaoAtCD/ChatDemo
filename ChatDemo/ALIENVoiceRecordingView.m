//
//  ALIENVoiceRecordingView.m
//  ChatDemo
//
//  Created by AlienLi on 14-9-2.
//  Copyright (c) 2014年 AlienLi. All rights reserved.
//

#import "ALIENVoiceRecordingView.h"

@implementation ALIENVoiceRecordingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor grayColor];
        _RecordingView = [[UIView alloc] initWithFrame:CGRectMake(116, 58, 100, 100)];
        _RecordingView.backgroundColor = [UIColor redColor];
        [self addSubview:_RecordingView];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [touches enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        UITouch *touch = (UITouch *)obj;
        if (CGRectContainsPoint(self.RecordingView.bounds, [touch locationInView:self.RecordingView])) {
//            开始录音
            NSLog(@"begin");
        }
    }];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [touches enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        UITouch *touch = (UITouch *)obj;
        if (CGRectContainsPoint(self.bounds, [touch locationInView:self.RecordingView])) {
            //            开始录音
            NSLog(@"end");
        }else{
            NSLog(@"cancel");
        }
    }];
}

@end
