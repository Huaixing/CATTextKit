//
//  CATKeyboard.m
//  CATTextKit
//
//  Created by Shihuaixing on 2020/9/10.
//

#import "CATKeyboard.h"
#import "CATKeyboardFaceContainer.h"
#import <CATCommonKit.h>

@interface CATKeyboard ()<CATKeyboardFaceContainerDelegate>

/// scrollview，CATFaceContainer on it，和功能种类模块联动
@property (nonatomic, strong) UIScrollView *scrollView;
/// CATFaceContainer list
@property (nonatomic, strong) NSMutableArray<CATKeyboardFaceContainer *> *faceContainters;
@end

@implementation CATKeyboard

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createCommonUI];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    _scrollView.frame = self.bounds;

    // contanier
    for (NSInteger index = 0; index < self.faceContainters.count; index ++) {
        CATKeyboardFaceContainer *container = [self.faceContainters objectAtIndex:index];
        container.frame = CGRectMake(index * CGRectGetWidth(_scrollView.frame), 0, CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame));
    }
    _scrollView.contentSize = CGSizeMake(self.faceContainters.count * CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame));
}

#pragma mark - Private
- (void)createCommonUI {
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    _scrollView.backgroundColor = [UIColor blueColor];
    _scrollView.scrollEnabled = NO;
    _scrollView.contentInset = UIEdgeInsetsMake(0, 0, [UIView safeAreaInsetsBottom], 0);
    [self addSubview:_scrollView];
    
    [self createFaceContainer];
}


- (void)createFaceContainer {
    CATKeyboardFaceContainer *container = [[CATKeyboardFaceContainer alloc] init];
    container.backgroundColor = [UIColor purpleColor];
    container.delegate = self;
    [_scrollView addSubview:container];
    [self.faceContainters addObject:container];
}

#pragma mark - Getter
- (NSMutableArray<CATKeyboardFaceContainer *> *)faceContainters {
    if (!_faceContainters) {
        _faceContainters = [[NSMutableArray alloc] init];
    }
    return _faceContainters;
}

#pragma mark - CATKeyboardFaceContainerDelegate
- (void)keyboardFaceContainer:(CATKeyboardFaceContainer *)faceContainer didClickFaceModel:(CATEmojiModel *)faceModel {
    if (self.delegate && [self.delegate respondsToSelector:@selector(keyboard:didInputEmoji:)]) {
        [self.delegate keyboard:self didInputEmoji:faceModel];
    }
}


@end
