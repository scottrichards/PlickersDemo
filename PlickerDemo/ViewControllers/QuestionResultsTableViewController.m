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

@interface QuestionResultsTableViewController ()
@property (strong, nonatomic) NSNumberFormatter *percentNumberFormatter;
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


@end
