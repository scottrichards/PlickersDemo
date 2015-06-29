//
//  StudentResultsTableViewController.h
//  PlickerDemo
//
//  Created by Scott Richards on 6/28/15.
//  Copyright (c) 2015 Scott Richards. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestData.h"

@interface StudentResultsTableViewController : UITableViewController
@property (strong,nonatomic) TestData *testData;
@end
