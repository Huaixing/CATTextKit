//
//  CATKeyboardFaceContainer.h
//  CATTextKit
//
//  Created by Shihuaixing on 2020/9/10.
//

#import <UIKit/UIKit.h>
@class CATKeyboardFaceItem, CATKeyboardFaceContainer, CATEmojiModel;

@protocol CATKeyboardFaceContainerDelegate <NSObject>
@optional
- (void)keyboardFaceContainer:(CATKeyboardFaceContainer *)faceContainer didClickFaceModel:(CATEmojiModel *)faceModel;
@end


@interface CATKeyboardFaceContainer : UIView
/// delegate click face
@property (nonatomic, weak) id<CATKeyboardFaceContainerDelegate> delegate;

/// item datas
@property (nonatomic, strong) CATKeyboardFaceItem *categoryItem;

@end

