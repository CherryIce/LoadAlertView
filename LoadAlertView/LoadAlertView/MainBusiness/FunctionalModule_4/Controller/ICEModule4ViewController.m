//
//  ICEModule4ViewController.m
//  LoadAlertView
//
//  Created by doman on 2019/3/27.
//  Copyright © 2019年 doman. All rights reserved.
//

#import "ICEModule4ViewController.h"

#import "MutilImgCell.h"
#import "DeleteImgViewCell.h"

@interface ICEModule4ViewController ()<TZImagePickerControllerDelegate>

@property (nonatomic,strong) NSMutableArray * photosArr;

@property (nonatomic, strong) MutilImgCell * cell;

@property (nonatomic, strong) DeleteImgViewCell * deleteImgCell;

@end

@implementation ICEModule4ViewController

- (NSMutableArray *)photosArr{
    if (!_photosArr) {
        _photosArr = [NSMutableArray array];
    }
    return _photosArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.photosArr addObject:@"http://ww3.sinaimg.cn/large/006ka0Iygw1f6bqm7zukpj30g60kzdi2.jpg"];
    [self.photosArr addObject:@"http://ww1.sinaimg.cn/large/61b69811gw1f6bqb1bfd2j20b4095dfy.jpg"];
    [self.photosArr addObject:@"http://ww1.sinaimg.cn/large/54477ddfgw1f6bqkbanqoj20ku0rsn4d.jpg"];
    [self.photosArr addObject:@"http://ww4.sinaimg.cn/large/006ka0Iygw1f6b8gpwr2tj30bc0bqmyz.jpg"];
    [self.photosArr addObject:@"http://ww2.sinaimg.cn/large/9c2b5f31jw1f6bqtinmpyj20dw0ae76e.jpg"];
    
    [self reloadCellView];
}

//刷新UI
- (void) reloadCellView
{
    [self.cell removeFromSuperview];
    self.cell = [[MutilImgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    [self.view addSubview:self.cell];
    
    NSInteger h = UIWINDOW_WIDTH/3;
    (self.photosArr.count/3+1) > 3 ? (h=h*3) : (h=(self.photosArr.count/3+1)*h);
    self.cell.frame = CGRectMake(0, 100, UIWINDOW_WIDTH, h);
    [self.cell initWithImgDataArray:self.photosArr];
    ICEWeakSelf;
    self.cell.imgHandleCallBack = ^(NSInteger tag) {
        if (tag == 20000) {
            //添加
            [weakSelf getPhotos];
        }else{
            //查看
            [weakSelf searchImgThenDelete:tag];
        }
    };
}

//点击查看
- (void) searchImgThenDelete:(NSInteger)tag
{
     [self.deleteImgCell removeFromSuperview];
    self.deleteImgCell = [[DeleteImgViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"deleteImgCell"];
    self.deleteImgCell.frame = [UIScreen mainScreen].bounds;
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.deleteImgCell];
    
    //设置显示类型
    self.deleteImgCell.type = showPageLabelType;
    [self.deleteImgCell initWithImgDataArray:self.photosArr index:tag];
    
    ICEWeakSelf;
    self.deleteImgCell.delteImgCallBack = ^(NSInteger tag) {
        //删除
        [weakSelf deleteImgWith:tag];
    };
}

//执行删除操作
- (void) deleteImgWith:(NSInteger)tag
{
    if (tag != 2000) {
        [self.photosArr removeObjectAtIndex:tag];
        [self reloadCellView];
    }
}

//进入相册的方法:
-(void)getPhotos{
    ICEWeakSelf;
    
    NSInteger maxCount = 9 - weakSelf.photosArr.count;
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:maxCount delegate:weakSelf];
    imagePickerVc.maxImagesCount = maxCount;
    imagePickerVc.sortAscendingByModificationDate = NO;// 对照片排序，按修改时间升序，默认是YES。如果设置为NO,最新的照片会显示在最前面，内部的拍照按钮会排在第一个
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets,BOOL isSelectOriginalPhoto){
        NSLog(@"选中图片photos === %@",photos);
        for (UIImage * image in photos) {
            [weakSelf.photosArr addObject:image];
        }
        //[weakSelf.photosArr addObjectsFromArray:photos];
        //[weakSelf.cell initWithImgDataArray:weakSelf.photosArr];
        [weakSelf reloadCellView];
    }];
    [weakSelf presentViewController:imagePickerVc animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
