//
//  CATKeyboard.h
//  CATTextKit
//
//  Created by Shihuaixing on 2020/9/10.
//

#import <UIKit/UIKit.h>

@class CATKeyboard, CATEmojiModel;

@protocol CATKeyboardDelegate <NSObject>

@optional
- (void)keyboard:(CATKeyboard *)keyboard didInputEmoji:(CATEmojiModel *)emojiModel;
@end

@interface CATKeyboard : UIView

/// delegate input face
@property (nonatomic, weak) id<CATKeyboardDelegate> delegate;

@end


