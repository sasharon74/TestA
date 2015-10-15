//
//  ViewPage.m
//  TestA
//
//  Created by Alex on 15.10.15.
//  Copyright © 2015 Alex. All rights reserved.
//

#import "ViewPage.h"
#import "UIImageView+AFNetworking.h"

//Настройки положения infoBox
#define infoBoxYPersent 0.7f
#define infoBoxShiftX 0
#define alpfaInfoBox 0.7f

//Настройки title label
#define titleLabelShiftX 15
#define titleLabelHeightPersent 0.08f

//Настройки date label
#define dateLabelShiftX 15
#define dateLabelHeightPersent 0.05f

//Настройки text label
#define textLabelShiftX 15

@implementation ViewPage

- (id)initWithFrame:(CGRect)frame withUrlImage:(NSURL *)urlImage withTitle:(NSString *)title withDate:(NSString *)date withText: (NSString *)text
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        UIImageView *imageViewBackground = [[UIImageView alloc]initWithFrame:frame];
        [imageViewBackground setImageWithURL:urlImage];
        [imageViewBackground setClipsToBounds:YES];
        [imageViewBackground setContentMode:UIViewContentModeScaleAspectFill];
        [self addSubview:imageViewBackground];

        UIView *infoBox = [[UIView alloc]initWithFrame:CGRectMake(infoBoxShiftX,
                                                                  self.frame.size.height * infoBoxYPersent,
                                                                  self.frame.size.width,
                                                                  self.frame.size.height * (1 - infoBoxYPersent))];
        [infoBox setBackgroundColor:[UIColor blackColor]];
        [infoBox setAlpha:alpfaInfoBox];
        [self addSubview:infoBox];
        
        NSInteger y = self.frame.size.height * infoBoxYPersent;
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleLabelShiftX,
                                                                       y,
                                                                       self.frame.size.width - titleLabelShiftX*2,
                                                                       self.frame.size.height * titleLabelHeightPersent)];
        [titleLabel setNumberOfLines:0];
        [titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:20]];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.text = title;
        [titleLabel setTextColor:[UIColor whiteColor]];
        [self addSubview:titleLabel];
        
        y += self.frame.size.height * titleLabelHeightPersent;
        
        UILabel *dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(dateLabelShiftX,
                                                                      y,
                                                                      self.frame.size.width - dateLabelShiftX * 2,
                                                                      self.frame.size.height * dateLabelHeightPersent)];
        [dateLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:17]];
        dateLabel.adjustsFontSizeToFitWidth = YES;
        dateLabel.backgroundColor = [UIColor clearColor];
        dateLabel.text = date;
        [dateLabel setTextColor:[UIColor whiteColor]];
        [self addSubview:dateLabel];
        
        y += self.frame.size.height * dateLabelHeightPersent;
        
        UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(textLabelShiftX,
                                                                      y,
                                                                      self.frame.size.width - textLabelShiftX * 2,
                                                                      self.frame.size.height - (y + textLabelShiftX))];
        [textLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:17]];
        [textLabel setNumberOfLines:10];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.text = text;
        [textLabel setTextColor:[UIColor whiteColor]];
        [self addSubview:textLabel];
        
        
    }
    return self;
}

@end
