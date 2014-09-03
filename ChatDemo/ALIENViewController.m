//
//  ALIENViewController.m
//  ChatDemo
//
//  Created by AlienLi on 14-8-28.
//  Copyright (c) 2014年 AlienLi. All rights reserved.
//

#import "ALIENViewController.h"
#import "ChatViewController.h"
#import "SubChatVC.h"
@interface ALIENViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    NSMutableArray *numberOfRow;
}


@property (weak, nonatomic) IBOutlet UITableView *list;



@end

@implementation ALIENViewController
static NSString * reuserIdentifier = @"Cell";
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    numberOfRow = [@[@2,@33]mutableCopy];
    
    [_list registerClass:[UITableViewCell class] forCellReuseIdentifier:reuserIdentifier];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:numberOfRow.count-1 inSection:0];
    [_list scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return numberOfRow.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"indexRow:%ld",indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    ChatViewController *chat = [self.storyboard instantiateViewControllerWithIdentifier:@"ChatViewController"];
//    chat.title =[NSString stringWithFormat:@"%ld",indexPath.row];
    SubChatVC *chat = [[SubChatVC alloc] init];
    
    [self.navigationController pushViewController:chat animated:YES];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
