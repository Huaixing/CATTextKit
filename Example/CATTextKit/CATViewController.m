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

#define KMArgin                     60
#define KPositionY                  100
@interface CATViewController ()<CATKeyboardBarDelegate, UITextViewDelegate, CATKeyboardDelegate> {
    CGRect _keyboardEndFrame;
}
/// textview
@property (nonatomic, strong) CATTextView *textView;

/// key board
@property (nonatomic, strong) CATKeyboard *keyboard;
/// key board bar
@property (nonatomic, strong) CATKeyboardBar *keyboardBar;

/// uiview
@property (nonatomic, strong) UIButton *photoModuleView;

@end

@implementation CATViewController
// static NSString *topicPattern = @"#[^#\r\n]+#";//@"#[0-9a-zA-Z\\u4e00-\\u9fa5\\s*]+#";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    _textView = [[CATTextView alloc] initWithFrame:CGRectMake(0, 88, self.view.width, self.view.height - 88)];
    _textView.backgroundColor = [UIColor lightGrayColor];
    _textView.font = [UIFont systemFontOfSize:16];
    _textView.delegate = self;
    _textView.layoutManager.allowsNonContiguousLayout = NO;
    _textView.alwaysBounceVertical = YES;
    _textView.textContainerInset = UIEdgeInsetsZero;
    _textView.textContainer.lineFragmentPadding = 0;
    [self.view addSubview:_textView];
    _textView.placeHolder = @"哈哈哈哈";
    _textView.placeHolderColor = [UIColor redColor];
    
    /*
    _textView.scrollEnabled = NO;
    _textView.textColor = [UIColor blueColor];
    _textView.editable = NO;
    NSString *string = @"和发动机康师傅空间撒#凤凰山#打发货单撒发货单索拉卡返回的森林防火删掉了粉红色的啦";
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
    [attString addAttribute:NSForegroundColorAttributeName value:_textView.textColor range:NSMakeRange(0, string.length)];
    [attString addAttribute:NSFontAttributeName value:_textView.font range:NSMakeRange(0, string.length)];
    static NSRegularExpression *regExpress = nil;
    if (regExpress == nil) {
        regExpress = [[NSRegularExpression alloc]initWithPattern:topicPattern options:0 error:nil];
    }
    //通过正则表达式识别出emojiText
    NSArray *matches = [regExpress matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    if(matches.count > 0){
        for (NSTextCheckingResult *result in [matches reverseObjectEnumerator]) {
            
            
            
            
            [attString addAttribute:NSLinkAttributeName
                               value:@""
                               range:result.range];
            
                [attString addAttribute:NSUnderlineStyleAttributeName
                               value:@(NSUnderlineStyleNone)
                               range:result.range];
            [attString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:result.range];
                [attString endEditing];
        }
    }
    // 这个不加的话颜色无法单独控制
    _textView.linkTextAttributes = @{};
    _textView.attributedText = attString;
     */
    
    _keyboard = [[CATKeyboard alloc] initWithFrame:CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds), self.view.width, 355) categorys:nil];
    _keyboard.delegate = self;
    [self.view addSubview:_keyboard];
    
    CGFloat barHeight = 64;
    _keyboardBar = [[CATKeyboardBar alloc] initWithFrame:CGRectMake(0, self.view.height - barHeight, self.view.width, barHeight)];
    _keyboardBar.backgroundColor = [UIColor redColor];
    _keyboardBar.delegate = self;
    [self.view addSubview:_keyboardBar];
    
    _photoModuleView = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds), _textView.width, 200)];
    _photoModuleView.backgroundColor = [UIColor purpleColor];
    [_photoModuleView addTarget:self action:@selector(testDeleteEmoji) forControlEvents:UIControlEventTouchUpInside];
    [_textView addSubview:_photoModuleView];
    
    [_textView becomeFirstResponder];
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
    // textview 底部inset = 键盘高度 + 输入bar高度 + 留白
    CGFloat contentInsetBottom = (CGRectGetHeight(_keyboardEndFrame) + _keyboardBar.height) + KMArgin;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.keyboardBar.y = toFrameY;
    } completion:^(BOOL finished) {
        self.textView.contentInset = UIEdgeInsetsMake(0, 0, contentInsetBottom, 0);
    }];
    // 唤起系统键盘时，更新照片位置
    [self updatePhotoModulePositionY];
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
    
    // textview 底部inset = 键盘高度 + 输入bar高度 + 留白
    CGFloat contentInsetBottom = (CGRectGetHeight(_keyboardEndFrame) + _keyboardBar.height) + KMArgin;
    // 键盘上方bar始终显示
    CGFloat toFrameY = toFrameY = (screenHeight - _keyboard.height - _keyboardBar.height);
    
    [UIView animateWithDuration:0.25 animations:^{
        self.keyboardBar.y = toFrameY;
    } completion:^(BOOL finished) {
        self.textView.contentInset = UIEdgeInsetsMake(0, 0, contentInsetBottom, 0);
    }];
    [self updatePhotoModulePositionY];
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


- (void)updatePhotoModulePositionY {
    CGFloat screenHeight = CGRectGetHeight([UIScreen mainScreen].bounds);
    if (_textView.text.length) {
        if (_keyboardBar.bottom < screenHeight) {
            // 有键盘
            CGSize textSize = [_textView sizeThatFits:CGSizeMake(_textView.width, MAXFLOAT)];
            if (textSize.height < KPositionY) {
            } else {
                _photoModuleView.y = textSize.height;
                [self.textView scrollRectToVisible:[self.textView firstRectForRange:self.textView.selectedTextRange] animated:NO];
            }
        }
        
    } else {
        _photoModuleView.y = KPositionY;// 默认
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


- (void)textViewDidChange:(UITextView *)textView {
    [self updatePhotoModulePositionY];
}

#pragma mark - CATKeyboardDelegate
- (void)keyboard:(CATKeyboard *)keyboard didInputEmoji:(CATEmojiModel *)emojiModel {
    if (!emojiModel.code.length) {
        return;
    }
    [_textView inputEmojiCode:emojiModel.code];
}

#pragma mark - Action
- (void)testDeleteEmoji {
    [_textView deleteEmojiCode];
}
@end
