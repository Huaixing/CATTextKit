//
//  CATKeyboardBar.h
//  CATTextKit
//
//  Created by Shihuaixing on 2020/9/11.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CATBarButtonType) {
    CATBarButtonTypeKeyboard,
    CATBarButtonTypeEmoji,
    CATBarButtonTypePhoto,
};

@class CATKeyboardBar;

@protocol CATKeyboardBarDelegate <NSObject>

@optional
- (void)keyboardBarDidClickBarButton:(CATKeyboardBar *)bar;

@end

@interface CATKeyboardBar : UIView

/// 当前点击的按钮类型
@property (nonatomic, assign) CATBarButtonType currentClickType;

/// delgate
@property (nonatomic, weak) id<CATKeyboardBarDelegate> delegate;


@end

