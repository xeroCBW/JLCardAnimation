//
//  DragCardView.m
//  JLCardAnimation
//
//  Created by chenbowen on 2017/10/31.
//  Copyright © 2017年 job. All rights reserved.
//

#import "DragCardView.h"


@interface DragCardView()

@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;

@property (weak, nonatomic) IBOutlet UIImageView *firstImageView;

@property (weak, nonatomic) IBOutlet UIImageView *secondImageView;

@property (weak, nonatomic) IBOutlet UIImageView *threeImageView;

@end

@implementation DragCardView

//注意问题:一定要在xib中设置类;不要在fileowner中设置类


-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    [self addTapGestureWithImageView:self.bigImageView Acion:@selector(bigImageViewTapAction:)];
    [self addTapGestureWithImageView:self.firstImageView Acion:@selector(firstImageViewTapAction:)];
    [self addTapGestureWithImageView:self.secondImageView Acion:@selector(secondImageViewTapAction:)];
    [self addTapGestureWithImageView:self.threeImageView Acion:@selector(thirdImageViewTapAction:)];
   
}


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
