//
//  ICEAreaPickView.m
//  LoadAlertView
//
//  Created by doman on 2019/4/17.
//  Copyright © 2019 doman. All rights reserved.
//

#import "ICEAreaPickView.h"

#import "ICEAreaModel.h"

#define windowContentWidth  ([[UIScreen mainScreen] bounds].size.width)

//当前tableview所处的状态
NS_ENUM(NSInteger,PickState) {
    ProvinceState,//选择省份状态
    CityState,//选择城市状态
    DistrictState//选择区、县状态
};

@interface ICEAreaPickView ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *selectedProvince;
    NSString *selectedCity;
}

@property (nonatomic, strong)UITableView *tableView;

@end

@implementation ICEAreaPickView

- (NSArray *)rootArray {
    if (!_rootArray) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"];
        _rootArray = [[NSArray array] initWithContentsOfFile:path];
    }
    return _rootArray;
}

- (NSMutableArray *)provinceArr
{
    if (!_provinceArr) {
        _provinceArr = [NSMutableArray array];
    }
    return _provinceArr;
}

- (NSMutableArray *)arrayStreets {
    if (!_arrayStreets) {
        _arrayStreets = [NSMutableArray array];
    }
    return _arrayStreets;
}


- (NSMutableArray *)cityArr
{
    if (!_cityArr) {
        _cityArr = [NSMutableArray array];
    }
    return _cityArr;
}

- (NSMutableArray *)districtArr
{
    if (!_districtArr) {
        _districtArr = [NSMutableArray array];
    }
    return _districtArr;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, UIWINDOW_WIDTH, UIWINDOW_HEIGHT)];
    if(self) {
        self.userInteractionEnabled = YES;
        [self initData];
        [self setUI];
        //首先赋值为选择省份状态
        PickState = ProvinceState;
    }
    return self;
}

#pragma mark -----读取plist城市数据文件----state
-(void)initData {
    //1. 获取省份
    [self.rootArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.provinceArr addObject:obj];//获取省名 obj[@"state"]
    }];
//    //4. 随便获取一个（县，区，等）的（街道，乡，等）
//    NSMutableArray *streetsAry = [NSMutableArray arrayWithArray:[self.districtArr firstObject][@"streets"]];
//    [streetsAry enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [self.arrayStreets addObject:obj];
//    }];
}

- (void)setUI
{
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height/2 - 50)];
    backView.backgroundColor = [UIColor blackColor];
    [backView.layer setOpaque:0.0];
    backView.alpha = 0.5;
    [self addSubview:backView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeFromSuperview)];
    [backView addGestureRecognizer:tap];
    
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height/2, self.bounds.size.width, self.bounds.size.height/2)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomView];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, bottomView.bounds.size.width , bottomView.bounds.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = [UIColor clearColor];
    [bottomView addSubview:_tableView];
    
    UIView * btnView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height/ 2 - 50, self.bounds.size.width, 50)];
    btnView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:btnView];
    
    _provinceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_provinceBtn setTitle:@"请选择" forState:UIControlStateNormal];
    _provinceBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_provinceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _provinceBtn.frame = CGRectMake(0, 10, windowContentWidth/3, 30);
    [_provinceBtn addTarget:self action:@selector(provinceAction) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:_provinceBtn];
    CGFloat width = [self getBtnWidth:_provinceBtn];
    
    _cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cityBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_cityBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _cityBtn.frame = CGRectMake(windowContentWidth/3, 10, windowContentWidth/3, 30);
    [_cityBtn addTarget:self action:@selector(cityAction) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:_cityBtn];
    
    _districtBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _districtBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_districtBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _districtBtn.frame = CGRectMake(windowContentWidth/3 * 2, 10, windowContentWidth/3, 30);
    [_districtBtn addTarget:self action:@selector(districtAction) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:_districtBtn];
    
    _selectLine = [[UIView alloc]initWithFrame:CGRectMake((windowContentWidth/3 - width)/2, 41, width, 1)];
    _selectLine.backgroundColor = [UIColor blackColor];
    [btnView addSubview:_selectLine];
    //_selectLine.hidden = YES;
    
}

-(void) provinceAction {
    _selectLine.hidden = NO;
    PickState = ProvinceState;
    [_tableView reloadData];
    
    CGFloat width = [self getBtnWidth:_provinceBtn];
    
    [UIView animateWithDuration:0.4 animations:^{
        self->_selectLine.frame = CGRectMake((windowContentWidth/3-width)/2 , 41, width, 1);
    }];
    
}

-(void) cityAction {
    _selectLine.hidden = NO;
    PickState = CityState;
    [_tableView reloadData];
    CGFloat width = [self getBtnWidth:_cityBtn];
    
    [UIView animateWithDuration:0.4 animations:^{
        self->_selectLine.frame = CGRectMake((windowContentWidth/3-width)/2 + windowContentWidth/3, 41, width, 1);
        
    }];
}

-(void) districtAction {
    _selectLine.hidden = NO;
    PickState = DistrictState;
    [_tableView reloadData];
    CGFloat width = [self getBtnWidth:_districtBtn];
    
    [UIView animateWithDuration:0.4 animations:^{
        self->_selectLine.frame = CGRectMake((windowContentWidth/3-width)/2  + windowContentWidth * 2/3, 41, width, 1);
    }];
    
}

-(CGFloat)getBtnWidth:(UIButton *)btn
{
    CGRect tmpRect = [btn.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName, nil] context:nil];
    CGFloat width = tmpRect.size.width;
    return width;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(PickState == ProvinceState) {
        return _provinceArr.count;
    }else if (PickState == CityState) {
        return self.cityArr.count;
    }else {
        return self.districtArr.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if(PickState == ProvinceState){
        NSDictionary * obj =  self.provinceArr[indexPath.row];
        cell.textLabel.text = obj[@"state"];
    }
    else if(PickState == CityState){
        NSDictionary * obj = self.cityArr[indexPath.row];
        cell.textLabel.text = obj[@"city"];
    }
    else{
        NSDictionary * obj = self.districtArr[indexPath.row];
        cell.textLabel.text = obj[@"county"];
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor blackColor];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectLine.hidden = NO;
    
    if(PickState == ProvinceState) {
        NSDictionary * obj =  self.provinceArr[indexPath.row];
        //当tableview所处为省份选择状态时，点击cell 进入城市选择状态
        PickState = CityState;
        selectedProvince = obj[@"state"];
        
        [_provinceBtn setTitle:selectedProvince forState:UIControlStateNormal];
        [_cityBtn setTitle:@"请选择" forState:UIControlStateNormal];
        
        [_districtBtn setTitle:@"" forState:UIControlStateNormal];
        
        CGFloat width = [self getBtnWidth:_provinceBtn];
        
        [UIView animateWithDuration:0.4 animations:^{
            self->_selectLine.frame = CGRectMake((windowContentWidth/3-width)/2, 41, width, 1);
        }];
        
        
        NSDictionary * parameters = @{@"row":@(indexPath.row)};
        //清空市和地区后面数据的数组
        [self.districtArr removeAllObjects];
        //刷新市的数据
        [self refreshTableView:self.cityArr paramter:parameters];
        
    }else if (PickState == CityState) {
        NSDictionary * obj = self.cityArr[indexPath.row];
        PickState = DistrictState;
        selectedCity = obj[@"city"];
        [_cityBtn setTitle:selectedCity forState:UIControlStateNormal];
        [_districtBtn setTitle:@"请选择" forState:UIControlStateNormal];
        
        CGFloat width = [self getBtnWidth:_cityBtn];
        
        [UIView animateWithDuration:0.4 animations:^{
            self->_selectLine.frame = CGRectMake((windowContentWidth/3-width)/2 + windowContentWidth/3, 41, width, 1);
        }];
        
        NSDictionary * parameters = @{@"row":@(indexPath.row)};
        //获取刷新地区的数据
        [self refreshTableView:self.districtArr paramter:parameters];
        
    }else {
        NSDictionary * obj = self.districtArr[indexPath.row];
        [_districtBtn setTitle:obj[@"county"] forState:UIControlStateNormal];
        
        CGFloat width = [self getBtnWidth:_districtBtn];
        
        [UIView animateWithDuration:0.4 animations:^{
            self->_selectLine.frame = CGRectMake((windowContentWidth/3-width)/2 + windowContentWidth * 2/3, 41, width, 1);
            
        }];
        
        [self removeFromSuperview];
        
        if (_selectProvinceCityAreaCall) {
            _selectProvinceCityAreaCall(selectedProvince,selectedCity,obj[@"county"],100086);
        }
    }
    [_tableView reloadData];
}

- (void) refreshTableView:(NSMutableArray * )arr paramter:(NSDictionary *)paramter
{
    NSInteger row = [paramter[@"row"] integerValue];
    //先清空数组 拿参数请求数据 然后刷新列表
    if (arr == self.cityArr) {
        [self.cityArr removeAllObjects];
        //2. 随便获取一个省的城市
        NSMutableArray *citys = [NSMutableArray arrayWithArray:[self.provinceArr objectAtIndex:row][@"cities"]];
        [citys enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.cityArr addObject:obj];//获取市名 obj[@"city"]
        }];
    }
    
    if (arr == self.districtArr) {
        [self.districtArr removeAllObjects];
        //3. 随便获取一个城市的（县，区，等）
        NSMutableArray *countyAry = [NSMutableArray arrayWithArray:[self.cityArr objectAtIndex:row][@"areas"]];
        [countyAry enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.districtArr addObject:obj];//获取区名字  obj[@"county"]
        }];
    }
}

@end
