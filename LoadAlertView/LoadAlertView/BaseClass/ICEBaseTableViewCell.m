//
//  ICEBaseTableViewCell.m
//  LoadAlertView
//
//  Created by doman on 2019/3/29.
//  Copyright © 2019年 doman. All rights reserved.
//

#import "ICEBaseTableViewCell.h"

@implementation ICEBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0xE2/255.0f green:0xE2/255.0f blue:0xE2/255.0f alpha:0.5].CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height - 0.3, rect.size.width, 0.3));
}

@end
