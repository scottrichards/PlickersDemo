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
    switch (_answer) {
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

-(BOOL)isAnswerCorrect:(NSString *)answer
{
    return [answer isEqualToString:[self getMultipleChoiceAnswer]];
}
@end
