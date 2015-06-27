//
//  QuestionData.h
//  PlickerDemo
//
//  Created by Scott Richards on 6/27/15.
//  Copyright (c) 2015 Scott Richards. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionData : NSObject
@property (strong, nonatomic) NSString *body;
@property (assign, nonatomic) NSUInteger answer;
@property (assign, nonatomic) NSUInteger numResponses;
@property (assign, nonatomic) NSUInteger numCorrect;
@property (assign, nonatomic) NSNumber *percentCorrect;

-(NSString *)getMultipleChoiceAnswer;
-(BOOL)isAnswerCorrect:(NSString *)answer;
@end
