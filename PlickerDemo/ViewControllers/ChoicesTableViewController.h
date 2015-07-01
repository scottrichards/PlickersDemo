//
//  ChoicesTableViewController.h
//  PlickerDemo
//
//  Created by Scott Richards on 7/1/15.
//  Copyright (c) 2015 Scott Richards. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionData.h"

@interface ChoicesTableViewController : UITableViewController
@property (strong,nonatomic) QuestionData *questionData;
@property (strong, nonatomic) NSNumberFormatter *percentNumberFormatter;
@end
