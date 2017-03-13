//
//  FirstViewController.m
//  TextCategory
//
//  Created by InnoeriOS1 on 2017/3/10.
//  Copyright © 2017年 Innoways. All rights reserved.
//

#import "FirstViewController.h"
#import "UITextField+EnterType.h"

@interface FirstViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *oneTextField;
@property (weak, nonatomic) IBOutlet UITextField *two;
@property (weak, nonatomic) IBOutlet UITextField *third;
@property (weak, nonatomic) IBOutlet UITextField *four;
@property (weak, nonatomic) IBOutlet UITextField *five;
@property (weak, nonatomic) IBOutlet UITextField *six;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // _myTextField.delegate = self;
    _oneTextField.kf_EnterType = KF_NSEnterNumber;
    _oneTextField.kf_EnterLength = 6;
    
    
    
    _two.kf_EnterType = KF_NSEnterUppercaseAll;
    
    _third.kf_EnterType = KF_NSEnterUppercaseFirst;
    
    _four.kf_EnterType = KF_NSEnterLowercaseAll;
    _four.kf_EnterLength = 10;
    
    _five.kf_EnterType = KF_NSEnterNumberPoint;
    
    _six.kf_EnterType = KF_NSEnterLowercaseFirst;
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"%@-",textField.text);
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"%@-",textField.text);
    
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
     NSLog(@"%@-",textField.text);
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
