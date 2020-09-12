//
//  CATEmojiManager.h
//  CATTextKit
//
//  Created by Shihuaixing on 2020/9/9.
//

#import <Foundation/Foundation.h>

@class CATEmojiModel;

@interface CATEmojiManager : NSObject

/// 解析后的数据list[CATEmojiModel]
@property (nonatomic, strong, readonly) NSArray<CATEmojiModel *> *emojiModels;

+ (instancetype)manager;

@end

