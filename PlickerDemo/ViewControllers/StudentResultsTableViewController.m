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

@end
