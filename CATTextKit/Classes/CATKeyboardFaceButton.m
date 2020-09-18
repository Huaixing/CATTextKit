//
//  CATKeyboardFaceButton.m
//  CATTextKit
//
//  Created by Shihuaixing on 2020/9/12.
//  Copyright © 2020 Shihuaixing. All rights reserved.
//

#import "CATKeyboardFaceButton.h"
#import "CATEmojiModel.h"

@implementation CATKeyboardFaceButton

- (void)setEmojiModel:(CATEmojiModel *)emojiModel {
    _emojiModel = emojiModel;
    
    [self setImage:emojiModel.faceImage forState:UIControlStateNormal];
}

@end
