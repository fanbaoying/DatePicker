//
//  ViewController.m
//  DatePicker
//
//  Created by 范保莹 on 2017/10/23.
//  Copyright © 2017年 DatePicker. All rights reserved.
//

#import "ViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIDatePicker *datePicker;

@property(strong,nonatomic)UITextField *timeTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.timeTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 200, SCREEN_WIDTH-20, 50)];
    self.timeTextField.textColor = [UIColor blueColor];
    self.timeTextField.layer.borderWidth = 1.0;
    self.timeTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.timeTextField.placeholder = @"请选择时间";
    self.timeTextField.textAlignment = NSTextAlignmentCenter;
    self.timeTextField.delegate = self;
    [self.view addSubview:_timeTextField];
    
    
    [self setupDateKeyPan];
}

//隐藏时间表盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}

- (void)setupDateKeyPan {
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    
    //设置地区: zh-中国
    datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    
    //设置日期模式(Displays month, day, and year depending on the locale setting)
    datePicker.datePickerMode = UIDatePickerModeCountDownTimer;
    // 设置当前显示时间
    [datePicker setDate:[NSDate date] animated:YES];
    // 设置显示最大时间（此处为当前时间）
    [datePicker setMaximumDate:[NSDate date]];
    
    //设置时间格式
    
    //监听DataPicker的滚动
    [datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    
    self.datePicker = datePicker;
    
    //设置时间输入框的键盘框样式为时间选择器
    self.timeTextField.inputView = datePicker;
}

//禁止用户输入文字
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
  return NO;
}

//became first responder(已经成为第一响应者的时候调用), 目的是为了弹出键盘, TF默认显示当前日期
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    [self dateChange:_datePicker];
    
}

- (void)dateChange:(UIDatePicker *)datePicker {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    //设置时间格式
    formatter.dateFormat = @"yyyy年 MM月 dd日";
    NSString *dateStr = [formatter  stringFromDate:datePicker.date];
    
    self.timeTextField.text = dateStr;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
