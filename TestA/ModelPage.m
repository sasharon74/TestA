//
//  ModelPage.m
//  TestA
//
//  Created by Alex on 15.10.15.
//  Copyright © 2015 Alex. All rights reserved.
//

#import "ModelPage.h"

NSString *const urlGetPhoto = @"http://v12.50pages.ru/i/%@";

@implementation ModelPage

- (id)initWithDictionary:(NSDictionary *)dictionaryPages
{
    self = [super init];
    
    if (self)
    {
        self.title = [dictionaryPages objectForKey:@"title"];
        
        NSString *date = [[dictionaryPages objectForKey:@"date"]objectForKey:@"date"];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *dateChange = [dateFormat dateFromString:date];
        [dateFormat setDateFormat:@"dd.MM.yyyy"];
        NSString *dateStr = [dateFormat stringFromDate:dateChange];
        self.date = dateStr;
        
        
        self.text = [dictionaryPages objectForKey:@"text"];
        
        NSString *pathPhoto = [[[dictionaryPages objectForKey:@"photos"]objectAtIndex:0]objectForKey:@"path"];
        NSString *fullPathPhoto = [NSString stringWithFormat:urlGetPhoto, pathPhoto];
        self.urlImage = [NSURL URLWithString:fullPathPhoto];
    }
    return self;
}

@end
