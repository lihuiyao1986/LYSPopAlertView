//
//  LYSPopAlertView.h
//  LYSPopAlertView
//
//  Created by jk on 2017/4/11.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,LYSPopAlertType){
    LYSPopAlertTypeInfo,
    LYSPopAlertTypeWarning,
    LYSPopAlertTypeSucc,
    LYSPopAlertTypeFail,
    LYSPopAlertTypeNotice
};

@interface LYSPopAlertView : UIView

#pragma mark - 标题
@property(nonatomic,copy)NSString *title;

#pragma mark - 按钮标题
@property(nonatomic,copy)NSString *btnTitle;

#pragma mark - 类型
@property(nonatomic,assign)LYSPopAlertType type;

#pragma mark - 描述
@property(nonatomic,copy)NSString *content;

#pragma mark - 点击外面是否隐藏
@property(nonatomic,assign)BOOL dismissTouchOutside;

#pragma mark - 确认按钮被点击后的回调
@property(nonatomic,copy)void(^HideBlock)();

#pragma mark - 自动隐藏的时间 如果为-1则不自动隐藏
@property(nonatomic,assign)CGFloat autoHideTime;

#pragma mark - 显示
-(void)show;

#pragma mark - 显示
-(void)showInView:(UIView*)targetView;


@end
