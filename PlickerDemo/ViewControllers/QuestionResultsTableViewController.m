//
//  QuestionResultsTableViewController.m
//  PlickerDemo
//
//  Created by Scott Richards on 6/27/15.
//  Copyright (c) 2015 Scott Richards. All rights reserved.
//

#import "QuestionResultsTableViewController.h"
#import "QuestionResultsTableViewCell.h"
#import "QuestionData.h"
#import "ChoicesTableViewController.h"

@interface QuestionResultsTableViewController ()
@property (strong, nonatomic) NSNumberFormatter *percentNumberFormatter;
@property (strong, nonatomic) QuestionData *questionData;       // the selected questions questionData, when we are doing a segue to Choices
@end

@implementation QuestionResultsTableViewController

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
  return [_testData.questions count];   
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QuestionResultsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[QuestionResultsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    QuestionData *questionData = _testData.questions[indexPath.row];
    cell.questionLabel.text = questionData.body;
    NSString *percentString = [_percentNumberFormatter stringFromNumber:questionData.percentCorrect];
    cell.percentCorrect.text = percentString;
    
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
    percentComplete.text=@"%";
    percentComplete.textColor = [UIColor lightGrayColor];
    [headerView addSubview:percentComplete];

    // 3. And return
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected row: %ld",indexPath.row);
    _questionData = _testData.questions[indexPath.row];
    [self performSegueWithIdentifier:@"toChoices" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toChoices"]) {
        ChoicesTableViewController *choicesController = [segue destinationViewController];
        choicesController.questionData = _questionData;
    }
}

@end
