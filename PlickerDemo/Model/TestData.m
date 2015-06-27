//
//  TestData.m
//  PlickerDemo
//
//  Created by Scott Richards on 6/27/15.
//  Copyright (c) 2015 Scott Richards. All rights reserved.
//

#import "TestData.h"
#import "QuestionData.h"
#import "NSMutableArray+Utility.h"

const int kUnspecifiedValue = -1;

@implementation TestData


-(void)parseJSONTestData:(NSArray *)jsonArray
{
    _correctAnswers = [[NSMutableArray alloc] initWithCapacity:[jsonArray count]];
    _questions = [[NSMutableArray alloc] initWithCapacity:[jsonArray count]];
    [_correctAnswers fillArray:[jsonArray count] initialValue:@-1];      // fill array with unspecified values
    NSUInteger questionNumber = 0;
    for (NSDictionary *item in jsonArray) {
        NSLog(@"item: %@",item);
        NSDictionary *question = item[@"question"];
        QuestionData *questionData = [QuestionData new];
        if (question) {
            questionData.body = question[@"body"];
            questionData.answer = kUnspecifiedValue;
            // parse the choices for each question and identify the correct answer
            NSArray *choices = question[@"choices"];
            if (choices) {
                for (NSUInteger i=0;i<[choices count];i++) {
                    NSDictionary *choice = choices[i];
                    NSNumber *isSuccessNumber = choice[@"correct"];
                    if ([isSuccessNumber boolValue]) {
                        NSLog(@"correct choice is: %ld",i);
                        NSNumber *correctAnswer = [NSNumber numberWithUnsignedInt:(uint)i];
                        [_correctAnswers replaceObjectAtIndex:questionNumber withObject:correctAnswer];
                        questionData.answer = i;
                    }
                }
            }
        }
        NSArray *responses = item[@"responses"];
        if (responses) {
            questionData.numResponses = [responses count];
            for (NSDictionary *response in responses) {
                BOOL isCorrect;
                NSString *studentAnswer = response[@"answer"];
                if (questionData)
                    isCorrect = [questionData isAnswerCorrect:studentAnswer];
                NSLog(@"Student: %@ Answer: %@ Correct: %@",response[@"student"],response[@"answer"], isCorrect ? @"Yes" : @"No");
                if (isCorrect)
                    questionData.numCorrect++;
            }
            float percentCorrect = (float)questionData.numCorrect/questionData.numResponses;
            questionData.percentCorrect = [NSNumber numberWithFloat:percentCorrect];
            NSLog(@"Question #: %ld # Responses: %ld # Correct: %ld Correct: %f",questionNumber,questionData.numResponses,questionData.numCorrect,percentCorrect);
        }
        _questions[questionNumber++] = questionData;
    }
    uint questionCount = 0;
    for (NSNumber *correctAnswer in _correctAnswers) {
        NSLog(@"Question #: %d answer = %ld",questionCount++,[correctAnswer integerValue]);
    }
}


@end
