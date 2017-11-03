//
//  DragCardView.m
//  JLCardAnimation
//
//  Created by chenbowen on 2017/10/31.
//  Copyright © 2017年 job. All rights reserved.
//

#import "DragCardView.h"
#import "CBWProgressView.h"


@interface DragCardView()

@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;

@property (weak, nonatomic) IBOutlet UIImageView *firstImageView;

@property (weak, nonatomic) IBOutlet UIImageView *secondImageView;

@property (weak, nonatomic) IBOutlet UIImageView *threeImageView;

@property (weak, nonatomic) IBOutlet CBWProgressView *progressView;

@property (weak, nonatomic) IBOutlet UIButton *playButton;

@end

@implementation DragCardView

//注意问题:一定要在xib中设置类;不要在fileowner中设置类


-(void)awakeFromNib{
    
    [super awakeFromNib];

    self.progressView.progressViewColor = [UIColor greenColor];
    
    
    [self addTapGestureWithImageView:self.bigImageView Acion:@selector(bigImageViewTapAction:)];
    [self addTapGestureWithImageView:self.firstImageView Acion:@selector(firstImageViewTapAction:)];
    [self addTapGestureWithImageView:self.secondImageView Acion:@selector(secondImageViewTapAction:)];
    [self addTapGestureWithImageView:self.threeImageView Acion:@selector(thirdImageViewTapAction:)];
    
    self.playButton.layer.cornerRadius      = self.playButton.frame.size.height * 0.5;
//    [self.playButton.layer setBorderColor:[UIColor lightGrayColor].CGColor];
//    [self.playButton.layer setBorderWidth:1.5f];
    self.playButton.layer.shadowColor       = [UIColor blackColor].CGColor;
    self.playButton.layer.shadowRadius      = 3;
    self.playButton.layer.shadowOpacity     = 0.8;
    self.playButton.layer.shadowOffset      = CGSizeMake(3, 3);
    //不设置bezierPath 就可以完成阴影了
//    self.playButton.layer.shadowPath        = [UIBezierPath bezierPathWithRect:self.playButton.bounds].CGPath;
    
//    self.playButton.layer.masksToBounds = YES;
    
}


#pragma mark - 设置阴影

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
 [self.progressView setProgress:0.3 animated:YES];
}

#pragma mark - 设置手势
- (void)addTapGestureWithImageView:(UIImageView *)imageView Acion:(nullable SEL)action{
    
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:action];
    [imageView addGestureRecognizer:tap];
    
}


- (void)bigImageViewTapAction:(UITapGestureRecognizer *)tap{
    
    NSLog(@"%s",__func__);
}

- (void)firstImageViewTapAction:(UITapGestureRecognizer *)tap{
    
    NSLog(@"%s",__func__);
    
}

- (void)secondImageViewTapAction:(UITapGestureRecognizer *)tap{
    
    NSLog(@"%s",__func__);
}

- (void)thirdImageViewTapAction:(UITapGestureRecognizer *)tap{
    
    NSLog(@"%s",__func__);
}

@end
