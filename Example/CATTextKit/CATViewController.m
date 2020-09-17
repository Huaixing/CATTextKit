//
//  CATViewController.m
//  CATTextKit
//
//  Created by Huaixing on 09/12/2020.
//  Copyright (c) 2020 Huaixing. All rights reserved.
//

#import "CATViewController.h"
#import "CATTextKit.h"
#import <CATCommonKit/CATCommonKit.h>

@interface CATViewController ()<CATKeyboardBarDelegate, UITextViewDelegate>
{
    CGRect _keyboardEndFrame;
}
/// textview
@property (nonatomic, strong) CATTextView *textView;

/// key board
@property (nonatomic, strong) CATKeyboard *keyboard;
/// key board bar
@property (nonatomic, strong) CATKeyboardBar *keyboardBar;

@end

@implementation CATViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    _textView = [[CATTextView alloc] initWithFrame:CGRectMake(0, 100, self.view.width, 300)];
    _textView.backgroundColor = [UIColor lightGrayColor];
    _textView.delegate = self;
    [self.view addSubview:_textView];
    
    _keyboard = [[CATKeyboard alloc] initWithFrame:CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds), self.view.width, 355) categorys:nil];
    [self.view addSubview:_keyboard];
    
    CGFloat barHeight = 64;
    _keyboardBar = [[CATKeyboardBar alloc] initWithFrame:CGRectMake(0, self.view.height - barHeight, _keyboard.width, barHeight)];
    _keyboardBar.backgroundColor = [UIColor redColor];
    _keyboardBar.delegate = self;
    [self.view addSubview:_keyboardBar];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    CGRect endFrame = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    _keyboardEndFrame = endFrame;
    _keyboardBar.currentClickType = CATBarButtonTypeKeyboard;
}

- (void)keyboardWillHide:(NSNotification *)notification {
    CGRect endFrame = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    _keyboardEndFrame = endFrame;
    if (_keyboardBar.currentClickType == CATBarButtonTypeEmoji) {
        _keyboardBar.currentClickType = CATBarButtonTypeEmoji;
    }
}

- (void)textViewBecomeActivity {
    CGFloat screenHeight = CGRectGetHeight([UIScreen mainScreen].bounds);
    // 显示系统键盘
    if (!_textView.isFirstResponder) {
        [_textView becomeFirstResponder];
    }
    // 隐藏自定键盘
    if (CGRectGetMinY(_keyboard.frame) < screenHeight) {
        [UIView animateWithDuration:0.25 animations:^{
            self.keyboard.y = screenHeight;
        }];
    }
    // 键盘上方bar始终显示
    CGFloat toFrameY = CGRectGetMinY(_keyboardEndFrame) - _keyboardBar.height;
    [UIView animateWithDuration:0.25 animations:^{
        self.keyboardBar.y = toFrameY;
    }];
}

- (void)keyboardBecomeActivity {
    CGFloat screenHeight = CGRectGetHeight([UIScreen mainScreen].bounds);
    // 隐藏系统键盘
    if (_textView.isFirstResponder) {
        [_textView resignFirstResponder];
    }
    
    // 显示自定义键盘
    if (CGRectGetMinY(_keyboard.frame) >= screenHeight) {
        [UIView animateWithDuration:0.25 animations:^{
            self.keyboard.y = (screenHeight - self.keyboard.height);
        }];
    }
    // 键盘上方bar始终显示
    CGFloat toFrameY = toFrameY = (screenHeight - _keyboard.height - _keyboardBar.height);
    [UIView animateWithDuration:0.25 animations:^{
        self.keyboardBar.y = toFrameY;
    }];
}

- (void)resignActivity {
    if (_textView.isFirstResponder) {
        [_textView resignFirstResponder];
    }
    CGFloat screenHeight = CGRectGetHeight([UIScreen mainScreen].bounds);
    // 隐藏自定键盘
    if (CGRectGetMinY(_keyboard.frame) < screenHeight) {
        [UIView animateWithDuration:0.25 animations:^{
            self.keyboard.y = screenHeight;
        }];
    }
    // 键盘上方bar始终显示
    if (_keyboardBar.y < screenHeight) {
        CGFloat toFrameY = screenHeight - _keyboardBar.height;
        [UIView animateWithDuration:0.25 animations:^{
            self.keyboardBar.y = toFrameY;
        }];
    }
}


#pragma mark - CATKeyboardBarDelegate
- (void)keyboardBarDidClickBarButton:(CATKeyboardBar *)bar {
    
    if (bar.currentClickType == CATBarButtonTypeKeyboard) {
        [self textViewBecomeActivity];
    } else if (bar.currentClickType == CATBarButtonTypeEmoji) {
        [self keyboardBecomeActivity];
    } else {
        [self resignActivity];
    }
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
