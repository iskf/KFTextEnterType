//
//  UITextField+EnterType.m
//  TextCategory
//
//  Created by InnoeriOS1 on 2017/3/10.
//  Copyright © 2017年 Innoways. All rights reserved.
//

#import "UITextField+EnterType.h"
#import <objc/runtime.h>


@implementation UITextField (EnterType)

static void *kf_EnterTypeKey = (void *)@"kf_EnterTypeKey";

static void *kf_EnterLengthKey = (void *)@"kf_EnterLengthKey";

//类别不允许添加属性，添加了也赋值不了，所以我们使用Associate来添加
-(kf_NSEnterType)kf_EnterType
{
    NSNumber *number = objc_getAssociatedObject(self, kf_EnterTypeKey);
    if (!number) {
        return KF_NSEnterDefault;
    }else
    {
        return [number integerValue];
    }
}
-(void)setKf_EnterType:(kf_NSEnterType)kf_EnterType
{
     objc_setAssociatedObject(self, kf_EnterTypeKey, @(kf_EnterType), OBJC_ASSOCIATION_ASSIGN);
    [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
}

-(NSInteger)kf_EnterLength
{
    NSNumber *number = objc_getAssociatedObject(self, kf_EnterLengthKey);
    if (!number) {
        return 0;
    }else
    {
        return [number integerValue];
    }
}

-(void)setKf_EnterLength:(NSInteger)kf_EnterLength
{
     objc_setAssociatedObject(self, kf_EnterLengthKey, @(kf_EnterLength), OBJC_ASSOCIATION_ASSIGN);
}


-(void)textFieldDidChange:(UITextField *)textField
{
    NSString *textString = textField.text;
    
    switch (textField.kf_EnterType) {
        case KF_NSEnterDefault:
            
            break;
        case KF_NSEnterUppercaseAll:
        {
            textField.text = [textString uppercaseString];
            break;
        }
        case KF_NSEnterUppercaseFirst:
        {
            textField.text = [textString capitalizedString];
            break;
        }
        case KF_NSEnterLowercaseAll:
        {
            textField.text = [textString lowercaseString];
            break;
        }
        case KF_NSEnterLowercaseFirst:
        {
            textString = [textString uppercaseString];
            textField.text =[textString stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[textString substringToIndex:1] lowercaseString]];
            break;
        }
       
        default:
            break;
    }
    
    
}

+(void)load
{
    Class class = [self class];
    
    SEL originalSelector = @selector(setDelegate:);
    SEL swizzleSelector = @selector(kf_setDelegate:);
    
    /** setDelegate */
    Method ori_setDelegateM = class_getInstanceMethod(class, originalSelector);
    if (!ori_setDelegateM) {
        return;
    }
    Method kf_setDelegateM = class_getInstanceMethod(class, swizzleSelector);
    if (!kf_setDelegateM) {
        return;
    }
    method_exchangeImplementations(ori_setDelegateM, kf_setDelegateM);
    
    
}

-(void)kf_setDelegate:(id<UITextFieldDelegate>)delegate
{
     [self kf_setDelegate:delegate];
    
    if ([[self class] isSubclassOfClass:[UITextField class]]) {
        Class class = [delegate class];
        SEL  origSelector = @selector(textField:shouldChangeCharactersInRange:replacementString:);
        BOOL didAddMethod = class_addMethod(class, @selector(kf_textField:shouldChangeCharactersInRange:replacementString:), class_getMethodImplementation([self class], @selector(kf_textField:shouldChangeCharactersInRange:replacementString:)), method_getTypeEncoding(class_getInstanceMethod(class, origSelector)));
        
        if (didAddMethod) {
            Method orgDelMtd = class_getInstanceMethod([delegate class], @selector(textField:shouldChangeCharactersInRange:replacementString:));
            Method swzDelMtd = class_getInstanceMethod([self class], @selector(kf_textField:shouldChangeCharactersInRange:replacementString:));
            method_exchangeImplementations(orgDelMtd, swzDelMtd);
        }
    }    
}

-(BOOL)kf_textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length == 0) {//删除键永远有效
        return YES;
    }
    
    //设置输入长度
    if (textField.kf_EnterLength) {
        if (textField.text.length >= textField.kf_EnterLength) {
            return NO;
        }
    }
    
    switch (textField.kf_EnterType) {
        case KF_NSEnterNumber:
        {
            NSString *numberReg = @"^[0-9]*$";
            NSPredicate *numPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numberReg];
            return [numPre evaluateWithObject:string];
        }
         
        case KF_NSEnterNumberPoint:
        {
            NSString *pointReg = @"^[0-9]+([.]{0,1}[0-9]+){0,1}$";
            NSPredicate *pointPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pointReg];
            NSString *pointStr =[textField.text stringByAppendingString:string];
           
            return [pointPre evaluateWithObject:pointStr] || [string isEqualToString:@"."];
        }
            
        default:
        {
            return [textField kf_textField:textField shouldChangeCharactersInRange:range replacementString:string];
        }
            break;
    }
    return YES;
}


@end
