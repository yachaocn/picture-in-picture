//
//  ViewController.m
//  PictureInpicture
//
//  Created by yachaocn on 15/11/27.
//  Copyright © 2015年 NavchinaMacBook. All rights reserved.
//

#import "ViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
@interface ViewController () <AVPlayerViewControllerDelegate>

//playerViewController 一定要是全局的，不然会出现，播放控制台，消失后点击视图不会出现的问题。
@property(nonatomic,strong) AVPlayerViewController *playerViewController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self preparePlayMedia];
}
-(void)preparePlayMedia
{
//    创建视频播放URL。由于本人添加的视频资源过大，不再在项目中列出，请自行添加，改写一下路径即可。
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"01-发布程序01-填写应用信息" withExtension:@"mp4"];
//    创建视频播放控制器。（#import <MediaPlayer/MediaPlayer.h>框架下的MPMoviePlayerController已经被弃用，由AVPlayerViewController代替）
   _playerViewController = [[AVPlayerViewController alloc]init];
    _playerViewController.delegate = self;
//    设置frame，此处为了更直观的了解AVPlayerViewController的view在视图播放时与AVPlayer视频窗口与ViewController的view的关系，故设置为CGRectMake(0, 0, 768, 768)，可根据需要自行设置。
    _playerViewController.view.frame = CGRectMake(0, 0, 768, 768);
    _playerViewController.view.backgroundColor = [UIColor yellowColor];
//   为AVPlayerViewController初始化一个AVPlayer用于视频的播放。
    AVPlayer *avplayer = [AVPlayer playerWithURL:url];
//    为playerViewController的player赋值。
    _playerViewController.player = avplayer;
//  支持后台音频播放（此步骤为必须的，官方文档强制规定，必须设置类别AVAudioSessionCategoryPlayback）
    [self setAudio2SupportBackgroundPlay];
    [self.view addSubview:_playerViewController.view];
//    开始播放
    [avplayer play];
    
    
}
- (void)setAudio2SupportBackgroundPlay
{
    UIDevice *device = [UIDevice currentDevice];
    
    if (![device respondsToSelector:@selector(isMultitaskingSupported)]) {
        NSLog(@"Unsupported device!");
        return;
    }
    if (!device.multitaskingSupported) {
        NSLog(@"Unsupported multiTasking!");
        return;
    }
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *error;
//    此为必须项，如果不写，会造成无法使用画中画功能，（画中画按钮将被禁用）。
    [session setCategory:AVAudioSessionCategoryPlayback error:&error];
    if (error) {
        NSLog(@"%@", error);
        return;
    }
    [session setActive:YES error:&error];
    if (error) {
        NSLog(@"%@", error);
        return;
    }
}
//以下是AVPlayerViewController的代理方法，用于进出画中画不同时机写自定义方法。
#pragma mark - AVPlayerViewControllerDelegate
- (void)playerViewControllerWillStartPictureInPicture:(AVPlayerViewController *)playerViewController
{
    NSLog(@"%s",__func__);
}
- (void)playerViewControllerDidStartPictureInPicture:(AVPlayerViewController *)playerViewController
{
    NSLog(@"%s",__func__);
}
- (void)playerViewController:(AVPlayerViewController *)playerViewController failedToStartPictureInPictureWithError:(NSError *)error
{
    NSLog(@"%s",__func__);
}
- (void)playerViewControllerWillStopPictureInPicture:(AVPlayerViewController *)playerViewController
{
    NSLog(@"%s",__func__);
}
- (void)playerViewControllerDidStopPictureInPicture:(AVPlayerViewController *)playerViewController
{
    NSLog(@"%s",__func__);
}
- (BOOL)playerViewControllerShouldAutomaticallyDismissAtPictureInPictureStart:(AVPlayerViewController *)playerViewController
{
    NSLog(@"%s",__func__);
    return YES;
}
- (void)playerViewController:(AVPlayerViewController *)playerViewController restoreUserInterfaceForPictureInPictureStopWithCompletionHandler:(void (^)(BOOL restored))completionHandler
{
     NSLog(@"%s",__func__);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
