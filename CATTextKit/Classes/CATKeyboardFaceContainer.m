//
//  CATKeyboardFaceContainer.m
//  CATTextKit
//
//  Created by Shihuaixing on 2020/9/10.
//

#import "CATKeyboardFaceContainer.h"

#import "CATKeyboardFaceButton.h"

#import "CATEmojiManager.h"
#import <CATCommonKit/CATCommonKit.h>
#import "CATEmojiModel.h"

@interface CATKeyboardFaceContainer ()
/// scrollview
@property (nonatomic, strong) UIScrollView *scrollView;
/// buttons
@property (nonatomic, strong) NSMutableArray<CATKeyboardFaceButton *> *faceButtons;

@end

@implementation CATKeyboardFaceContainer

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.alwaysBounceVertical = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = YES;
    [self addSubview:_scrollView];
    
    if ([CATEmojiManager manager].emojiModels.count) {
        for (NSInteger index = 0; index < [CATEmojiManager manager].emojiModels.count; index ++) {
            CATEmojiModel *emoji = [[CATEmojiManager manager].emojiModels objectAtIndex:index];
            if (!emoji.faceImage) {
                continue;
            }
            CATKeyboardFaceButton *button = [[CATKeyboardFaceButton alloc] init];
            button.backgroundColor = [UIColor clearColor];
            button.emojiModel = emoji;
            [_scrollView addSubview:button];
            [self.faceButtons addObject:button];
            
            [button addTarget:self action:@selector(faceButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
}

- (NSMutableArray<CATKeyboardFaceButton *> *)faceButtons {
    if (!_faceButtons) {
        _faceButtons = [[NSMutableArray alloc] init];
    }
    return _faceButtons;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _scrollView.frame = self.bounds;
    // emoji
    NSUInteger columnCount = 6;
    CGFloat buttonMargin = 7;
    CGFloat buttonWidth = (_scrollView.width - (columnCount - 1) * buttonMargin) / columnCount;
    CGFloat buttonHeight = buttonWidth;

    for (NSInteger index = 0; index < self.faceButtons.count; index ++) {
        // 第row行
        NSUInteger row = index / columnCount;
        // 第col列
        NSUInteger col = index % columnCount;
        CATKeyboardFaceButton *button = [self.faceButtons objectAtIndex:index];
        button.frame = CGRectMake(col * (buttonWidth + buttonMargin), row * (buttonHeight + buttonMargin), buttonWidth, buttonHeight);
    }

    _scrollView.contentSize = CGSizeMake(_scrollView.width, [self.faceButtons lastObject].bottom);
}

#pragma mark - Action
- (void)faceButtonDidClick:(CATKeyboardFaceButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(keyboardFaceContainer:didClickFaceModel:)]) {
        [self.delegate keyboardFaceContainer:self didClickFaceModel:sender.emojiModel];
    }
}

@end
