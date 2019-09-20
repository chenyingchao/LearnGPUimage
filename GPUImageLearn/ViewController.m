//
//  ViewController.m
//  GPUImageLearn
//
//  Created by butter on 2019/9/20.
//  Copyright © 2019 butter. All rights reserved.
//

#import "ViewController.h"
#import <GPUImageView.h>
#import <GPUImage/GPUImage.h>

@interface ViewController ()

@property (nonatomic,strong)GPUImageMovie *movie;//播放
@property (nonatomic,strong)GPUImageFilter *filter;//滤镜
@property (nonatomic,strong)GPUImageView *filterView;//播放视图
@property (nonatomic,strong)GPUImageMovieWriter *writer;//保存

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self playVideo];
}

- (void)playVideo{

    NSURL *sampleURL = [[NSBundle mainBundle]URLForResource:@"123" withExtension:@"MP4" subdirectory:nil];
    _movie = [[GPUImageMovie alloc] initWithURL:sampleURL];
    _movie.shouldRepeat = YES;
    _movie.playAtActualSpeed = YES;
    _movie.runBenchmark = YES;
    
    GPUImageGaussianBlurFilter *filter = [[GPUImageGaussianBlurFilter alloc] init];
    filter.blurRadiusInPixels = 50;
    
    [_movie addTarget:filter];

    
    self.filterView = [[GPUImageView alloc]initWithFrame:CGRectMake(0, 0, 375, 500)];
    [filter addTarget:self.filterView];
    [self.view addSubview:_filterView];
    [_movie startProcessing];
}
@end
