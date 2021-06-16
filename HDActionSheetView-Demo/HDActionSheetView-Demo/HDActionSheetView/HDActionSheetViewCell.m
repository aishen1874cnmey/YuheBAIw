//
//  HDActionSheetViewCell.m
//  浏览UIWebView里面的图片
//
//  Created by 赵国腾 on 16/5/13.
//  Copyright © 2016年 赵国腾. All rights reserved.
//

#import "HDActionSheetViewCell.h"

@interface HDActionSheetViewCell ()

/**  */
@property (nonatomic, strong) CAShapeLayer *oneLineLayer;

@end

@implementation HDActionSheetViewCell

+ (NSString *)cellIdentifier {
    return @"ActionSheetViewCell";
}

+ (CGFloat)cellHeight {
    return 44.0;
}

- (CAShapeLayer *)oneLineLayer {
    
    if (_oneLineLayer == nil) {
        _oneLineLayer = [CAShapeLayer layer];
        _oneLineLayer.lineWidth = 1.0 / [UIScreen mainScreen].scale;
        _oneLineLayer.strokeColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1.0].CGColor;
    }
    
    return _oneLineLayer;
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    [self.layer addSublayer:self.oneLineLayer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIBezierPath *bottomPath = [UIBezierPath bezierPath];
    [bottomPath moveToPoint:CGPointMake(0, 0)];
    [bottomPath addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds), 0)];
    self.oneLineLayer.path = bottomPath.CGPath;
    
}

@end
