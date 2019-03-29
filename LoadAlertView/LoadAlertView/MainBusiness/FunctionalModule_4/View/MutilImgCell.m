//
//  MutilImgCell.m
//  LoadAlertView
//
//  Created by doman on 2019/3/29.
//  Copyright © 2019年 doman. All rights reserved.
//

#import "MutilImgCell.h"

@implementation MutilImgCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)initWithImgDataArray:(NSArray *)dataArray{

    // pictures.count中的pictures是一个图片数组，代表着要添加多少个图片
    
    //如果满九张就显示九张,可有功能删除和放大查看
    //当删除图片后不满九张或者本来不满九张,就在数组第一个添加为空的标识,此按钮点击即可添加图片
    
    BOOL isMaxNine = false;
    dataArray.count == 9 ?  (isMaxNine = true) : (isMaxNine = false);
    
    NSMutableArray * numberArr = [NSMutableArray arrayWithArray:dataArray];
    if (!isMaxNine) {
        [numberArr insertObject:@"" atIndex:0];
    }
    
    for (int i = 0; i < numberArr.count; i++) {
        // 图片所在行
        NSInteger row = i / 3;
        // 图片所在列
        NSInteger col = i % 3;
        // PointX
        CGFloat picX =  10 + ((self.width - 20)/3) * col;
        // PointY
        CGFloat picY =  10 + (self.width /3 - 10) * row;
    
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(picX, picY, (self.width/3 - 15), (self.width/3 - 15))];
        button.backgroundColor = [UIColor purpleColor];
        
        if (!isMaxNine) {
            if (i == 0) {
                button.tag = 20000;
            }else{
                button.tag = i - 1;
            }
        }else{
            button.tag = i;
        }
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
    }
}

- (void) buttonClick:(UIButton *) sender
{
    if (_imgHandleCallBack) {
        _imgHandleCallBack(sender.tag);
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
