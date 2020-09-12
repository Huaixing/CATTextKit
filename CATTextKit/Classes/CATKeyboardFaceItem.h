//
//  CATKeyboardFaceItem.h
//  CATTextKit
//
//  Created by Shihuaixing on 2020/9/10.
//

#import <UIKit/UIKit.h>

@class CATEmojiModel;
/// 自定义键盘上category的输入类型
typedef NS_ENUM(NSInteger, CATKeyboardFaceType) {
    // 表情键盘，is default
    CATKeyboardFaceTypeEmoji = 0,
    // add other ....
};


@interface CATKeyboardFaceItem : NSObject

/// face data
@property (nonatomic, strong) NSArray<CATEmojiModel *> *items;
/// type
@property (nonatomic, assign) CATKeyboardFaceType type;
/// column count, default 7
@property (nonatomic, assign) NSUInteger columnCount;

/// hor margin, dedault 2
@property (nonatomic, assign) CGFloat horMargin;
/// ver margin, dedault 2
@property (nonatomic, assign) CGFloat verMargin;

+ (instancetype)categoryItemWithType:(CATKeyboardFaceType)type items:(NSArray<CATEmojiModel *> *)items;
@end


