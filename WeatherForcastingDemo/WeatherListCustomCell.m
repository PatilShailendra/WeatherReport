//
//  WeatherListCustomCell.m
//  WeatherForcastingDemo
//
//  Created by Shailendra on 09/04/15.
//  Copyright (c) 2015 Redbytes. All rights reserved.
#import "WeatherListCustomCell.h"

@implementation WeatherListCustomCell
@synthesize cityNameLbl, tempLbl,arrowImg;
@synthesize delegate;
@synthesize btn;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnAction:(UIButton *)sender
{
    if (delegate) {
        [delegate buttonAction:sender.tag];
    }
}

@end
