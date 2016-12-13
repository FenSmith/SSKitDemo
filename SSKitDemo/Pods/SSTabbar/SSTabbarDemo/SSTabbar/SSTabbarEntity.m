//
//  SSTabbarEntity.m
//  SSKit
//
//  Created by Quincy Yan on 16/8/28.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSTabbarEntity.h"

@interface SSTabbarEntity()
@property (nonatomic,strong) NSMutableDictionary *imageStyleSheet;
@property (nonatomic,strong) NSMutableDictionary *textStyleSheet;
@property (nonatomic,strong) NSMutableDictionary *attributesStyleSheet;
@property (nonatomic,strong) NSMutableDictionary *backgroundColorStyleSheet;
@property (nonatomic) UIControlState currState;
@property (nonatomic) CGRect rectImage;
@property (nonatomic) CGRect rectText;
@end

@implementation SSTabbarEntity

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    self.backgroundColor = [UIColor clearColor];
    self.currState = UIControlStateNormal;
    self.imageStyleSheet = [[NSMutableDictionary alloc] init];
    self.textStyleSheet = [[NSMutableDictionary alloc] init];
    self.attributesStyleSheet = [[NSMutableDictionary alloc] init];
    self.backgroundColorStyleSheet = [[NSMutableDictionary alloc] init];
    
    self.rectImage = CGRectMake(0, 0, 25, 25);
    self.badgeEdgeInsets = UIEdgeInsetsMake(5, 0, 0, 5);
    self.badgeTintColor = [UIColor redColor];
    self.badgeAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:14],
                             NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    return self;
}

- (void)resetCornerRadius:(CGFloat)cornerRadius alsoCorners:(UIRectCorner)corners {
    CGRect rect = CGRectMake(0, 0, self.entitySize.width, self.entitySize.height);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *mask = [CAShapeLayer layer];
    mask.frame = rect;
    mask.path = maskPath.CGPath;
    self.layer.mask = mask;
    self.clipsToBounds = YES;
}

- (void)resetBadgeValue:(NSInteger)badgeValue {
    if (badgeValue != self.badgeValue) {
        self.badgeValue = badgeValue;
        [self setNeedsDisplay];
    }
}

- (void)setSelected:(BOOL)selected {
    if (selected && self.currState == UIControlStateSelected) return;
    if (!selected && self.currState == UIControlStateNormal) return;
    
    if (selected) {
        self.currState = UIControlStateSelected;
    } else {
        self.currState = UIControlStateNormal;
    }
    [self setNeedsDisplay];
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    if (self.currState != UIControlStateSelected) {
        self.currState = UIControlStateHighlighted;
        [self setNeedsDisplay];
    }
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    if (self.currState != UIControlStateSelected) {
        self.currState = UIControlStateNormal;
        [self setNeedsDisplay];
    }
}

- (void)setImage:(NSString *)image alsoText:(NSString *)text forControlState:(UIControlState)state {
    if (image) {
        [self.imageStyleSheet setObject:image forKey:@(state)];
    }
    if (text) {
        [self.textStyleSheet setObject:text forKey:@(state)];
    }
}

- (void)setTextAttributes:(NSDictionary *)attributes forControlState:(UIControlState)state {
    if (attributes) {
        [self.attributesStyleSheet setObject:attributes forKey:@(state)];
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor forControlState:(UIControlState)state {
    if (backgroundColor) {
        [self.backgroundColorStyleSheet setObject:backgroundColor forKey:@(state)];
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGFloat w = CGRectGetWidth(self.frame);
    CGFloat h = CGRectGetHeight(self.frame);
    
    [[self entityBackgroundColor] setFill];
    CGRect bounds = CGRectMake(0, 0, w, h);
    UIRectFill(bounds);
    
    UIImage *image = [self entityImage];
    NSString *entityText = [self entityText];
    
    if (!entityText && image) { ///> only image
        if (CGSizeEqualToSize(CGSizeZero, self.imageSize)) {
            self.imageSize = image.size;
        }
        self.rectImage = CGRectMake((w - self.imageSize.width) / 2,
                                    (h - self.imageSize.height) / 2,
                                    self.imageSize.width,
                                    self.imageSize.height);
    } else {
        self.rectImage = CGRectMake((w - self.rectImage.size.width) / 2, 5, self.rectImage.size.width, self.rectImage.size.height);
    }
    
    if (image) {
        [image drawInRect:self.rectImage];
    }
    
    if (entityText) {
        NSDictionary *attributes = [self entityAttributes];
        CGSize size = [self strSizeWithFont:[(UIFont *)[attributes objectForKey:NSFontAttributeName] pointSize] alsoMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) alsoStr:entityText];
        [entityText drawInRect:CGRectMake((w - size.width) / 2, CGRectGetMaxY(self.rectImage) + 1, size.width, size.height)
                withAttributes:attributes];
    }
    
    // BadgeValue
    if (self.badgeValue > 0) {
        NSString *badgeValue = [NSString stringWithFormat:@"%d",(int)self.badgeValue];
        CGSize size = [self strSizeWithFont:[self badgeFont].pointSize alsoMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) alsoStr:badgeValue];
        CGSize badgeSize = size;
        
        if (CGSizeEqualToSize(self.badgeSize, CGSizeZero)) {
            if (size.height + 2 * [self badgePadding] < [self defaultBadgeSize].height) {
                badgeSize.height = [self defaultBadgeSize].height;
            }
            
            if (size.width + 2 * [self badgePadding] < [self defaultBadgeSize].width) {
                badgeSize.width = [self defaultBadgeSize].width;
            }
            
            if (badgeSize.width < badgeSize.height) {
                badgeSize.width = badgeSize.height;
            }
            
            switch (self.badgeType) {
                case SSTabbarBadgeTypeColor:{
                    badgeSize = CGSizeMake(10, 10);
                }
                    break;
                case SSTabbarBadgeTypeNumber:{
                    badgeSize = CGSizeMake(badgeSize.width + 2 * [self badgePadding], badgeSize.height + 2 * [self badgePadding]);
                }
                    break;
                    
                default:
                    break;
            }
        }
        
        CGRect badgeRect = CGRectMake(w - badgeSize.width - self.badgeEdgeInsets.right, self.badgeEdgeInsets.top, badgeSize.width, badgeSize.height);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [self.badgeTintColor CGColor]);
        CGContextFillEllipseInRect(context, badgeRect);
        
        switch (self.badgeType) {
            case SSTabbarBadgeTypeColor:{
                
            }
                break;
            case SSTabbarBadgeTypeNumber:{
                CGRect textRect = CGRectMake(CGRectGetMinX(badgeRect) + (CGRectGetWidth(badgeRect) - size.width) / 2,
                                             CGRectGetMinY(badgeRect) + (CGRectGetHeight(badgeRect) - size.height) / 2,
                                             size.width,
                                             size.height);
                [badgeValue drawInRect:textRect
                        withAttributes:self.badgeAttributes];
            }
                break;
                
            default:
                break;
        }
    }
}

- (CGFloat)badgePadding {
    return 3;
}

- (CGSize)defaultBadgeSize {
    return CGSizeMake(18, 18);
}

- (UIFont *)badgeFont {
    if (self.badgeAttributes && [self.badgeAttributes.allKeys containsObject:NSFontAttributeName]) {
        return [self.badgeAttributes objectForKey:NSFontAttributeName];
    }
    return [UIFont systemFontOfSize:14];
}

- (UIColor *)entityBackgroundColor {
    if ([self.backgroundColorStyleSheet.allKeys containsObject:@(self.currState)]) {
        return [self.backgroundColorStyleSheet objectForKey:@(self.currState)];
    } else if ([self.backgroundColorStyleSheet.allKeys containsObject:@(UIControlStateNormal)]) {
        return [self.backgroundColorStyleSheet objectForKey:@(UIControlStateNormal)];
    }
    return [UIColor clearColor];
}

- (UIImage *)entityImage {
    if ([self.imageStyleSheet.allKeys containsObject:@(self.currState)]) {
        NSString *image = [self.imageStyleSheet objectForKey:@(self.currState)];
        return [UIImage imageNamed:image];
    } else if ([self.imageStyleSheet.allKeys containsObject:@(UIControlStateNormal)]) {
        NSString *image = [self.imageStyleSheet objectForKey:@(UIControlStateNormal)];
        return [UIImage imageNamed:image];
    }
    return nil;
}

- (NSString *)entityText {
    if ([self.textStyleSheet.allKeys containsObject:@(self.currState)]) {
        return [self.textStyleSheet objectForKey:@(self.currState)];
    }
    return nil;
}

- (UIFont *)entityTextFont {
    return [[self entityAttributes] objectForKey:NSFontAttributeName];
}

- (NSDictionary *)entityAttributes {
    NSDictionary *styleSheet = [self.attributesStyleSheet objectForKey:@(self.currState)];
    if (styleSheet) {
        if ([styleSheet.allKeys containsObject:NSFontAttributeName]) {
            return styleSheet;
        }
        
        NSMutableDictionary *mudic = [[NSMutableDictionary alloc] initWithDictionary:styleSheet];
        [mudic setObject:[UIFont systemFontOfSize:12] forKey:NSFontAttributeName];
        return mudic;
    }
    return @{NSForegroundColorAttributeName : [UIColor blackColor],
             NSFontAttributeName : [UIFont systemFontOfSize:12]};
}

- (CGSize)strSizeWithFont:(CGFloat)font alsoMaxSize:(CGSize)maxSize alsoStr:(NSString *)str {
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    return [str boundingRectWithSize:maxSize
                             options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin
                          attributes:attribute
                             context:nil].size;
}

@end
