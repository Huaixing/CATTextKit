//
//  CATTextView.m
//  CATTextKit
//
//  Created by Shihuaixing on 2020/9/9.
//

#import "CATTextView.h"

@interface CATTextView () {
    // 是否已经设置了placeholder的位置
    BOOL _settedPlaceholderPosition;
}

/// placeholder
@property (nonatomic, strong) UILabel *placeholderLabel;

@end

/// 上下左右留白如何设置
/// self.textContainerInset = UIEdgeInsetsMake(20, 40, 0, 40);
/// self.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
/// 第一行时，光标的y位置比textContainerInset.top小1px
@implementation CATTextView

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _settedPlaceholderPosition = NO;
        
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.backgroundColor = [UIColor clearColor];
        _placeholderLabel.numberOfLines = 0;
        [self addSubview:_placeholderLabel];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChange:) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_placeholderLabel.text.length) {
        // 设置placeholder初始位置
        [self caretRectForPosition:self.selectedTextRange.start];
        CGSize size = [_placeholderLabel sizeThatFits:CGSizeMake(CGRectGetWidth(self.frame) - 2 * CGRectGetMinX(_placeholderLabel.frame), CGRectGetHeight(self.frame))];
        CGRect frame = _placeholderLabel.frame;
        frame.size = size;
        _placeholderLabel.frame = frame;
    }
}

- (CGRect)caretRectForPosition:(UITextPosition *)position {
    CGRect originalRect = [super caretRectForPosition:position];
    if (!_settedPlaceholderPosition) {
        _settedPlaceholderPosition = YES;
        CGRect frame = _placeholderLabel.frame;
        frame.origin.x = originalRect.origin.x+1;
        frame.origin.y = originalRect.origin.y+1;
        _placeholderLabel.frame = frame;
    }
    return originalRect;
}

#pragma mark - Public
- (void)setPlaceHolder:(NSString *)placeHolder {
    _placeHolder = [placeHolder copy];
    _placeholderLabel.text = placeHolder;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setPlaceHolderFont:(UIFont *)placeHolderFont {
    if (!placeHolderFont) {
        return;
    }
    _placeHolderFont = placeHolderFont;
    _placeholderLabel.font = placeHolderFont;
    self.font = placeHolderFont;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor {
    if (!placeHolderColor) {
        return;
    }
    _placeHolderColor = placeHolderColor;
    _placeholderLabel.textColor = placeHolderColor;
}

#pragma mark - Notification
- (void)textViewTextDidChange:(NSNotification *)notification {
    if ([notification.object isKindOfClass:[CATTextView class]]) {
        CATTextView *textView = (CATTextView *)notification.object;
        _placeholderLabel.hidden = textView.hasText;
    }
    
}
@end
