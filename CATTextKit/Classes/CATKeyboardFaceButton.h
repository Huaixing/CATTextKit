//
//  CATKeyboardFaceButton.h
//  CATTextKit
//
//  Created by Shihuaixing on 2020/9/12.
//  Copyright © 2020 Shihuaixing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CATEmojiModel;

@interface CATKeyboardFaceButton : UIButton

/// emoji type
@property (nonatomic, strong) CATEmojiModel *emojiModel;

@end


