//
//  OSPlayView.m
//  OSNewFrame
//
//  Created by Macx on 2017/11/30.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "OSPlayView.h"

@implementation OSPlayView

- (instancetype)initWithFrame:(CGRect)frame videoUrl:(NSURL *)url
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI:url];
    }
    return self;
}

- (void) initUI:(NSURL *)url
{
    AVURLAsset *asset = [AVURLAsset assetWithURL:url];
    
    if ([ICEToolsHelper isEmpty:url]) {
        return;
    }
    
    //获取视频总时长
    //Float64 duration = CMTimeGetSeconds(asset.duration);
    
    //self.currentVideoTimeLength = duration;
    
    // 初始化AVPlayer
    self.videoPreviewContainerView = [[UIView alloc] init];
    self.videoPreviewContainerView.frame = self.bounds;
    self.videoPreviewContainerView.backgroundColor = [UIColor blackColor];
    
    self.playerItem = [AVPlayerItem playerItemWithAsset:asset];
    self.player = [[AVPlayer alloc] initWithPlayerItem:_playerItem];
    
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer.frame = CGRectMake(0, 0, UIWINDOW_WIDTH, UIWINDOW_HEIGHT);
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    [self.videoPreviewContainerView.layer addSublayer:self.playerLayer];
    
    // 其余UI布局设置
    [self addSubview:self.videoPreviewContainerView];
    [self bringSubviewToFront:self.videoPreviewContainerView];
    
    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeBtn setFrame:CGRectMake(30, 50, 40, 40)];
    [self.closeBtn setBackgroundImage:[UIImage imageNamed:@"icon_close_"] forState:UIControlStateNormal];
    [self.closeBtn addTarget:self action:@selector(removeFromSuperview) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.closeBtn];
    
    // 重复播放预览视频
    [self addNotificationWithPlayerItem];
    
    // 开始播放
    [self.player play];
}

#pragma mark - 预览视频通知
/**
 *  添加播放器通知
 */
-(void)addNotificationWithPlayerItem
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playVideoFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
}

- (void) removePlayerItemNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  播放完成通知
 *
 *  @param notification 通知对象
 */
-(void)playVideoFinished:(NSNotification *)notification
{
    //    NSLog(@"视频播放完成.");
    
    // 播放完成后重复播放
    // 跳到最新的时间点开始播放
    [self.player seekToTime:CMTimeMake(0, 1)];
    [self.videoPreviewContainerView removeFromSuperview];
    [self removePlayerItemNotification];
    [self removeFromSuperview];
}


@end
