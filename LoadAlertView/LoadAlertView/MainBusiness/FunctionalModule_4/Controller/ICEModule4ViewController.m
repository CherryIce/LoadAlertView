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

//查看删除
- (DeleteImgViewCell *)deleteImgCell{
    if (!_deleteImgCell) {
        _deleteImgCell = [[DeleteImgViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"deleteImgCell"];
        _deleteImgCell.frame = [UIScreen mainScreen].bounds;
    }
    return _deleteImgCell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    for (int i = 0; i < 5; i++) {
        [self.photosArr addObject:@(i)];
    }

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
            [weakSelf searchImgThenDelete];
        }
    };
}

//点击查看
- (void) searchImgThenDelete
{
    [[UIApplication sharedApplication].keyWindow addSubview:self.deleteImgCell];
    
    [self.deleteImgCell initWithImgDataArray:self.photosArr];
    
    ICEWeakSelf;
    self.deleteImgCell.delteImgCallBack = ^(NSInteger tag) {
        //删除
        [weakSelf deleteImgWith:tag];
    };
}

//执行删除操作
- (void) deleteImgWith:(NSInteger)tag
{
    [self.deleteImgCell removeFromSuperview];
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
