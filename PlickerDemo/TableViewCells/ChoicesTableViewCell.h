//
//  ChoicesTableViewCell.h
//  PlickerDemo
//
//  Created by Scott Richards on 7/1/15.
//  Copyright (c) 2015 Scott Richards. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoicesTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *choiceLabel;
@property (weak, nonatomic) IBOutlet UILabel *percentLabel;

@end
