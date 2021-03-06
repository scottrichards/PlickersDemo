//
//  QuestionData.m
//  PlickerDemo
//
//  Created by Scott Richards on 6/27/15.
//  Copyright (c) 2015 Scott Richards. All rights reserved.
//

#import "QuestionData.h"

@implementation QuestionData
-(NSString *)getMultipleChoiceAnswer
{
    return [self mapAnswerToLetter:_answer];
}

// map a numeric answer/choice (0-3) to a letter (A-D) e.g. 2->"C"
-(NSString *)mapAnswerToLetter:(NSUInteger)answer
{
    switch (answer) {
        case 0 :
            return @"A";
        case 1 :
            return @"B";
        case 2 :
            return @"C";
        case 3 :
            return @"D";
        default:
            return @"";
    }
}

// returns number of responses for the question for the choice (0-3)
-(NSUInteger)responsesForChoice:(NSUInteger)choice
{
    switch (choice) {
        case 0 :
            return _numA;
        case 1 :
            return _numB;
        case 2 :
            return _numC;
        case 3 :
            return _numD;
        default:
            return 0;
    }
}

// returns true if the answer is correct
// if correct answer is "B" passing in "B" returns true
-(BOOL)isAnswerCorrect:(NSString *)answer
{
    return [answer isEqualToString:[self getMultipleChoiceAnswer]];
}

// add a response with a letter value e.g. Johny responded choice A
-(void)addResponse:(NSString *)answer
{
    if ([answer isEqualToString:@"A"]) {
        _numA++;
    }
    if ([answer isEqualToString:@"B"]) {
        _numB++;
    }
    if ([answer isEqualToString:@"C"]) {
        _numC++;
    }
    if ([answer isEqualToString:@"D"]) {
        _numD++;
    }
}
@end
