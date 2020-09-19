//
//  CATTextView.h
//  CATTextKit
//
//  Created by Shihuaixing on 2020/9/9.
//

#import <UIKit/UIKit.h>

@interface CATTextView : UITextView

/// place holder color
@property (nonatomic, strong) UIColor *placeHolderColor;

/// place holder font
@property (nonatomic, strong) UIFont *placeHolderFont;

/// place holder
@property (nonatomic, copy) NSString *placeHolder;

/// emoji code change
- (void)inputEmojiCode:(NSString *)emojiCode;
- (void)deleteEmojiCode;

@end


