//
//  JLDragCardView.m
//  JLCardAnimation
//
//  Created by job on 16/8/31.
//  Copyright © 2016年 job. All rights reserved.
//

#import "JLDragCardView.h"
#import "CardHeader.h"

#define ACTION_MARGIN_RIGHT lengthFit(150)
#define ACTION_MARGIN_LEFT lengthFit(150)
#define ACTION_VELOCITY 400
#define SCALE_STRENGTH 4
#define SCALE_MAX .93
#define ROTATION_MAX 1
#define ROTATION_STRENGTH lengthFit(414)

#define BUTTON_WIDTH lengthFit(40)

@interface JLDragCardView()

/** 设置基本参数*/
@property (nonatomic ,assign) float xFromCenter;

/** 设置基本参数*/
@property (nonatomic ,assign) float yFromCenter;

@property (strong, nonatomic) UILabel *nameLabel;

/** likeButton*/
@property (nonatomic ,strong) UIButton *likeButton;

/** dislikeButton*/
@property (nonatomic ,strong) UIButton *dislikeButton;

@end

@implementation JLDragCardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius      = 4;
        self.layer.shadowRadius      = 3;
        self.layer.shadowOpacity     = 0.2;
        self.layer.shadowOffset      = CGSizeMake(1, 1);
        self.layer.shadowPath        = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
        
        self.panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(beingDragged:)];
        [self addGestureRecognizer:self.panGesture];
        
//        UIView *bgView            = [[UIView alloc]initWithFrame:self.bounds];
//        bgView.layer.cornerRadius = 4;
//        bgView.clipsToBounds      = YES;
//        [self addSubview:bgView];
        
        
//        self.headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width)];
//        self.headerImageView.backgroundColor = [UIColor lightGrayColor];
//        self.headerImageView.userInteractionEnabled = YES;
//        [bgView addSubview:self.headerImageView];
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
//        [self.headerImageView addGestureRecognizer:tap];
//
//        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, self.frame.size.width+10, self.frame.size.width - 40, 20)];
//        self.nameLabel.font = [UIFont systemFontOfSize:16];
//        self.nameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
//        [bgView addSubview:self.nameLabel];
//
//        UILabel *alertLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, self.frame.size.width +30, self.frame.size.width - 40, 20)];
//        alertLabel.font = [UIFont systemFontOfSize:12];
//        alertLabel.textColor = [UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:1];
//        alertLabel.text = @"其它，10km";
//        [bgView addSubview:alertLabel];
        
        self.layer.allowsEdgeAntialiasing                 = YES;
//        bgView.layer.allowsEdgeAntialiasing               = YES;
//        self.headerImageView.layer.allowsEdgeAntialiasing = YES;
        
        [self addSubview:self.dislikeButton];
        [self addSubview:self.likeButton];

        self.dislikeButton.alpha = 0.0f;
        self.likeButton.alpha = 0.0f;
        
        [self.layer addObserver:self forKeyPath:@"position" options:0 context:NULL];
       
    }
    return self;
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"position"]) {
        
//        NSLog(@"position=:%@",NSStringFromCGPoint(self.layer.position));
//        NSLog(@"xFromCenter:%f",self.xFromCenter);
//        NSLog(@"fix:position:%f",self.layer.position.x - [UIScreen mainScreen].bounds.size.width * 0.5);
//        NSLog(@"====%zd===",self.xFromCenter == self.layer.position.x - [UIScreen mainScreen].bounds.size.width * 0.5);
        
        
        //判断按钮的显示隐藏
        float xFromCenter = self.layer.position.x - [UIScreen mainScreen].bounds.size.width * 0.5;

        if (xFromCenter > 0) {
            self.likeButton.alpha = MIN(fabs((xFromCenter)/100.0),1.0);
        }else{
            self.dislikeButton.alpha = MIN(fabs((xFromCenter)/100.0),1.0);
        }
    }
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    //在左边
    self.likeButton.frame = CGRectMake(20, 20, 60, 60);
    
    //在右边
     self.dislikeButton.frame = CGRectMake(self.bounds.size.width - 20 - 60,  20, 60, 60);
}


-(void)tapGesture:(UITapGestureRecognizer *)sender {
    if (!self.canPan) {
        return;
    }
    NSLog(@"tap") ;
}

-(void)setInfoDict:(NSDictionary *)infoDict{
    
    _infoDict = infoDict;
    
//    self.nameLabel.text = [NSString stringWithFormat:@"郑爽 %@号",self.infoDict[@"number"]];
//    self.headerImageView.image = [UIImage imageNamed:self.infoDict[@"image"]];
 
    self.dislikeButton.alpha = 0.0f;
    self.likeButton.alpha = 0.0f;
}



#pragma mark ------------- 拖动手势
-(void)beingDragged:(UIPanGestureRecognizer *)gesture {
    if (!self.canPan) {
        return ;
    }
    self.xFromCenter = [gesture translationInView:self].x;
    self.yFromCenter = [gesture translationInView:self].y;
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            break;
        case UIGestureRecognizerStateChanged: {
            
            CGFloat rotationStrength = MIN(self.xFromCenter / ROTATION_STRENGTH, ROTATION_MAX);
            
            CGFloat rotationAngel = (CGFloat) (ROTATION_ANGLE * rotationStrength);
            
            CGFloat scale = MAX(1 - fabs(rotationStrength) / SCALE_STRENGTH, SCALE_MAX);
            
            self.center = CGPointMake(self.originalCenter.x + self.xFromCenter, self.originalCenter.y + self.yFromCenter);
            
            CGAffineTransform transform = CGAffineTransformMakeRotation(rotationAngel);
            
            CGAffineTransform scaleTransform = CGAffineTransformScale(transform, scale, scale);
            
            self.transform = scaleTransform;
            [self updateOverLay:self.xFromCenter];
        }
            break;
        case UIGestureRecognizerStateEnded: {
            [self followUpActionWithDistance:self.xFromCenter andVelocity:[gesture velocityInView:self.superview]];
        }
            break;
            
        default:
            break;
    }
}
#pragma mark ----------- 滑动时候，按钮变大
- (void) updateOverLay:(CGFloat)distance {
   
     [self.delegate moveCards:distance];
}

#pragma mark ----------- 后续动作判断
-(void)followUpActionWithDistance:(CGFloat)distance andVelocity:(CGPoint)velocity {
    if (self.xFromCenter > 0 && (distance > ACTION_MARGIN_RIGHT || velocity.x > ACTION_VELOCITY )) {
        [self rightAction:velocity];
    } else if(self.xFromCenter < 0 && (distance < - ACTION_MARGIN_RIGHT || velocity.x < -ACTION_VELOCITY)) {
        [self leftAction:velocity];
    }else {
        //回到原点
        [UIView animateWithDuration:RESET_ANIMATION_TIME
                         animations:^{
                             self.center = self.originalCenter;
                             self.transform = CGAffineTransformMakeRotation(0);
                             self.yesButton.transform = CGAffineTransformMakeScale(1, 1);
                             self.noButton.transform  = CGAffineTransformMakeScale(1, 1);
                         }];
        [self.delegate moveBackCards];
        
        self.likeButton.alpha = 0.0;
        self.dislikeButton.alpha = 0.0;
    }
   
    
    
}



#pragma mark - 按钮动作
-(void)rightAction:(CGPoint)velocity {
    CGFloat distanceX=[[UIScreen mainScreen]bounds].size.width+CARD_WIDTH+self.originalCenter.x;//横向移动距离
    CGFloat distanceY=distanceX*self.yFromCenter/self.xFromCenter;//纵向移动距离
    CGPoint finishPoint = CGPointMake(self.originalCenter.x+distanceX, self.originalCenter.y+distanceY);//目标center点
    
    CGFloat vel=sqrtf(pow(velocity.x, 2)+pow(velocity.y, 2));//滑动手势横纵合速度
    CGFloat displace=sqrt(pow(distanceX-self.xFromCenter,2)+pow(distanceY-self.yFromCenter,2));//需要动画完成的剩下距离
    
    CGFloat duration=fabs(displace/vel);//动画时间
    
    if (duration>0.6) {
        duration=0.6;
    }else if(duration<0.3){
        duration=0.3;
    }
    
    [UIView animateWithDuration:duration
                     animations:^{
                         
                         self.yesButton.transform=CGAffineTransformMakeScale(1.5, 1.5);
                         self.center = finishPoint;
                         self.transform = CGAffineTransformMakeRotation(ROTATION_ANGLE);
                     }completion:^(BOOL complete){
                         
                         self.yesButton.transform=CGAffineTransformMakeScale(1, 1);
                         [self.delegate swipCard:self Direction:YES];
                     }];
    [self.delegate adjustOtherCards];

}

-(void)leftAction:(CGPoint)velocity {
    //横向移动距离
    CGFloat distanceX = -CARD_WIDTH - self.originalCenter.x;
    //纵向移动距离
    CGFloat distanceY = distanceX*self.yFromCenter/self.xFromCenter;
    //目标center点
    CGPoint finishPoint = CGPointMake(self.originalCenter.x+distanceX, self.originalCenter.y+distanceY);
    
    CGFloat vel = sqrtf(pow(velocity.x, 2) + pow(velocity.y, 2));
    CGFloat displace = sqrtf(pow(distanceX - self.xFromCenter, 2) + pow(distanceY - self.yFromCenter, 2));
    
    CGFloat duration = fabs(displace/vel);
    if (duration>0.6) {
        duration = 0.6;
    }else if(duration < 0.3) {
        duration = 0.3;
    }
    
    [UIView animateWithDuration:duration
                     animations:^{
                         self.noButton.transform=CGAffineTransformMakeScale(1.5, 1.5);
                         self.center = finishPoint;
                         self.transform = CGAffineTransformMakeRotation(-ROTATION_ANGLE);
                     } completion:^(BOOL finished) {
                         self.noButton.transform=CGAffineTransformMakeScale(1, 1);
                         [self.delegate swipCard:self Direction:YES];
                     }];
    
    [self.delegate adjustOtherCards];
}


-(void)rightButtonClickAction {
    if (!self.canPan) {
        return;
    }
    CGPoint finishPoint = CGPointMake([[UIScreen mainScreen]bounds].size.width+CARD_WIDTH*2/3, 2*PAN_DISTANCE+self.frame.origin.y);
    [UIView animateWithDuration:CLICK_ANIMATION_TIME
                     animations:^{
                         self.yesButton.transform = CGAffineTransformMakeScale(1.5, 1.5);
                         self.center = finishPoint;
                         self.transform = CGAffineTransformMakeRotation(-ROTATION_ANGLE);
                     } completion:^(BOOL finished) {
                         self.yesButton.transform = CGAffineTransformMakeScale(1, 1);
                         [self.delegate swipCard:self Direction:YES];
                     }];
    [self.delegate adjustOtherCards];
}
-(void)leftButtonClickAction {
    if (!self.canPan) {
        return;
    }
    CGPoint finishPoint = CGPointMake(-CARD_WIDTH*2/3, 2*PAN_DISTANCE + self.frame.origin.y);
    [UIView animateWithDuration:CLICK_ANIMATION_TIME
                     animations:^{
                         self.noButton.transform = CGAffineTransformMakeScale(1.5, 1.5);
                         self.center = finishPoint;
                         self.transform = CGAffineTransformMakeRotation(-ROTATION_ANGLE);
                   } completion:^(BOOL finished) {
                       self.noButton.transform = CGAffineTransformMakeScale(1, 1);
                       [self.delegate swipCard:self Direction:NO];
                   }];
    [self.delegate adjustOtherCards];
}


#pragma mark - lazy

-(UIButton *)likeButton{
    
    if (_likeButton == nil) {
        
        _likeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
        [_likeButton setImage:[UIImage imageNamed:@"likeBtn"] forState:UIControlStateNormal];
    }
    return _likeButton;
}


-(UIButton *)dislikeButton{
    
    if (_dislikeButton == nil) {
        
        _dislikeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
         [_dislikeButton setImage:[UIImage imageNamed:@"dislikeBtn"] forState:UIControlStateNormal];
    }
    return _dislikeButton;
}
@end
