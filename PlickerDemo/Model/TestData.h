//
//  TestData.h
//  PlickerDemo
//
//  Created by Scott Richards on 6/27/15.
//  Copyright (c) 2015 Scott Richards. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface TestData : NSObject
@property (strong, nonatomic) NSMutableArray *correctAnswers;
@property (strong, nonatomic) NSMutableArray *questions;
@property (strong, nonatomic) NSMutableDictionary *students;

-(void)parseJSONTestData:(NSArray *)jsonArray;
@end
