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
    
    /**
     *  添加卡通滤镜
     */
    GPUImageGaussianSelectiveBlurFilter *filter = [[GPUImageGaussianSelectiveBlurFilter alloc] init];
    filter.excludeBlurSize = 0.5;      // 清晰区域的大小
    filter.blurRadiusInPixels = 30;    // 清晰区域外的模糊程度，同 GPUImageGaussianBlurFilter
    filter.excludeCirclePoint = CGPointMake(0.5, 0.5);     // 清晰区域的中心坐标
    filter.excludeCircleRadius = 0.5;  // 清晰区域的半径
    filter.aspectRatio = 3;          // 清晰区域的宽高比，宽度会保持 excludeCircleRadius 的值，高度为 excludeCircleRadius / aspectRatio
    
    [_movie addTarget:filter];

    
    [filter addTarget:self.filterView];
    [self.view addSubview:_filterView];
    [_movie startProcessing];
}
@end
