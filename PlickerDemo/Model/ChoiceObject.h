//
//  ChoiceObject.h
//  PlickerDemo
//
//  Created by Scott Richards on 7/1/15.
//  Copyright (c) 2015 Scott Richards. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChoiceObject : NSObject
@property (strong, nonatomic) NSString *body;
@property (strong, nonatomic) NSString *letter;
@property (assign, nonatomic) BOOL correct;
@end
