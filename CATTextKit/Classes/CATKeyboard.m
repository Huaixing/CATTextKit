//
//  CATKeyboard.m
//  CATTextKit
//
//  Created by Shihuaixing on 2020/9/10.
//

#import "CATKeyboard.h"
#import "CATKeyboardFaceContainer.h"
#import "CATKeyboardFaceItemButton.h"
#import "CATEmojiManager.h"

@interface CATKeyboard ()
/// 功能种类模块
@property (nonatomic, strong) UIView *categoryBar;
/// category buttons
@property (nonatomic, strong) NSMutableArray<CATKeyboardFaceItemButton *> *categoryButtons;

/// scrollview，CATFaceContainer on it，和功能种类模块联动
@property (nonatomic, strong) UIScrollView *scrollView;
/// CATFaceContainer list
@property (nonatomic, strong) NSMutableArray<CATKeyboardFaceContainer *> *faceContainters;

/// category s
@property (nonatomic, strong) NSArray *categoryItems;
@end

@implementation CATKeyboard

#pragma mark - Init
/// 创建自定义键盘
/// @param frame frame
/// @param categorys 表情键盘上方的分类按钮，如果为空，则只有表情视图
- (instancetype)initWithFrame:(CGRect)frame categorys:(NSArray<CATKeyboardFaceItem *> *)categorys {
    self = [super initWithFrame:frame];
    if (self) {
        // 只有一个表情，默认
        _categoryItems = categorys;
        [self createCommonUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createCommonUI];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    if (![self categoryBarHidden]) {
        _categoryBar.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 64);
        _scrollView.frame = CGRectMake(0, CGRectGetMaxY(_categoryBar.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - CGRectGetMaxY(_categoryBar.frame));
        
        // category button
        for (NSInteger index = 0; index < self.categoryButtons.count; index ++) {
            CATKeyboardFaceItemButton *button = [self.categoryButtons objectAtIndex:index];
            button.frame = CGRectMake(index * (CGRectGetHeight(_categoryBar.frame) + 10), 0, CGRectGetHeight(_categoryBar.frame), CGRectGetHeight(_categoryBar.frame));
        }
        
    } else {
        _scrollView.frame = self.bounds;
    }

    // contanier
    for (NSInteger index = 0; index < self.faceContainters.count; index ++) {
        CATKeyboardFaceContainer *container = [self.faceContainters objectAtIndex:index];
        container.frame = CGRectMake(index * CGRectGetWidth(_scrollView.frame), 0, CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame));
    }
    _scrollView.contentSize = CGSizeMake(self.faceContainters.count * CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame));
}

#pragma mark - Private
///表情键盘上的bar 是否隐藏
- (BOOL)categoryBarHidden {
    return !(_categoryItems.count > 1);
}

- (void)setupDefaultCategoryItems {
    if (_categoryItems.count > 0) {
        return;
    }
    CATKeyboardFaceItem *item = [CATKeyboardFaceItem categoryItemWithType:CATKeyboardFaceTypeEmoji items:[CATEmojiManager manager].emojiModels];
    _categoryItems = @[item];
}

- (void)createCommonUI {
    
    if ([self categoryBarHidden]) {
        // 设置默认emoji表情键盘
        [self setupDefaultCategoryItems];
    }
    
    _categoryBar = [[UIView alloc] init];
    _categoryBar.backgroundColor = [UIColor redColor];
    _categoryBar.hidden = [self categoryBarHidden];
    [self addSubview:_categoryBar];
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor blueColor];
    [self addSubview:_scrollView];
    
    [self createCategoryButton];
    
    [self createFaceContainer];
}

- (void)createCategoryButton {
    if ([self categoryBarHidden]) {
        return;
    }
    for (NSInteger index = 0; index < _categoryItems.count; index ++) {
        CATKeyboardFaceItemButton *button = [[CATKeyboardFaceItemButton alloc] init];
        button.backgroundColor = [UIColor lightGrayColor];
        [_categoryBar addSubview:button];
        [self.categoryButtons addObject:button];
    }
}

- (void)createFaceContainer {
    for (NSInteger index = 0; index < _categoryItems.count; index ++) {
        CATKeyboardFaceContainer *container = [[CATKeyboardFaceContainer alloc] init];
        container.backgroundColor = [UIColor purpleColor];
        container.categoryItem = [_categoryItems objectAtIndex:index];
        [_scrollView addSubview:container];
        [self.faceContainters addObject:container];
    }
}

#pragma mark - Getter
- (NSMutableArray<CATKeyboardFaceContainer *> *)faceContainters {
    if (!_faceContainters) {
        _faceContainters = [[NSMutableArray alloc] init];
    }
    return _faceContainters;
}

- (NSMutableArray<CATKeyboardFaceItemButton *> *)categoryButtons {
    if (!_categoryButtons) {
        _categoryButtons = [[NSMutableArray alloc] init];
    }
    return _categoryButtons;
}


@end
