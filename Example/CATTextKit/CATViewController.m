//
//  CATViewController.m
//  CATTextKit
//
//  Created by Huaixing on 09/12/2020.
//  Copyright (c) 2020 Huaixing. All rights reserved.
//

#import "CATViewController.h"
#import "CATTextKit.h"

@interface CATViewController ()<CATKeyboardBarDelegate>
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    _textView = [[CATTextView alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 300)];
    _textView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_textView];
    
    _keyboard = [[CATKeyboard alloc] initWithFrame:CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds), CGRectGetWidth(self.view.frame), 355) categorys:nil];
    [self.view addSubview:_keyboard];
    
    CGFloat barHeight = 64;
    _keyboardBar = [[CATKeyboardBar alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - barHeight, CGRectGetWidth(_keyboard.frame), barHeight)];
    _keyboardBar.backgroundColor = [UIColor redColor];
    _keyboardBar.delegate = self;
    [self.view addSubview:_keyboardBar];
}

- (void)keyboardFrameWillChange:(NSNotification *)notification {
    CGRect endFrame = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    _keyboardEndFrame = endFrame;
}

#pragma mark - CATKeyboardBarDelegate
- (void)keyboardBarDidClickPickPhotoButton:(CATKeyboardBar *)bar {
    CGFloat screenHeight = CGRectGetHeight([UIScreen mainScreen].bounds);
    if (bar.currentKeyboardType == CATKeyboardTypeKeyboard) {
        [_textView resignFirstResponder];
    } else if (bar.currentKeyboardType == CATKeyboardTypeEmoji) {
        // 当前显示的表情键盘，需要隐藏表情键盘
        if (CGRectGetMinY(_keyboard.frame) < screenHeight) {
            [UIView animateWithDuration:0.25 animations:^{
                CGRect frame = self.keyboard.frame;
                frame.origin.y = screenHeight;
                self.keyboard.frame = frame;
            }];
        }
    }
    if (CGRectGetMaxY(_keyboardBar.frame) < screenHeight) {
        // 键盘上方bar回落至底部
        CGFloat toFrameY = screenHeight - CGRectGetHeight(_keyboardBar.frame);
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = self.keyboardBar.frame;
            frame.origin.y = toFrameY;
            self.keyboardBar.frame = frame;
        }];
    }
}

- (void)keyboardBarDidClickToChangeKeyboard:(CATKeyboardBar *)bar {
    
    CGFloat screenHeight = CGRectGetHeight([UIScreen mainScreen].bounds);
    if (bar.currentKeyboardType == CATKeyboardTypeKeyboard) {
        // 显示系统键盘
        [_textView becomeFirstResponder];
        // 隐藏自定键盘
        if (CGRectGetMinY(_keyboard.frame) < screenHeight) {
            [UIView animateWithDuration:0.25 animations:^{
                CGRect frame = self.keyboard.frame;
                frame.origin.y = screenHeight;
                self.keyboard.frame = frame;
            }];
        }
        
    } else if (bar.currentKeyboardType == CATKeyboardTypeEmoji) {
        // 隐藏系统键盘
        [_textView resignFirstResponder];
        // 显示自定义键盘
        if (CGRectGetMinY(_keyboard.frame) >= screenHeight) {
            [UIView animateWithDuration:0.25 animations:^{
                CGRect frame = self.keyboard.frame;
                frame.origin.y = screenHeight - CGRectGetHeight(self.keyboard.frame);
                self.keyboard.frame = frame;
            }];
        }
    }
    
    // 键盘上方bar始终显示
    CGFloat toFrameY = screenHeight - CGRectGetHeight(_keyboardBar.frame);
    if (bar.currentKeyboardType == CATKeyboardTypeKeyboard) {
        toFrameY = CGRectGetMinY(_keyboardEndFrame) - CGRectGetHeight(_keyboardBar.frame);
    } else if (bar.currentKeyboardType == CATKeyboardTypeEmoji) {
        toFrameY = (screenHeight - CGRectGetHeight(_keyboard.frame)) - CGRectGetHeight(_keyboardBar.frame);
    }
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.keyboardBar.frame;
        frame.origin.y = toFrameY;
        self.keyboardBar.frame = frame;
    }];
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
