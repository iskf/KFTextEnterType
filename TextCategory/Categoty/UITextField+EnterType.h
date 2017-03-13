//
//  UITextField+EnterType.h
//  TextCategory
//
//  Created by InnoeriOS1 on 2017/3/10.
//  Copyright © 2017年 Innoways. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, kf_NSEnterType) {
    KF_NSEnterDefault = 0,     //默认
    KF_NSEnterUppercaseAll,         //全部转大写
    KF_NSEnterUppercaseFirst,       //首字母大写其他小写
    KF_NSEnterLowercaseAll,         //全部转小写
    KF_NSEnterLowercaseFirst,       //首字母小写其他大写
    
    KF_NSEnterNumber,               //只允许输入数字
    KF_NSEnterNumberPoint           //只允许输入数字和点
};

@interface UITextField (EnterType)

/** 输入类型 */
@property (nonatomic, assign) kf_NSEnterType kf_EnterType;

/** 设置输入长度 默认 0 不限制长度*/
@property (nonatomic, assign) NSInteger kf_EnterLength;
@end
