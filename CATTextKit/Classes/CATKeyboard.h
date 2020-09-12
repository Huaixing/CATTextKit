//
//  CATKeyboard.h
//  CATTextKit
//
//  Created by Shihuaixing on 2020/9/10.
//

#import <UIKit/UIKit.h>

#import "CATKeyboardFaceItem.h"

@interface CATKeyboard : UIView


/// 创建自定义键盘
/// @param frame frame
/// @param categorys 表情键盘上方的分类按钮，如果为空，则只有表情视图
- (instancetype)initWithFrame:(CGRect)frame categorys:(NSArray<CATKeyboardFaceItem *> *)categorys;

@end


