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
        [numberArr insertObject:[UIImage imageNamed:@"addimage"] atIndex:0];
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
    
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(picX, picY, (self.width/3 - 15), (self.width/3 - 15))];
        imageView.userInteractionEnabled = true;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        //图片和链接
        if ([numberArr[i] isKindOfClass:[UIImage class]])
            [imageView setImage:numberArr[i]];
        else
            [imageView sd_setImageWithURL:numberArr[i] placeholderImage:[UIImage imageNamed:@"01"]];
        
        if (!isMaxNine) {
            if (i == 0) {
                imageView.tag = 20000;
            }else{
                imageView.tag = i - 1;
            }
        }else{
           imageView.tag = i;
        }
        
        [self addSubview:imageView];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonClick:)];
        [imageView addGestureRecognizer:tap];
    }
}

- (void) buttonClick:(UITapGestureRecognizer *) sender
{
    UIImageView * imgV = (UIImageView*)sender.view;
    if (_imgHandleCallBack) {
        _imgHandleCallBack(imgV.tag);
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
