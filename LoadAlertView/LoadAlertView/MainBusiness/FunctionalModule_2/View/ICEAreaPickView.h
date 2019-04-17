//
//  ICEAreaPickView.h
//  LoadAlertView
//
//  Created by doman on 2019/4/17.
//  Copyright © 2019 doman. All rights reserved.
//

#import "ICEBaseView.h"

typedef void(^selectProvinceCityAreaCallBack)(NSString *province, NSString *city, NSString *area,NSInteger aId);

NS_ASSUME_NONNULL_BEGIN

@interface ICEAreaPickView : ICEBaseView

@property (nonatomic, strong) NSArray *rootArray;

//数据字典
@property (nonatomic, strong)NSDictionary *areaDic;
//省级数组
@property (nonatomic, strong)NSMutableArray *provinceArr;
//城市数组
@property (nonatomic, strong)NSMutableArray *cityArr;
//区、县数组
@property (nonatomic, strong)NSMutableArray *districtArr;
/** 5.当前街道数组 */
@property (nonatomic, strong, nullable) NSMutableArray *arrayStreets;

//省份选择Button
@property (nonatomic, strong)UIButton *provinceBtn;
//城市选择Button
@property (nonatomic, strong)UIButton *cityBtn;
//区、县选择Button
@property (nonatomic, strong)UIButton *districtBtn;
//滑动线条
@property (nonatomic, strong)UIView *selectLine;

@property (nonatomic, copy) selectProvinceCityAreaCallBack selectProvinceCityAreaCall;

@end

NS_ASSUME_NONNULL_END
