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
        if (question) {
            QuestionData *questionData = [QuestionData new];
            questionData.body = question[@"body"];
            questionData.answer = kUnspecifiedValue;
            NSArray *choices = question[@"choices"];
            if (choices) {
                for (NSUInteger i=0;i<[choices count];i++) {
                    NSDictionary *choice = choices[i];
                    if (choice[@"correct"]) {
                        NSLog(@"correct choice is: %ld",i);
                        NSNumber *correctAnswer = [NSNumber numberWithUnsignedInt:(uint)i];
                        [_correctAnswers replaceObjectAtIndex:questionNumber withObject:correctAnswer];
                        questionData.answer = i;
                    }
                }
            }
            _questions[questionNumber++] = questionData;
        }
    }
    uint questionCount = 0;
    for (NSNumber *correctAnswer in _correctAnswers) {
        NSLog(@"Question #: %d answer = %ld",questionCount++,[correctAnswer integerValue]);
    }
}
@end
