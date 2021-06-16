//
//  HDActionSheetViewCell.h
//  浏览UIWebView里面的图片
//
//  Created by 赵国腾 on 16/5/13.
//  Copyright © 2016年 赵国腾. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HDActionSheetViewCell : UITableViewCell

/** 标题label */
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

+ (NSString *)cellIdentifier;

/** 单元格高度 */
+ (CGFloat)cellHeight;

@end