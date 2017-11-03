//
//  CBWProgressView.h
//  JLCardAnimation
//
//  Created by chenbowen on 2017/11/3.
//  Copyright © 2017年 job. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBWProgressView : UIView
/** 进度(0~1)*/
@property (nonatomic ,assign) CGFloat progress;

/** 进度条颜色*/
@property (nonatomic ,strong) UIColor *progressViewColor;

/*是否设置进度条动画,默认是有动画的*/
-(void)setProgress:(CGFloat)progress animated:(BOOL)animated;



@end
