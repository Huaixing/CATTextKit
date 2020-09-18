//
//  CATKeyboard.h
//  CATTextKit
//
//  Created by Shihuaixing on 2020/9/10.
//

#import <UIKit/UIKit.h>

#import "CATKeyboardFaceItem.h"
@class CATKeyboard, CATEmojiModel;

@protocol CATKeyboardDelegate <NSObject>

@optional
- (void)keyboard:(CATKeyboard *)keyboard didInputEmoji:(CATEmojiModel *)emojiModel;
@end

@interface CATKeyboard : UIView

/// delegate input face
@property (nonatomic, weak) id<CATKeyboardDelegate> delegate;
/// 创建自定义键盘
/// @param frame frame
/// @param categorys 表情键盘上方的分类按钮，如果为空，则只有表情视图
- (instancetype)initWithFrame:(CGRect)frame categorys:(NSArray<CATKeyboardFaceItem *> *)categorys;

@end


