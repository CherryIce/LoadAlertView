//
//  ICEModule1ViewController.m
//  LoadAlertView
//
//  Created by doman on 2019/3/27.
//  Copyright © 2019年 doman. All rights reserved.
//

#import "ICEModule1ViewController.h"

@interface ICEModule1ViewController ()

@property (nonatomic,strong) UIImageView * showImg;

@property (nonatomic,retain) UIButton * playBtn;

@property (nonatomic,strong) NSURL * videoUrl;

@end

@implementation ICEModule1ViewController

- (UIImageView *)showImg
{
    if (!_showImg) {
        _showImg = [[UIImageView alloc] initWithFrame:CGRectMake(2*10, 64, 300 , 640)];
    }
    return _showImg;
}

- (UIButton *)playBtn
{
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playBtn setFrame:CGRectMake(0, 0, 100, 100)];
        [_playBtn setBackgroundColor:[UIColor redColor]];
        _playBtn.tag = 11;
        [_playBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _playBtn.hidden = true;
        _playBtn.enabled = false;
        _playBtn.center = self.showImg.center;
    }
    return _playBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configurationUI];
}

/**
 搭UI
 */
- (void) configurationUI
{
    UIButton * videoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [videoBtn setFrame:CGRectMake(UIWINDOW_WIDTH/2 - 30, Height_NavBar + 70, 60, 60)];
    [videoBtn setBackgroundColor:[UIColor blackColor]];
    videoBtn.tag = 10;
    [videoBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:videoBtn];
    
    [self.view addSubview:self.showImg];
    [self.view addSubview:self.playBtn];
}

- (void) showImgResetUI:(UIImage *)showImage
{
    self.showImg.image = showImage;
    self.playBtn.enabled = true;
    self.playBtn.hidden = false;
}

- (void) buttonClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 10:
        {
            [self transcribe];
        }
            break;
        case 11:
        {
            [self playVideo];
        }
            break;
        default:
            break;
    }
}

/**
 录制
 */
- (void) transcribe
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        /** 真机测试 **/
        XFCameraController *cameraController = [XFCameraController defaultCameraController];

        __weak XFCameraController *weakCameraController = cameraController;

        cameraController.takePhotosCompletionBlock = ^(UIImage *image, NSError *error) {
#pragma mark 此处是拍照
            //回归主线程操作
            [weakCameraController dismissViewControllerAnimated:YES completion:nil];
        };

        cameraController.shootCompletionBlock = ^(NSURL *videoUrl, CGFloat videoTimeLength, UIImage *thumbnailImage, NSError *error) {
#pragma mark 此处是视频
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self->_videoUrl = videoUrl;
                [self showImgResetUI:thumbnailImage];
            }];
            [weakCameraController dismissViewControllerAnimated:YES completion:nil];
        };

        [self presentViewController:cameraController animated:YES completion:nil];
    }else{
        /** 模拟器禁止此功能 **/
        [self showAlertWithTitle:@"温馨提示" message:@"模拟器禁止调用" appearanceProcess:^(EJAlertViewController * _Nonnull alertMaker) {
            alertMaker.addActionCancelTitle(@"确定");
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, EJAlertViewController * _Nonnull alertSelf) {
            
        }];
    }
}

/**
 播放
 */
- (void) playVideo
{
    OSPlayView * playView = [[OSPlayView alloc] initWithFrame:[UIScreen mainScreen].bounds videoUrl:_videoUrl];
    [[UIApplication sharedApplication].keyWindow addSubview:playView];
}


@end
