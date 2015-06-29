//
//  StudentObject.h
//  PlickerDemo
//
//  Created by Scott Richards on 6/27/15.
//  Copyright (c) 2015 Scott Richards. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StudentResponses : NSObject
@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) NSUInteger numResponses;
@property (assign, nonatomic) NSUInteger numCorrect;
@end
