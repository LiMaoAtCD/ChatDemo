//
//  ChatViewController.m
//  ChatDemo
//
//  Created by AlienLi on 14-8-28.
//  Copyright (c) 2014年 AlienLi. All rights reserved.
//

#import "ChatViewController.h"
#import "LMTableViewCell.h"
#import "LMMessageFrame.h"
#import "LMMessage.h"
#import "ALIENKeyBoardView.h"
#import "ALIENVoiceRecordingView.h"
#import "MJRefresh.h"
#import "ALIENMessageDataModel.h"

#import "ALIENEmojiView.h"
#import "ALIENAddtionView.h"

@interface ChatViewController ()<UITableViewDataSource,UITableViewDelegate,keyBoardViewDelegate>

@property (nonatomic,strong) UIView *bgView;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *DataModelArray;


@property (nonatomic,strong) LMMessageFrame *tempMessageFrame;



@property (nonatomic,strong) NSMutableArray *cellHeightArray;
@property (nonatomic,strong) NSMutableArray *cellMessageArray;

@property (nonatomic,strong) ALIENKeyBoardView *keyboardView;

@property (nonatomic,assign) CGRect keyBoardHelpFrame;
@property (nonatomic,assign) CGRect bgTempFrame;
@property (nonatomic,assign) CGRect textViewTempFrame;
@property (nonatomic,assign) CGRect textViewImageTempFrame;

@property (nonatomic,strong) UIPanGestureRecognizer *pullDownGesture;
@property (nonatomic,strong) ALIENVoiceRecordingView *recordingView;
@property (nonatomic,strong) ALIENEmojiView *emojiView;
@property (nonatomic,strong) ALIENAddtionView *addtionView;

@end


@implementation ChatViewController

static NSString *reuserIdentifier = @"Cell";
static const int keyBoardHeight = 44.0;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

#pragma mark - setter
-(void)setImageStyleOfChatBackGround:(UIImage*)image
{
    if (image) {
        self.chatBackGroundImageView.image = image;
    }else{
    self.chatBackGroundImageView.image = [UIImage imageNamed:@"scene"];
    }
    
}

#pragma mark -life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     self.view.backgroundColor = [UIColor whiteColor];
    
    _bgView = [[UIView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:_bgView];
    
   
    self.chatBackGroundImageView= [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.chatBackGroundImageView.image = [UIImage imageNamed:@"scene"];
    [self.bgView addSubview:self.chatBackGroundImageView];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height-keyBoardHeight) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerClass:[LMTableViewCell class]forCellReuseIdentifier:reuserIdentifier];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    [self.bgView addSubview:self.tableView];
    
//    
    self.keyboardView = [[ALIENKeyBoardView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height -keyBoardHeight, self.view.bounds.size.width, keyBoardHeight)];
    self.keyboardView.delegate =self;
    [self.bgView addSubview:self.keyboardView];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setupDataModel];
    
//    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.cellMessageArray.count -1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];

    [self registerForKeyboardNotifications];
    
    [self setupMJRefresh];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
     _pullDownGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(needResignFirstResponer)];
    
    _recordingView = [[ALIENVoiceRecordingView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, 320, 216)];
    _emojiView = [[ALIENEmojiView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, 320, 216)];
    _addtionView = [[ALIENAddtionView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, 320, 216)];
    
    
    
    [self needCacheCurrentLayouts];
}


-(void)setupMJRefresh
{
    [self.tableView addHeaderWithTarget:self action:@selector(refreshTableView:)];
}

-(void)refreshTableView:(id)sender
{
    // 1.添加数据
    for (int i = 0; i<5; i++) {
        //            [self.fakeData insertObject:MJRandomData atIndex:0];
        //            self setDataModel
        LMMessage *message = [[LMMessage alloc] initWithContent:self.DataModelArray[self.DataModelArray.count - i-1]];
        [self.cellMessageArray insertObject:message atIndex:0];
        
        LMMessageFrame *messageFrame = [[LMMessageFrame alloc] init];
        messageFrame.message = message;
        
        [self.cellHeightArray insertObject:@(messageFrame.cellHeight) atIndex:0];
        
    }
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView headerEndRefreshing];
    });
}

#pragma mark - 关于键盘视图

//保存当前frames ，等待textview 失去焦点时恢复视图

-(void)needCacheCurrentLayouts
{
    self.keyBoardHelpFrame = self.keyboardView.frame;
    self.bgTempFrame = self.tableView.frame;
    self.textViewTempFrame = self.keyboardView.textView.frame;
//    self.textViewImageTempFrame = self.keyboardView.textViewBackgroundImageView.frame;
}

//重装键盘视图

-(void)restoreKeyboard
{
    [UIView animateWithDuration:0.25 animations:^{
        self.keyboardView.frame = self.keyBoardHelpFrame;
        self.tableView.frame= self.bgTempFrame;
        self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        self.keyboardView.textView.frame= self.textViewTempFrame;
//        self.keyboardView.textViewBackgroundImageView.frame= self.textViewImageTempFrame;
        self.bgView.frame = CGRectMake(self.view.bounds.origin.x,self.view.bounds.origin.y, self.view.bounds.size.width,self.view.bounds.size.height);

    } completion:^(BOOL finished) {
        if (finished) {
            [self.emojiView removeFromSuperview];
            [self.addtionView removeFromSuperview];
            self.keyboardView.textView.text = nil;
            [self.keyboardView.textView resignFirstResponder];
            [self.recordingView removeFromSuperview];
            [self.tableView removeGestureRecognizer:self.pullDownGesture];
        }
    }];
    
}
#pragma mark - keyboard&voice&emoj&addtion  delegate

-(void)didReceiveTheInputViewHeightChanged
{
//    计算行数
    CGFloat textViewHeight = self.keyboardView.textView.font.lineHeight;
    
    int numberofLine = (self.keyboardView.textView.contentSize.height)/textViewHeight;
    
    if (numberofLine<4) {
        
        [UIView animateWithDuration:0.01 animations:^{
//            1
            self.tableView.frame = CGRectMake(self.bgTempFrame.origin.x,self.bgTempFrame.origin.y - (numberofLine -1)* textViewHeight, self.bgTempFrame.size.width,self.bgTempFrame.size.height);
//            2
            self.keyboardView.frame = CGRectMake(self.keyBoardHelpFrame.origin.x, self.keyBoardHelpFrame.origin.y -(numberofLine-1) * textViewHeight,self.keyBoardHelpFrame.size.width,self.keyBoardHelpFrame.size.height+(numberofLine-1) * textViewHeight);
//            3
            self.keyboardView.textView.frame =CGRectMake(self.textViewTempFrame.origin.x, self.textViewTempFrame.origin.y, self.textViewTempFrame.size.width, self.textViewTempFrame.size.height+(numberofLine-1)*textViewHeight);
//            4
//            self.keyboardView.textViewBackgroundImageView.frame = CGRectMake(self.textViewImageTempFrame.origin.x, self.textViewImageTempFrame.origin.y, self.textViewImageTempFrame.size.width, self.textViewImageTempFrame.size.height + (numberofLine-1)*textViewHeight);
        } completion:^(BOOL finished) {
        }];
        
        
        
    }
}

//点击发送消息
-(void)didClickedSendButtonOnKeyboard:(NSString*)text
{
//    [self restoreKeyboard];
    
//
//    MessageFromMe = 0, // 自己发的
//    MessageFromOther, //别人发得
//    ImageFromMe,
//    ImageFromOther,
//    AudioFromMe,
//    AudioFromOther
    
    LMMessage *message = [[LMMessage alloc] initWithContent:@{
                                                              @"avatar":@"1",
                                                              @"messageType":@"0",
                                                              @"time":@"2014-09-03",
                                                              @"text":text
                                                              }];

    LMMessageFrame *messageFrame = [[LMMessageFrame alloc] init];
    messageFrame.message = message;
    
    [self.cellMessageArray addObject:message];
    [self.cellHeightArray addObject:@(messageFrame.cellHeight)];
    
    
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.cellMessageArray.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
    [self.tableView endUpdates];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.cellMessageArray.count -1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];

}


//键盘，表情，等视图输入切换
-(void)didSwitchTextInputORVoiceInput:(inputViewTypeTag)inputType
{
    switch (inputType) {
            
//            这家伙可能想要咆哮
        case inputViewTypeTagVoice:
        {
//            清理渣渣撇撇
            [self.recordingView removeFromSuperview];
            [self.emojiView removeFromSuperview];
            [self.addtionView removeFromSuperview];
            [self.keyboardView.textView resignFirstResponder];
            
//            添加叫床视图
            if (!self.recordingView) {
                self.recordingView = [[ALIENVoiceRecordingView alloc]initWithFrame:CGRectZero];
            }
            self.recordingView.Frame = CGRectMake(0, self.bgView.bounds.size.height, 320, 216);
           
            [self.view addSubview:self.recordingView];
            
//            添加下滑手势
            
            [self.tableView addGestureRecognizer:self.pullDownGesture];
            
            [self shoudCompletionDismissKeyboardView:NO];
               
            [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                self.recordingView.Frame = CGRectMake(0, self.bgView.bounds.size.height-216, 320, 216);
                } completion:^(BOOL finished) {
                    NSLog(@"这家伙可以叫床了");
                }];
        }
            break;
        case inputViewTypeTagEmoj:
        {
            //            清理渣渣撇撇
            [self.recordingView removeFromSuperview];
            [self.emojiView removeFromSuperview];
            [self.addtionView removeFromSuperview];
            [self.keyboardView.textView resignFirstResponder];
            
            //            添加叫床视图
            if (!self.emojiView) {
                self.emojiView = [[ALIENEmojiView alloc]initWithFrame:CGRectZero];
            }
            self.emojiView.Frame = CGRectMake(0, self.bgView.bounds.size.height, 320, 216);
            
            [self.view addSubview:self.emojiView];
            
            //            添加下滑手势
            
            [self.tableView addGestureRecognizer:self.pullDownGesture];
            
            [self shoudCompletionDismissKeyboardView:NO];
            
            [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                self.emojiView.Frame = CGRectMake(0, self.bgView.bounds.size.height-216, 320, 216);
            } completion:^(BOOL finished) {
                NSLog(@"这家伙可以面目全非了");
            }];

        }
            break;
            case inputViewTypeTagOther:
        {
            //            清理渣渣撇撇
            [self.recordingView removeFromSuperview];
            [self.emojiView removeFromSuperview];
            [self.addtionView removeFromSuperview];
            [self.keyboardView.textView resignFirstResponder];
            
            //            添加叫床视图
            if (!self.addtionView) {
                self.addtionView = [[ALIENAddtionView alloc]initWithFrame:CGRectZero];
            }
            self.addtionView.Frame = CGRectMake(0, self.bgView.bounds.size.height, 320, 216);
            
            [self.view addSubview:self.addtionView];
            
            //            添加下滑手势
            
            [self.tableView addGestureRecognizer:self.pullDownGesture];
            
            [self shoudCompletionDismissKeyboardView:NO];
            
            [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                self.addtionView.Frame = CGRectMake(0, self.bgView.bounds.size.height-216, 320, 216);
            } completion:^(BOOL finished) {
                NSLog(@"这家伙可以干啥子呢");
            }];

        }
            break;
            
            
        default:
            break;
        

    }

}
-(void)AlienTextViewDidBeginEditing
{
    //            清理渣渣撇撇
    [self.recordingView removeFromSuperview];
    [self.emojiView removeFromSuperview];
    [self.addtionView removeFromSuperview];
    
//    [self.keyboardView.textView resignFirstResponder];
    [self shoudCompletionDismissKeyboardView:NO];
}

#pragma mark -手势下滑隐藏键盘

-(void)needResignFirstResponer
{
    [self.recordingView removeFromSuperview];
    [self.keyboardView.textView resignFirstResponder];
    
    [self restoreKeyboard];
}
#pragma mark - setup dataModel
-(void)setupDataModel
{

    self.dataModel = [[ALIENMessageDataModel alloc] initWithDataModel];

    self.DataModelArray = self.dataModel.dataArray;
    
    self.cellHeightArray = [NSMutableArray array];
    self.cellMessageArray =[NSMutableArray array];
    
    
    LMMessageFrame* messageFrame = [[LMMessageFrame alloc] init];
    self.tempMessageFrame = [[LMMessageFrame alloc] init];
    
    
    [self.DataModelArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        LMMessage* message = [[LMMessage alloc] initWithContent:self.DataModelArray[idx]];
        [self.cellMessageArray addObject:message];
        
        messageFrame.message = message;
        [self.cellHeightArray addObject:@(messageFrame.cellHeight)];
    }];
    
}

#pragma mark -table DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.cellMessageArray.count;
}

-(LMTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserIdentifier forIndexPath:indexPath];

    self.tempMessageFrame.message = self.cellMessageArray[indexPath.row];
    cell.messageFrame = self.tempMessageFrame;
    
    return cell;
}

#pragma mark -tableView Delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [self.cellHeightArray[indexPath.row] floatValue];
    
    return height;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)shoudCompletionDismissKeyboardView:(BOOL)shoudDismiss
{

    if (shoudDismiss ==YES) {
        [UIView animateWithDuration:0.25 animations:^{
            self.bgView.frame = CGRectMake(0, 0, 320, self.view.frame.size.height);

        }];
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            self.bgView.frame =CGRectMake(0, -216, 320, self.view.frame.size.height);

        }];
    }
}
#pragma mark - keyboard action

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidFrameBeChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)keyboardDidFrameBeChanged:(NSNotification *)notification
{
    if (self.keyboardView.textView.isFirstResponder) {
        
        NSDictionary* info = [notification userInfo];
        
        CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
        [self.tableView removeGestureRecognizer:self.pullDownGesture];
        [self.tableView addGestureRecognizer:self.pullDownGesture];
        
        NSTimeInterval _duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];

        [UIView animateWithDuration:_duration animations:^{
            self.bgView.frame = CGRectMake(self.view.bounds.origin.x,self.view.bounds.origin.y - kbSize.height, self.view.bounds.size.width,self.view.bounds.size.height);
        }];
    }
}

#pragma mark - dealloc
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
