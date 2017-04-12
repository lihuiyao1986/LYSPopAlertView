//
//  LYSPopAlertView.m
//  LYSPopAlertView
//
//  Created by jk on 2017/4/11.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import "LYSPopAlertView.h"

@interface LYSPopAlertView ()

@property(nonatomic,strong)UILabel *titleLb;

@property(nonatomic,strong)UILabel *contentLb;

@property(nonatomic,strong)UIButton *sureBtn;

@property(nonatomic,strong)UIButton *circleView;

@property(nonatomic,strong)UIView *circleWrapView;

@property(nonatomic,strong)UIView *containerView;

@property(nonatomic,strong)UIView *innerContainerView;

@end

static NSTimeInterval duration = 0.35;

@implementation LYSPopAlertView

- (instancetype)init
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        [self initConfig];
    }
    return self;
}

-(void)initConfig{
    self.backgroundColor = [self colorWithHexString:@"000000" alpha:0.4];
    [self setDefaults];
    [self setupUI];
}

-(void)setupUI{
    [self.circleWrapView addSubview:self.circleView];
    [self.innerContainerView addSubview:self.titleLb];
    [self.innerContainerView addSubview:self.contentLb];
    [self.innerContainerView addSubview:self.sureBtn];
    [self.containerView addSubview:self.innerContainerView];
    [self.containerView addSubview:self.circleWrapView];
    [self addSubview:self.containerView];
}

-(UIView*)innerContainerView{
    if (!_innerContainerView) {
        _innerContainerView = [UIView new];
        _innerContainerView.layer.cornerRadius = 5.f;
        _innerContainerView.layer.masksToBounds = YES;
        _innerContainerView.backgroundColor = [UIColor whiteColor];
    }
    return _innerContainerView;
}

-(UIView*)containerView{
    if (!_containerView) {
        _containerView = [UIView new];
    }
    return _containerView;
}

-(void)setType:(LYSPopAlertType)type{
    _type = type;
    [self setCircleImageByType];
}

-(void)setCircleImageByType{
    UIColor *bgColor = [self UIColorFromRGB:0x22B573];
    NSString * circleImage = @"LYSPopAlertView.bundle/popalertview_succ";
    switch (self.type) {
        case LYSPopAlertTypeInfo:
            bgColor = [self UIColorFromRGB:0x2866BF];
            circleImage = @"LYSPopAlertView.bundle/popalertview_info";
            break;
        case LYSPopAlertTypeNotice:
            bgColor = [self UIColorFromRGB:0x727375];
            circleImage = @"LYSPopAlertView.bundle/popalertview_notice";
            break;
        case LYSPopAlertTypeSucc:
            bgColor = [self UIColorFromRGB:0x22B573];
            circleImage = @"LYSPopAlertView.bundle/popalertview_succ";
            break;
        case LYSPopAlertTypeFail:
            bgColor = [self UIColorFromRGB:0xC1272D];
            circleImage = @"LYSPopAlertView.bundle/popalertview_fail";
            break;
        case LYSPopAlertTypeWarning:
            bgColor = [self UIColorFromRGB:0xFFD110];
            circleImage = @"LYSPopAlertView.bundle/popalertview_warning";
            break;
    }
    [self.sureBtn setBackgroundImage:[self createImageWithColor:bgColor] forState:UIControlStateNormal];
    [self.sureBtn setBackgroundImage:[self createImageWithColor:bgColor] forState:UIControlStateHighlighted];
    [self.circleView setBackgroundColor:bgColor];
    [self.circleView setImage:[UIImage imageNamed:circleImage] forState:UIControlStateNormal];
    [self.circleView setImage:[UIImage imageNamed:circleImage] forState:UIControlStateHighlighted];
}

#pragma mark - 将颜色转换成图片
- (UIImage *)createImageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

-(void)setTitle:(NSString *)title{
    _title = title;
    self.titleLb.text = _title;
}

-(void)setContent:(NSString *)content{
    _content = content;
    self.contentLb.text = content;
}

-(void)setBtnTitle:(NSString *)btnTitle{
    _btnTitle = btnTitle;
    [self.sureBtn setTitle:_btnTitle forState:UIControlStateNormal];
    [self.sureBtn setTitle:_btnTitle forState:UIControlStateHighlighted];
}

#pragma mark - 内容视图
-(UILabel*)contentLb{
    if (!_contentLb) {
        _contentLb = [UILabel new];
        _contentLb.textAlignment = NSTextAlignmentCenter;
        _contentLb.lineBreakMode = NSLineBreakByWordWrapping;
        _contentLb.numberOfLines = 0;
        _contentLb.font = [UIFont systemFontOfSize:14];
        _contentLb.textColor = [self colorWithHexString:@"414141" alpha:1.0];
    }
    return _contentLb;
}

#pragma mark - 确认按钮
-(UIButton*)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.layer.cornerRadius = 4.f;
        _sureBtn.layer.masksToBounds = YES;
        [_sureBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [_sureBtn setTitle:self.btnTitle forState:UIControlStateNormal];
        [_sureBtn setTitle:self.btnTitle forState:UIControlStateHighlighted];
    }
    return _sureBtn;
}

#pragma mark - circleWrapView
-(UIView*)circleWrapView{
    if (!_circleWrapView) {
        _circleWrapView = [UIView new];
        _circleWrapView.backgroundColor = [UIColor whiteColor];
    }
    return _circleWrapView;
}

#pragma mark - layoutSubviews
-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.containerView.frame = CGRectMake(CGRectGetWidth(self.frame) * 0.15, CGRectGetHeight(self.frame) * 0.3, CGRectGetWidth(self.frame) * 0.7, CGRectGetHeight(self.frame) * 0.4);
    
    self.circleWrapView.frame = CGRectMake((CGRectGetWidth(self.containerView.frame) - 60) * 0.5, 0, 60, 60);
    self.circleWrapView.layer.cornerRadius = CGRectGetHeight(self.circleWrapView.frame) * 0.5;
    
    self.circleView.frame = CGRectMake(5.f, 5.f, CGRectGetHeight(self.circleWrapView.frame) - 10 , CGRectGetHeight(self.circleWrapView.frame) - 10);
    
    self.circleView.layer.cornerRadius = CGRectGetHeight(self.circleView.frame) * 0.5;
    
    self.innerContainerView.frame = CGRectMake(0, CGRectGetHeight(self.circleWrapView.frame) * 0.5, CGRectGetWidth(self.containerView.frame), CGRectGetHeight(self.containerView.frame) - CGRectGetHeight(self.circleWrapView.frame));
    
    self.titleLb.frame = CGRectMake(0, CGRectGetHeight(self.circleWrapView.frame) * 0.5, CGRectGetWidth(self.innerContainerView.frame), 30);
    
    self.sureBtn.frame = CGRectMake(20, CGRectGetHeight(self.innerContainerView.frame) - 35 - 10, CGRectGetWidth(self.innerContainerView.frame) - 40, 35);
    self.contentLb.frame = CGRectMake(20,CGRectGetMaxY(self.titleLb.frame) + 20,CGRectGetWidth(self.innerContainerView.frame) - 40 , CGRectGetMinY(self.sureBtn.frame) - CGRectGetMaxY(self.titleLb.frame) - 40);
}

#pragma mark - 按钮被点击
-(void)btnClicked:(UIButton *)sender{
    [self dismiss];
}

#pragma mark - 点击开始
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self];
    if (!CGRectContainsPoint(self.containerView.frame, point)) {
        if (self.dismissTouchOutside) {
            [self dismiss];
        }
    }
}

#pragma mark - 任务延迟执行
-(void)delayTask:(CGFloat)delay completion:(void(^)())completion{
    dispatch_after(dispatch_time( DISPATCH_TIME_NOW, delay * NSEC_PER_SEC), dispatch_get_main_queue(),^{
        if (completion) {
            completion();
        }
    });
}

#pragma mark - 标题视图
-(UILabel*)titleLb{
    if(!_titleLb){
        _titleLb = [UILabel new];
        _titleLb.textAlignment = NSTextAlignmentCenter;
        _titleLb.numberOfLines = 1;
        _titleLb.lineBreakMode = NSLineBreakByTruncatingTail;
        _titleLb.font = [UIFont systemFontOfSize:18];
        _titleLb.text = self.title;
        _titleLb.textColor = [self colorWithHexString:@"414141" alpha:1.0];
    }
    return _titleLb;
}

#pragma mark - 圆圈视图
-(UIButton*)circleView{
    if (!_circleView) {
        _circleView = [UIButton buttonWithType:UIButtonTypeCustom];
        [self setCircleImageByType];
    }
    return _circleView;
}

#pragma mark - 设置默认
-(void)setDefaults{
    _title = @"温馨提示";
    _btnTitle = @"确定";
    _autoHideTime = -1;
    _type = LYSPopAlertTypeSucc;
}


#pragma mark - 生成16进制颜色
-(UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha{
    
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

-(UIColor*)UIColorFromRGB:(int)rgbValue{
    return [UIColor colorWithRed: ((rgbValue & 0xFF0000) >> 16) / 255.0 green:((rgbValue & 0x00FF00) >> 8) / 255.0 blue:(rgbValue & 0x0000F) / 255.0 alpha:1.0];
}

#pragma mark - 显示
-(void)showInView:(UIView*)targetView{
    if(!targetView){
        targetView = [UIApplication sharedApplication].keyWindow;
    }
    [self removeFromSuperview];
    [targetView addSubview:self];
    __weak typeof (self)MyWeakSelf = self;
    self.containerView.transform = CGAffineTransformMakeScale(0,0);
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
         MyWeakSelf.containerView.transform = CGAffineTransformMakeScale(1.0,1.0);
    } completion:^(BOOL finished) {
        if (MyWeakSelf.autoHideTime != -1) {
            [MyWeakSelf delayTask:MyWeakSelf.autoHideTime completion:^{
                [MyWeakSelf dismiss];
            }];
        }
    }];
}

#pragma mark - 隐藏
-(void)dismiss{
    __weak typeof (self)MyWeakSelf = self;
    [UIView animateWithDuration:duration animations:^{
        MyWeakSelf.containerView.alpha = 0;
        MyWeakSelf.alpha = 0;
    } completion:^(BOOL finished) {
        if (MyWeakSelf.HideBlock) {
            MyWeakSelf.HideBlock();
        }
        [MyWeakSelf removeFromSuperview];
    }];
}

#pragma mark - 显示
-(void)show{
    [self showInView:nil];
}

@end
