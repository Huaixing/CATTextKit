//
//  CATKeyboardFaceItem.m
//  CATTextKit
//
//  Created by Shihuaixing on 2020/9/10.
//

#import "CATKeyboardFaceItem.h"

@implementation CATKeyboardFaceItem


+ (instancetype)categoryItemWithType:(CATKeyboardFaceType)type items:(NSArray<CATEmojiModel *> *)items; {
    CATKeyboardFaceItem *item = [[CATKeyboardFaceItem alloc] init];
    item.items = items;
    item.type = type;
    item.columnCount = 7;
    item.horMargin = 2;
    item.verMargin = 2;
    return item;
}
@end
