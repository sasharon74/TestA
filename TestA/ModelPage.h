//
//  ModelPage.h
//  TestA
//
//  Created by Alex on 15.10.15.
//  Copyright © 2015 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelPage : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSURL *urlImage;
@property (nonatomic, strong) NSString *date;

- (id)initWithDictionary:(NSDictionary *)dictionaryPages;

@end
