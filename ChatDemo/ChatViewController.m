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
@interface ChatViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *DataModel;
@property (nonatomic,strong)LMMessageFrame *messageFrame;
@property (nonatomic,strong)LMMessage *message;

@end

@implementation ChatViewController
static NSString *reuserIdentifier = @"Cell";
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    

    [self.tableView registerClass:[LMTableViewCell class]forCellReuseIdentifier:reuserIdentifier];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    
    self.DataModel = [@[@2,@3,@2,@3,@2,@3,@2,@3,@2,@3,@2,@3,@2,@3,@2,@3,@2,@3,@2,@3,@2,@3,@2,@3,@2,@3,@2,@3]mutableCopy];
    
    self.messageFrame = [[LMMessageFrame alloc] init];
    self.message = [[LMMessage alloc] init];
    
//    self.message.dictionary = [@{@"avatar":@"ada",
//                                @"time":@"201202102",
//                                @"text":@"dandandandnn",
//                                @"originalImageUrl":@"www.baidu.com",
//                                @"messageType":@2
//                                 } mutableCopy];
    self.message.avatar = [UIImage imageNamed:@"1"];
    self.message.time =@"2014-08-28";
    self.message.text = @"_allMessagesFram";
    self.message.messageType = MessageFromMe;
    
    self.messageFrame.message = self.message;
    
}
#pragma mark -dataSource

-(LMTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserIdentifier forIndexPath:indexPath];
    cell.messageFrame = self.messageFrame;

    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.DataModel.count;
}

#pragma mark -delegate

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    return self.messageFrame.cellHeight;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
