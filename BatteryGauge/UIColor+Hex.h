//
//  UIColor+Hex.h
//  ShinobiControls
//
//  (c) Scott Logic Ltd 2012. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (UIColor*)colorWithHexValue:(uint)hexValue andAlpha:(float)alpha;
+ (UIColor*)colorWithHexString:(NSString*)hexString andAlpha:(CGFloat)alpha;
- (NSString*)hexString;

@end
