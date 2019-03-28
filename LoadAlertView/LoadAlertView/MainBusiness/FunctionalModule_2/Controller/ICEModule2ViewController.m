//
//  ICEModule2ViewController.m
//  LoadAlertView
//
//  Created by doman on 2019/3/27.
//  Copyright © 2019年 doman. All rights reserved.
//

#import "ICEModule2ViewController.h"

#import "PYPhotoBrowser.h"
#import "TZImagePickerController.h"

@interface ICEModule2ViewController ()<TZImagePickerControllerDelegate,PYPhotosViewDelegate>

@property (nonatomic, weak) PYPhotosView *publishPhotosView;//属性 保存选择的图片
@property(nonatomic,strong)NSMutableArray *photos;
@property(nonatomic,assign)int repeatClickInt;

@end

@implementation ICEModule2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.repeatClickInt !=2) {
        self.repeatClickInt = 2;
        // 1. 常见一个发布图片时的photosView
        PYPhotosView *publishPhotosView = [PYPhotosView photosView];
        publishPhotosView.py_x = 5;
        publishPhotosView.py_y = 100;
        // 2.1 设置本地图片
        publishPhotosView.images = nil;
        // 3. 设置代理
        publishPhotosView.delegate = self;
        publishPhotosView.photosMaxCol = 5;//每行显示最大图片个数
        publishPhotosView.imagesMaxCountWhenWillCompose = 9;//最多选择图片的个数
        // 4. 添加photosView
        [self.view addSubview:publishPhotosView];
        self.publishPhotosView = publishPhotosView;
    }
    
}

#pragma mark - PYPhotosViewDelegate
- (void)photosView:(PYPhotosView *)photosView didAddImageClickedWithImages:(NSMutableArray *)images{
    // 在这里做当点击添加图片按钮时，你想做的事。
    [self getPhotos];
}

// 进入预览图片时调用, 可以在此获得预览控制器，实现对导航栏的自定义
- (void)photosView:(PYPhotosView *)photosView didPreviewImagesWithPreviewControlelr:(PYPhotosPreviewController *)previewControlelr{
    NSLog(@"进入预览图片");
}

//进入相册的方法:
-(void)getPhotos{
    ICEWeakSelf;
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 - weakSelf.photos.count delegate:weakSelf];
    imagePickerVc.maxImagesCount = 9;//最小照片必选张数,默认是0
    imagePickerVc.sortAscendingByModificationDate = NO;// 对照片排序，按修改时间升序，默认是YES。如果设置为NO,最新的照片会显示在最前面，内部的拍照按钮会排在第一个
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets,BOOL isSelectOriginalPhoto){
        NSLog(@"选中图片photos === %@",photos);
        //        for (UIImage *image in photos) {
        //            [weakSelf requestData:image];//requestData:图片上传方法 在这里就不贴出来了
        //        }
        [weakSelf.photos addObjectsFromArray:photos];
        [self.publishPhotosView reloadDataWithImages:weakSelf.photos];
    }];
    [weakSelf presentViewController:imagePickerVc animated:YES completion:nil];
}

- (NSMutableArray *)photos{
    if (_photos == nil) {
        _photos = [[NSMutableArray alloc]init];
    }
    return _photos;
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
