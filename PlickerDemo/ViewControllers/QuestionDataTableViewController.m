//
//  QuestionDataTableViewController.m
//  PlickerDemo
//
//  Created by Scott Richards on 6/27/15.
//  Copyright (c) 2015 Scott Richards. All rights reserved.
//

#import "QuestionDataTableViewController.h"
#import "QuestionData.h"
#import "QuestionDataTableViewCell.h"

@interface QuestionDataTableViewController ()

@end

@implementation QuestionDataTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_testData.questions count];   // TO DO implement convenience method
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QuestionDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[QuestionDataTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (cell) {
        QuestionData *questionData = _testData.questions[indexPath.row];
        cell.questionBody.text = questionData.body;
        cell.questionAnswer.text = [questionData getMultipleChoiceAnswer];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // View for the header
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 22)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    // Label for Question
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 12, 100, 18)];
    [label setFont:[UIFont systemFontOfSize:15]];
    label.text=@"Question";
    label.textColor = [UIColor lightGrayColor];
    [headerView addSubview:label];
    
    // Label for Percent Complete
    UILabel *percentComplete = [[UILabel alloc] initWithFrame:CGRectMake(tableView.frame.size.width - 60, 12, 60, 18)];
    [percentComplete setFont:[UIFont systemFontOfSize:15]];
    percentComplete.text=@"Answer";
    percentComplete.textColor = [UIColor lightGrayColor];
    [headerView addSubview:percentComplete];
    
    // 3. And return
    return headerView;
}

@end
