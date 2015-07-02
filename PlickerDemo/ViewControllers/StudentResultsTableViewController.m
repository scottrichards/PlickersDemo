//
//  StudentResultsTableViewController.m
//  PlickerDemo
//
//  Created by Scott Richards on 6/28/15.
//  Copyright (c) 2015 Scott Richards. All rights reserved.
//

#import "StudentResultsTableViewController.h"
#import "StudentResultsTableViewCell.h"
#import "StudentResponses.h"

@interface StudentResultsTableViewController ()
@property (strong, nonatomic) NSNumberFormatter *percentNumberFormatter;
@end

@implementation StudentResultsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!_percentNumberFormatter) {
        _percentNumberFormatter = [NSNumberFormatter new];
        [_percentNumberFormatter setNumberStyle:NSNumberFormatterPercentStyle];
    }
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
    return [_testData.studentResults count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StudentResultsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[StudentResultsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    StudentResponses *studentResponses = _testData.studentResults[indexPath.row];
    cell.studentLabel.text = studentResponses.name;
    NSNumber *percentCorrect = [NSNumber numberWithFloat:(float)studentResponses.numCorrect / studentResponses.numResponses];
    NSString *percentString = [_percentNumberFormatter stringFromNumber:percentCorrect];
    cell.results.text = percentString;

    
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
    label.text=@"Student";
    label.textColor = [UIColor darkGrayColor];
    [headerView addSubview:label];
    
    // Label for Percent Complete
    UILabel *percentComplete = [[UILabel alloc] initWithFrame:CGRectMake(tableView.frame.size.width - 60, 12, 40, 18)];
    [percentComplete setFont:[UIFont systemFontOfSize:15]];
    percentComplete.text=@"%";
    percentComplete.textAlignment = NSTextAlignmentRight;
    percentComplete.textColor = [UIColor darkGrayColor];
    [headerView addSubview:percentComplete];
    
    // 3. And return
    return headerView;
}
@end
