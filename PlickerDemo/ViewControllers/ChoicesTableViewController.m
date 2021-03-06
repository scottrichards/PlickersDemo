//
//  ChoicesTableViewController.m
//  PlickerDemo
//
//  Created by Scott Richards on 7/1/15.
//  Copyright (c) 2015 Scott Richards. All rights reserved.
//

#import "ChoicesTableViewController.h"
#import "ChoicesTableViewCell.h"
#import "ChoiceObject.h"
#import "UIColor+Utility.h"



@interface ChoicesTableViewController ()

@end

@implementation ChoicesTableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!_percentNumberFormatter) {
        _percentNumberFormatter = [NSNumberFormatter new];
        [_percentNumberFormatter setNumberStyle:NSNumberFormatterPercentStyle];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    
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
    return [_questionData.choices count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChoicesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[ChoicesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    ChoiceObject *choice = _questionData.choices[indexPath.row];
    if (choice.correct) {   // add green background color to indicate the correct choice
        cell.backgroundColor = [UIColor colorFromHexString:@"99FF99"];
    }
    cell.choiceLabel.text = choice.body;
    float percentCorrect = (float)[_questionData responsesForChoice:indexPath.row] / [_questionData numResponses];
    cell.percentLabel.text = [_percentNumberFormatter stringFromNumber:[NSNumber numberWithFloat:percentCorrect]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    // Label for Question Body Text
    UILabel *questionBody = [[UILabel alloc] initWithFrame:CGRectMake(20, 12, tableView.frame.size.width-40, 100)];
    [questionBody setFont:[UIFont systemFontOfSize:12]];
    questionBody.text = _questionData.body;
    questionBody.numberOfLines = 0;
    [questionBody sizeToFit];
    NSLog(@"Label's frame is: %@", NSStringFromCGRect(questionBody.frame));
    float labelHeight = questionBody.frame.size.height;
    
    return 40 + labelHeight;
}

// Add the Question Text to the Header and row labels
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // View for the header
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 22)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    // Label for Question Body Text
    UILabel *questionBody = [[UILabel alloc] initWithFrame:CGRectMake(20, 12, tableView.frame.size.width-40, 100)];
    [questionBody setFont:[UIFont systemFontOfSize:12]];
    questionBody.text = _questionData.body;
    [headerView addSubview:questionBody];
    questionBody.numberOfLines = 0;
    [questionBody sizeToFit];
    float labelHeight = questionBody.frame.size.height;
    
    // Label for Question Label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, labelHeight + 20, 100, 18)];
    [label setFont:[UIFont systemFontOfSize:15]];
    label.text=@"Choice";
    label.textColor = [UIColor darkGrayColor];
    [headerView addSubview:label];
    
    // Label for Percent Complete
    UILabel *percentComplete = [[UILabel alloc] initWithFrame:CGRectMake(tableView.frame.size.width - 70, labelHeight + 20, 60, 18)];
    [percentComplete setFont:[UIFont systemFontOfSize:15]];
    percentComplete.text=@"%";
    percentComplete.textColor = [UIColor darkGrayColor];
    percentComplete.textAlignment = NSTextAlignmentRight;
    [headerView addSubview:percentComplete];
    
    return headerView;
}


@end
