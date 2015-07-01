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
    cell.choiceLabel.text = choice.body;
    float percentCorrect = (float)[_questionData responsesForChoice:indexPath.row] / [_questionData numResponses];
    cell.percentLabel.text = [_percentNumberFormatter stringFromNumber:[NSNumber numberWithFloat:percentCorrect]];
    return cell;
}

@end
