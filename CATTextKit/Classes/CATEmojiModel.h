//
//  CATEmojiModel.h
//  CATTextKit
//
//  Created by Shihuaixing on 2020/9/9.
//

#import <Foundation/Foundation.h>


@interface CATEmojiModel : NSObject

/// name：微笑
@property (nonatomic, copy) NSString *name;
/// code：[微笑]
@property (nonatomic, copy) NSString *code;
/// icon：face_001
@property (nonatomic, copy) NSString *icon;
/// type：自定义表情
@property (nonatomic, assign) BOOL type;

@end

