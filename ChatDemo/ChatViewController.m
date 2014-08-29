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
@property (nonatomic,strong)LMMessageFrame *tempMessageFrame;
@property (nonatomic,strong)LMMessage *message;


@property (nonatomic,strong)NSMutableArray *cellHeightArray;
@property (nonatomic,strong)NSMutableArray *cellMessageArray;

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
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 44, 0);
    
    [self.view addSubview:self.tableView];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupDataModel];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.cellMessageArray.count -1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    

}

#pragma mark - setup dataModel
-(void)setupDataModel
{
    self.DataModel = [@[@{@"text":@"1",
                          @"time":@"2014-08-29",
                          @"avatar":@"1",
                          @"messageType":@"1",
                          },
                    @{@"text":@"dada014-08-2014-08-2014-08-2014-08-2014-08-2014-08-2014-08-2014-08-2",
                          @"time":@"2014-08-30",
                          @"avatar":@"1"
                          },
                        @{@"text":@"3",
                          @"time":@"2014-08-29",
                          @"avatar":@"1"
                          
                          },
                        @{@"text":@"4",
                          @"time":@"2014-08-29",
                          @"avatar":@"1"
                          
                          },
                        @{@"text":@"5",
                          @"time":@"2014-08-29",
                          @"avatar":@"1"
                          
                          },
                        @{@"text":@"6",
                          @"time":@"2014-08-29",
                          @"avatar":@"1"
                          },
                        @{@"text":@"dada014-08-2014-08-2014-08-2014-08-2014-08-2014-08-2014-08-2014-08-2",
                          @"time":@"2014-08-30",
                          @"avatar":@"1",
                          @"messageType":@"1"
                          },
                        @{@"text":@"8",
                          @"time":@"2014-08-29",
                          @"avatar":@"1"
                          
                          },
                        @{@"text":@"9",
                          @"time":@"2014-08-29",
                          @"avatar":@"1"
                          
                          },
                        @{@"text":@"10",
                          @"time":@"2014-08-29",
                          @"avatar":@"1"
                          
                          }]mutableCopy];
    
    self.cellHeightArray = [NSMutableArray array];
    self.cellMessageArray =[NSMutableArray array];
    
    
    _messageFrame = [[LMMessageFrame alloc] init];
    self.tempMessageFrame = [[LMMessageFrame alloc] init];
    
    
    [self.DataModel enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        _message = [[LMMessage alloc] initWithContent:self.DataModel[idx]];
        [self.cellMessageArray addObject:_message];
        
        _messageFrame.message = _message;
        [self.cellHeightArray addObject:@(_messageFrame.cellHeight)];
    }];

}

#pragma mark -dataSource

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

#pragma mark -delegate

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
