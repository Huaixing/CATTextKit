//
//  CATEmojiModel.m
//  CATTextKit
//
//  Created by Shihuaixing on 2020/9/9.
//

#import "CATEmojiModel.h"

@implementation CATEmojiModel

/// 重写setValue:forUndefinedKey防止程序crash
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (UIImage *)faceImage {
    NSURL *bundleUrl = [[NSBundle mainBundle] URLForResource:@"emoji" withExtension:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithURL:bundleUrl];
    UIImage *image = [UIImage imageNamed:self.icon inBundle:bundle compatibleWithTraitCollection:nil];
    return image;
}



@end
