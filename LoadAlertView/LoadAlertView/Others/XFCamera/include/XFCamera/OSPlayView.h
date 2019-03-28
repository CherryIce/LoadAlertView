//
//  OSPlayView.h
//  OSNewFrame
//
//  Created by Macx on 2017/11/30.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>

@interface OSPlayView : UIView

@property (nonatomic,strong) UIView * videoPreviewContainerView;

@property (nonatomic,strong) AVPlayerItem * playerItem;

@property (nonatomic,strong) AVPlayer * player;

@property (nonatomic,strong) AVPlayerLayer * playerLayer;

@property (nonatomic,strong) UIButton * closeBtn;

- (instancetype)initWithFrame:(CGRect)frame videoUrl:(NSURL *)url;

@end
