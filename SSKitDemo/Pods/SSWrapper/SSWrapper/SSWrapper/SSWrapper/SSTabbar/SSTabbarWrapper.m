//
//  SSTabbarWrapper.m
//  SSKit
//
//  Created by Quincy Yan on 16/8/28.
//  Copyright © 2016年 SSKit. All rights reserved.
//

#import "SSTabbarWrapper.h"
#import "NSString+SSTabbarWrapper.h"

static CGFloat const SSTW_BADGEVALUE_PADDING = 3;
static CGFloat const SSTW_BADGEVALUE_DEFAULT_SIZE = 18;

@interface SSTabbarWrapper()
@property (nonatomic,strong) NSMutableDictionary *imageStyleSheet;
@property (nonatomic,strong) NSMutableDictionary *textStyleSheet;
@property (nonatomic,strong) NSMutableDictionary *attributesStyleSheet;
@property (nonatomic,strong) NSMutableDictionary *backgroundColorStyleSheet;
@property (nonatomic) CGRect rectImage;
@property (nonatomic) CGRect rectText;
@property (nonatomic) NSInteger badgeValue;

@property (nonatomic) SSTabbarWrapperState wrapperState;

@end

@implementation SSTabbarWrapper

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    self.backgroundColor = [UIColor clearColor];
    
    _wrapperState = SSTabbarWrapperStateNormal;
    _imageStyleSheet = [[NSMutableDictionary alloc] init];
    _textStyleSheet = [[NSMutableDictionary alloc] init];
    _attributesStyleSheet = [[NSMutableDictionary alloc] init];
    _backgroundColorStyleSheet = [[NSMutableDictionary alloc] init];
    
    _rectImage = CGRectMake(0, 0, 25, 25);
    _badgeEdgeInsets = UIEdgeInsetsMake(5, 0, 0, 5);
    _badgeFillColor = [UIColor redColor];
    _badgeAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:14],
                             NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    return self;
}

- (void)resetCornerRadius:(CGFloat)cornerRadius forCorners:(UIRectCorner)corners {
    CGRect rect = CGRectMake(0, 0, _wrapperSize.width, _wrapperSize.height);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *mask = [CAShapeLayer layer];
    mask.frame = rect;
    mask.path = maskPath.CGPath;
    self.layer.mask = mask;
    self.clipsToBounds = YES;
}

- (void)resetWrapperBadgeValue:(NSInteger)badgeValue {
    if (badgeValue == _badgeValue) return;
    _badgeValue = badgeValue;
    [self setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected {
    if (selected && _wrapperState == SSTabbarWrapperStateSelected) return;
    if (!selected && _wrapperState == SSTabbarWrapperStateNormal) return;
    
    _wrapperState = selected ? SSTabbarWrapperStateSelected : SSTabbarWrapperStateNormal;
    
    [self setNeedsDisplay];
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    if (_wrapperState != SSTabbarWrapperStateSelected) {
        _wrapperState = SSTabbarWrapperStateHighlight;
        [self setNeedsDisplay];
    }
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    if (_wrapperState != SSTabbarWrapperStateSelected) {
        _wrapperState = SSTabbarWrapperStateNormal;
        [self setNeedsDisplay];
    }
}

- (void)setWrapperImage:(NSString *)image withText:(NSString *)text forControlState:(SSTabbarWrapperState)state {
    if (image) {
        [_imageStyleSheet setObject:image forKey:SSTabbarWrapperStateString(state)];
    }
    if (text) {
        [_textStyleSheet setObject:text forKey:SSTabbarWrapperStateString(state)];
    }
}

- (void)setWrapperTextAttributes:(NSDictionary *)attributes forControlState:(SSTabbarWrapperState)state {
    if (!attributes || attributes.allKeys.count == 0) return;
    [self.attributesStyleSheet setObject:attributes forKey:SSTabbarWrapperStateString(state)];
}

- (void)setWrapperBackgroundColor:(UIColor *)backgroundColor forControlState:(SSTabbarWrapperState)state {
    if (!backgroundColor) return;
    [self.backgroundColorStyleSheet setObject:backgroundColor forKey:SSTabbarWrapperStateString(state)];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGFloat w = CGRectGetWidth(self.frame);
    CGFloat h = CGRectGetHeight(self.frame);
    
    [[self wrapperDisplayBackgroundColor] setFill];
    UIRectFill(self.bounds);
    
    UIImage *image = [self wrapperDisplayImage];
    NSString *text = [self wrapperDisplayText];
    
    // 初始化
    _rectImage = CGRectMake(0, 0, 25, 25);
    
    if (!text && image) { // 只包含图片则居中全部显示
        if (CGSizeEqualToSize(CGSizeZero, _wrapperImageSize)) {
            _wrapperImageSize = image.size;
        }
        _rectImage = CGRectMake((w - _wrapperImageSize.width) / 2,
                                (h - _wrapperImageSize.height) / 2,
                                _wrapperImageSize.width,
                                _wrapperImageSize.height);
    } else { // 包含图片与文字
        _rectImage = CGRectMake((w - _rectImage.size.width) / 2,
                                5,
                                _rectImage.size.width,
                                _rectImage.size.height);
    }
    
    if (image) {
        [image drawInRect:_rectImage];
    }
    
    if (text) {
        NSDictionary *attributes = [self wrapperDisplayAttributes];
        
        CGSize size = [text sstw_stringSizeAttachFont:[attributes objectForKey:NSFontAttributeName] attachMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        [text drawInRect:CGRectMake((w - size.width) / 2,
                                    CGRectGetMaxY(_rectImage) + 1,
                                    size.width,
                                    size.height)
                withAttributes:attributes];
    }
    
    // 角标
    if (_badgeValue > 0) {
        NSString *badgeValue = [NSString stringWithFormat:@"%d",(int)_badgeValue];
        CGSize size = [badgeValue sstw_stringSizeAttachFont:[self wrapperBadgeFontValue] attachMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        CGSize badgeSize = size;
        
        if (CGSizeEqualToSize(_badgeSize, CGSizeZero)) {
            if (size.height + 2 * SSTW_BADGEVALUE_PADDING < SSTW_BADGEVALUE_DEFAULT_SIZE) {
                badgeSize.height = SSTW_BADGEVALUE_DEFAULT_SIZE;
            }
            
            if (size.width + 2 * SSTW_BADGEVALUE_PADDING < SSTW_BADGEVALUE_DEFAULT_SIZE) {
                badgeSize.width = SSTW_BADGEVALUE_DEFAULT_SIZE;
            }
            
            if (badgeSize.width < badgeSize.height) {
                badgeSize.width = badgeSize.height;
            }
            
            switch (_badgeType) {
                case SSTabbarBadgeTypeColor:{
                    badgeSize = CGSizeMake(10, 10);
                }
                    break;
                case SSTabbarBadgeTypeNumber:{
                    badgeSize = CGSizeMake(badgeSize.width + 2 * SSTW_BADGEVALUE_PADDING,
                                           badgeSize.height + 2 * SSTW_BADGEVALUE_PADDING);
                }
                    break;
                default:
                    break;
            }
        } else {
            badgeSize = _badgeSize;
        }
        
        CGRect badgeRect = CGRectMake(w - badgeSize.width - _badgeEdgeInsets.right,
                                      _badgeEdgeInsets.top,
                                      badgeSize.width,
                                      badgeSize.height);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, _badgeFillColor.CGColor);
        CGContextFillEllipseInRect(context, badgeRect);
        
        switch (_badgeType) {
            case SSTabbarBadgeTypeColor:{
                
            }
                break;
            case SSTabbarBadgeTypeNumber:{
                CGRect textRect = CGRectMake(CGRectGetMinX(badgeRect) + (CGRectGetWidth(badgeRect) - size.width) / 2,
                                             CGRectGetMinY(badgeRect) + (CGRectGetHeight(badgeRect) - size.height) / 2,
                                             size.width,
                                             size.height);
                [badgeValue drawInRect:textRect
                        withAttributes:_badgeAttributes];
            }
                break;
            default:
                break;
        }
    }
}

- (UIFont *)wrapperBadgeFontValue {
    if (self.badgeAttributes && [self.badgeAttributes.allKeys containsObject:NSFontAttributeName]) {
        return [self.badgeAttributes objectForKey:NSFontAttributeName];
    }
    return [UIFont systemFontOfSize:14];
}

- (UIColor *)wrapperDisplayBackgroundColor {
    if ([self.backgroundColorStyleSheet.allKeys containsObject:SSTabbarWrapperStateString(_wrapperState)]) {
        return [self.backgroundColorStyleSheet objectForKey:SSTabbarWrapperStateString(_wrapperState)];
    } else if ([self.backgroundColorStyleSheet.allKeys containsObject:SSTabbarWrapperStateString(SSTabbarWrapperStateNormal)]) {
        return [self.backgroundColorStyleSheet objectForKey:SSTabbarWrapperStateString(SSTabbarWrapperStateNormal)];
    }
    return [UIColor clearColor];
}

- (UIImage *)wrapperDisplayImage {
    if ([self.imageStyleSheet.allKeys containsObject:SSTabbarWrapperStateString(_wrapperState)]) {
        NSString *image = [self.imageStyleSheet objectForKey:SSTabbarWrapperStateString(_wrapperState)];
        return [UIImage imageNamed:image];
    } else if ([self.imageStyleSheet.allKeys containsObject:SSTabbarWrapperStateString(SSTabbarWrapperStateNormal)]) {
        NSString *image = [self.imageStyleSheet objectForKey:SSTabbarWrapperStateString(SSTabbarWrapperStateNormal)];
        return [UIImage imageNamed:image];
    }
    return nil;
}

- (NSString *)wrapperDisplayText {
    if ([self.textStyleSheet.allKeys containsObject:SSTabbarWrapperStateString(_wrapperState)]) {
        return [self.textStyleSheet objectForKey:SSTabbarWrapperStateString(_wrapperState)];
    }
    return nil;
}

- (NSDictionary *)wrapperDisplayAttributes {
    NSDictionary *styleSheet = [self.attributesStyleSheet objectForKey:SSTabbarWrapperStateString(_wrapperState)];
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

@end
