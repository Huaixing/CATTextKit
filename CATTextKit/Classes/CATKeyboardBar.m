//
//  CATKeyboardBar.m
//  CATTextKit
//
//  Created by Shihuaixing on 2020/9/11.
//

#import "CATKeyboardBar.h"
#import <CATCommonKit/CATCommonKit.h>


@interface CATKeyboardBarButton : UIButton

/// 按钮对应的类型
@property (nonatomic, assign) CATBarButtonType type;
@end

@implementation CATKeyboardBarButton

@end




@interface CATKeyboardBar ()

/// emoji button
@property (nonatomic, strong) CATKeyboardBarButton *emojiButton;
/// keyboard button
@property (nonatomic, strong) CATKeyboardBarButton *keyboardButton;
/// photo button
@property (nonatomic, strong) CATKeyboardBarButton *pickPhotoButton;

@end

@implementation CATKeyboardBar

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        _keyboardButton = [self barButtonWithImageNamed:@"cat_text_keyboard_bar_keyboard_type_icon" buttonType:CATBarButtonTypeKeyboard];
        _emojiButton = [self barButtonWithImageNamed:@"cat_text_keyboard_bar_emoji_type_icon" buttonType:CATBarButtonTypeEmoji];
        
        _pickPhotoButton = [self barButtonWithImageNamed:@"cat_text_keyboard_bar_photo_type_icon" buttonType:CATBarButtonTypePhoto];
        
        [self setupDefaultStatus];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _keyboardButton.frame = CGRectMake(0, 0, self.height, self.height);
    _emojiButton.frame = _keyboardButton.frame;
    
    _pickPhotoButton.frame = CGRectMake(_keyboardButton.right, 0, self.height, self.height);
}

#pragma Private

/// 设置默认状态
- (void)setupDefaultStatus {
    _emojiButton.hidden = YES;
    _currentClickType = CATBarButtonTypeKeyboard;
}

/// 创建键盘bar上按钮
/// @param imageNamed icon
/// @return button
- (CATKeyboardBarButton *)barButtonWithImageNamed:(NSString *)imageNamed buttonType:(CATBarButtonType)buttonType {
    CATKeyboardBarButton *button = [[CATKeyboardBarButton alloc] init];
    button.backgroundColor = [UIColor clearColor];
    
    NSString *bundlePath = [[NSBundle bundleForClass:[self class]].resourcePath stringByAppendingPathComponent:@"/CATTextKit.bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    UIImage *image = [UIImage imageNamed:imageNamed inBundle:bundle compatibleWithTraitCollection:nil];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(barButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    button.type = buttonType;
    [self addSubview:button];
    return button;
}

#pragma mark - Action
- (void)barButtonDidClick:(CATKeyboardBarButton *)sender {
    
    self.currentClickType = sender.type;
}

#pragma mark - Public

- (void)setCurrentClickType:(CATBarButtonType)currentClickType {
    _currentClickType = currentClickType;
    if (currentClickType == CATBarButtonTypeKeyboard) {
        _emojiButton.hidden = NO;
        _keyboardButton.hidden = YES;
    } else if (currentClickType == CATBarButtonTypeEmoji) {
        _keyboardButton.hidden = NO;
        _emojiButton.hidden = YES;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(keyboardBarDidClickBarButton:)]) {
        [self.delegate keyboardBarDidClickBarButton:self];
    }
}

@end
