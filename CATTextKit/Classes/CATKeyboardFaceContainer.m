//
//  CATKeyboardFaceContainer.m
//  CATTextKit
//
//  Created by Shihuaixing on 2020/9/10.
//

#import "CATKeyboardFaceContainer.h"
#import "CATKeyboardFaceItem.h"

#import "CATKeyboardFaceButton.h"

#import "CATEmojiModel.h"
#import <CATCommonKit/CATCommonKit.h>

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
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.alwaysBounceVertical = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = YES;
        [self addSubview:_scrollView];
    }
    return self;
}

- (NSMutableArray<CATKeyboardFaceButton *> *)faceButtons {
    if (!_faceButtons) {
        _faceButtons = [[NSMutableArray alloc] init];
    }
    return _faceButtons;
}

- (void)setCategoryItem:(CATKeyboardFaceItem *)categoryItem {
    _categoryItem = categoryItem;
    [self.faceButtons removeAllObjects];
    
    for (CATEmojiModel *model in categoryItem.items) {
        CATKeyboardFaceButton *button = [[CATKeyboardFaceButton alloc] init];
        button.emojiModel = model;
        button.backgroundColor = [UIColor whiteColor];
        [button addTarget:self action:@selector(faceButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.faceButtons addObject:button];
        [_scrollView addSubview:button];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _scrollView.frame = self.bounds;
    
    if (_categoryItem.type == CATKeyboardFaceTypeEmoji) {
        // emoji
        CGFloat buttonWidth = (_scrollView.width - _categoryItem.horMargin) / _categoryItem.columnCount;
        CGFloat buttonHeight = buttonWidth;
        
        for (NSInteger index = 0; index < self.faceButtons.count; index ++) {
            // 第row行
            NSUInteger row = index / _categoryItem.columnCount;
            // 第col列
            NSUInteger col = index % _categoryItem.columnCount;
            CATKeyboardFaceButton *button = [self.faceButtons objectAtIndex:index];
            button.frame = CGRectMake(col * (buttonWidth + _categoryItem.horMargin), row * (buttonHeight + _categoryItem.verMargin), buttonWidth, buttonHeight);
        }
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
