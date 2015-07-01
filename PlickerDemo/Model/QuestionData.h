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
@property (assign, nonatomic) NSUInteger numResponses;  // the total number of responses to this question
@property (assign, nonatomic) NSUInteger numCorrect;    // the number of correct responses to this question
@property (assign, nonatomic) NSUInteger numA;          // number of people who answered choice A)
@property (assign, nonatomic) NSUInteger numB;
@property (assign, nonatomic) NSUInteger numC;
@property (assign, nonatomic) NSUInteger numD;
@property (strong, nonatomic) NSNumber *percentCorrect;
@property (strong, nonatomic) NSMutableArray *choices;

-(NSString *)getMultipleChoiceAnswer;
-(BOOL)isAnswerCorrect:(NSString *)answer;
-(void)addResponse:(NSString *)answer;          // add a response with a letter value e.g. Johny responded choice A
-(NSString *)mapAnswerToLetter:(NSUInteger)answer;  // map a numeric answer/choice (0-3) to a letter (A-D) e.g. 2->"C"
-(NSUInteger)responsesForChoice:(NSUInteger)choice;     // returns number of responses for the question for the choice (0-3)
@end
