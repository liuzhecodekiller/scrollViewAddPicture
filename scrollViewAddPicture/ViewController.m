//
//  ViewController.m
//  scrollViewAddPicture
//
//  Created by shenZhenNewWorld on 15-7-30.
//  Copyright (c) 2015年 LZ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *picScrollView;
@property(nonatomic,retain)UIImageView * imageView1;
@property(nonatomic,retain)UIImageView * imageView2;
@property(nonatomic,retain)UIImageView * imageView3;
@property(nonatomic,retain)NSMutableArray * picArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.picScrollView.contentSize = CGSizeMake(80*3, 80);
    self.picScrollView.pagingEnabled = YES;
    for (int i= 20; i<70; i++) {
        [self.picArr addObject:[NSString stringWithFormat:@"00%d.jpg",i]];
    }
    self.picScrollView.delegate = self;
    [self imageView1];
    [self imageView2];
    [self imageView3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UIImageView *)imageView1
{
    if (!_imageView1) {
        _imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
        ;
        _imageView1.image = [UIImage imageNamed:@"0020.jpg"];
        [self.picScrollView addSubview:_imageView1];
    }
    return  _imageView1;
}

-(UIImageView *)imageView2
{
    if (!_imageView2) {
        _imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(80, 0, 80, 80)];
        ;
        _imageView2.image = [UIImage imageNamed:@"0021.jpg"];
        [self.picScrollView addSubview:_imageView2];
    }
    return  _imageView2;
}

-(UIImageView *)imageView3
{
    if (!_imageView3) {
        _imageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(160, 0, 80, 80)];
        ;
        _imageView3.image = [UIImage imageNamed:@"0022.jpg"];
        [self.picScrollView addSubview:_imageView3];
    }
    return  _imageView3;
}



-(NSArray *)picArr
{
    
    if (!_picArr) {
        _picArr = [NSMutableArray array];
    }
   return  _picArr;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //记录上一次的contentoffsize ，跟当前的contentoffsize比较，用来判断此次滑动是向前滑动了，还是向后滑动了
    static  CGPoint offSize ;
    static int count = 0;
    //＝ 0 说明没有滑动
    if (self.picScrollView.contentOffset.x- offSize.x==0) {
        return;
    }
    //>0 说明向后滑动
    if (self.picScrollView.contentOffset.x- offSize.x>0) {
        //判断向后滑动的次数 如 果 >= 数组的总数 －2 就不再坐后续处理 避免数组超届
        if (count>=self.picArr.count-2) {
            return;
        }
        count++;
    }
    //与上同理
    if (self.picScrollView.contentOffset.x- offSize.x<0) {
        if (count<=1) {
            return;
        }
        count--;
    }
        //更换最中间位置的图片 为当前正在显示的相同图片
        self.imageView2.image = [UIImage imageNamed:self.picArr[count]];
        //重新设置scrollView的offsize 使scrollview显示中间的图片
        self.picScrollView.contentOffset = CGPointMake(80, 0);
        //更换两边的图片，下次继续滚动
        self.imageView1.image = [UIImage imageNamed:self.picArr[count-1]];
        self.imageView3.image = [UIImage imageNamed:self.picArr[count+1]];
        //保存本次的contentOffset
        offSize = self.picScrollView.contentOffset;
}

@end
