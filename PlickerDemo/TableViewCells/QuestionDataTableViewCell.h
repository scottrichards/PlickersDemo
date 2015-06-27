//
//  QuestionDataTableViewCell.h
//  PlickerDemo
//
//  Created by Scott Richards on 6/27/15.
//  Copyright (c) 2015 Scott Richards. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionDataTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *questionBody;
@property (weak, nonatomic) IBOutlet UILabel *questionAnswer;

@end
