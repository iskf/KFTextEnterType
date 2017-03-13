# KFTextEnterType
为输入框定制输入类型，不管用户输入什么，都会自动转成定制数据类型


*先看下'效果'
![KF](https://github.com/theKF/KFTextEnterType/blob/master/TextCategory/Untitled2.gif)

*使用
'''Objective-C
@property (weak, nonatomic) IBOutlet UITextField *oneTextField;
- (void)viewDidLoad {
    [super viewDidLoad];
    _oneTextField.kf_EnterType = KF_NSEnterNumber;//设置定制类型
    _oneTextField.kf_EnterLength = 6;//设置可输入长度
}
'''
