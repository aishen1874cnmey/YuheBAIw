//
//  HDActionSheetView.h
//  浏览UIWebView里面的图片
//
//  Created by 赵国腾 on 16/5/13.
//  Copyright © 2016年 赵国腾. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDActionSheetViewCell.h"

@protocol HDActionSheetViewDelegate;
@interface HDActionSheetView : UIView

@property (nonatomic, weak) id<HDActionSheetViewDelegate> delegate;

/** 数据 */
@property (nonatomic, strong) NSArray *dataList;

/** 取消按钮标题 */
@property (nonatomic, strong) NSString *cancelButtonTitle;

/** 创建视图 */
+ (HDActionSheetView *)actionSheetView;

/** 显示视图 */
- (void)showInView:(UIView *)view;

@end

@protocol HDActionSheetViewDelegate<NSObject>

- (void)hd_actionSheet:(HDActionSheetView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

@end