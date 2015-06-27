//
//  QuestionDataTableViewController.h
//  PlickerDemo
//
//  Created by Scott Richards on 6/27/15.
//  Copyright (c) 2015 Scott Richards. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestData.h"

@interface QuestionDataTableViewController : UITableViewController
@property (strong,nonatomic) TestData *testData;
@end
