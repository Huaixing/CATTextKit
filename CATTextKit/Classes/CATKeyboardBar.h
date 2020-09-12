//
//  CATKeyboardBar.h
//  CATTextKit
//
//  Created by Shihuaixing on 2020/9/11.
//

#import <UIKit/UIKit.h>

@class CATKeyboardBar;


typedef NS_ENUM(NSInteger, CATKeyboardType) {
    CATKeyboardTypeKeyboard,
    CATKeyboardTypeEmoji,
    CATKeyboardTypeNone,
};


@protocol CATKeyboardBarDelegate <NSObject>

@optional
- (void)keyboardBarDidClickPickPhotoButton:(CATKeyboardBar *)bar;
- (void)keyboardBarDidClickToChangeKeyboard:(CATKeyboardBar *)bar;

@end



@interface CATKeyboardBar : UIView
/// current selected keyboard type
@property (nonatomic, assign, readonly) CATKeyboardType currentKeyboardType;

/// delgate
@property (nonatomic, weak) id<CATKeyboardBarDelegate> delegate;


@end

