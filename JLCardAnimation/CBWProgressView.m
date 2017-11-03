//
//  CBWProgressView.m
//  JLCardAnimation
//
//  Created by chenbowen on 2017/11/3.
//  Copyright © 2017年 job. All rights reserved.
//

#import "CBWProgressView.h"

@interface CBWProgressView ()

/** 进度条*/
@property (nonatomic ,weak) UIView *progressView;

@end

@implementation CBWProgressView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGRect  viewFrame = CGRectMake(0, 0, 0, frame.size.height);
        UIView *view = [[UIView alloc]initWithFrame:viewFrame];
        [self addSubview:view];
        view.backgroundColor = [UIColor clearColor];
        self.progressView = view;
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    CGRect  viewFrame = CGRectMake(0, 0, 0, self.frame.size.height);
    UIView *view = [[UIView alloc]initWithFrame:viewFrame];
    [self addSubview:view];
    view.backgroundColor = [UIColor clearColor];
    self.progressView = view;
}

-(void)setProgress:(CGFloat)progress{
    
     _progress = progress;
    
    [self setProgress:progress animated:NO];
    
    
    
}

-(void)setProgress:(CGFloat)progress animated:(BOOL)animated{
    
    if (progress == 0)
    {
        self.progressView.backgroundColor = [UIColor clearColor];
    }
    else
    {
        
        //设置默认颜色
        UIColor *color = self.progressViewColor ? self.progressViewColor:[UIColor redColor];
        self.progressView.backgroundColor = color;
        
        CGRect frame = CGRectMake(0, 0, self.frame.size.width * progress, self.frame.size.height);
        
        if (animated) {
            [UIView animateWithDuration:1.5 animations:^{
                self.progressView.frame = frame;
            }];
        }else{
            self.progressView.frame = frame;
        }
    }
}

@end

