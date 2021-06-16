//
//  HDActionSheetView.m
//  浏览UIWebView里面的图片
//
//  Created by 赵国腾 on 16/5/13.
//  Copyright © 2016年 赵国腾. All rights reserved.
//

#import "HDActionSheetView.h"

const CGFloat kCancelButtonHeight = 44.0;
const CGFloat kSpaceHeight = 10.0;
const CGFloat kCellHeight = 44.0f;
const CGFloat kTopSpaceHeight = 84.0;

static NSMutableArray *kDidShowSheetViews;

@interface HDActionSheetView ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

/** 背景视图 */
@property (nonatomic, weak) IBOutlet UIView *bgView;

/** 表示图 */
@property (nonatomic, weak) IBOutlet UITableView *tableView;

/** 内容视图 */
@property (nonatomic, weak) IBOutlet UIView *contentView;

/** 按钮 */
@property (nonatomic, weak) IBOutlet UIButton *cancelButton;

/** 表视图高度 */
@property (nonatomic, assign) CGFloat tableViewHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;

@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *contentViewConstraints;

@end

@implementation HDActionSheetView

+ (void)initialize {
    kDidShowSheetViews = [NSMutableArray array];
    NSLog(@"+ (void)initialize");

}

+ (HDActionSheetView *)actionSheetView {
    
    if (kDidShowSheetViews.count > 0) return nil;

    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([HDActionSheetView class]) owner:nil options:nil].firstObject;
}

- (void)awakeFromNib {
        
    [self.tableView registerNib:[UINib nibWithNibName:@"HDActionSheetViewCell" bundle:nil] forCellReuseIdentifier:[HDActionSheetViewCell cellIdentifier]];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAction:)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
    self.tableView.delegate = self;
}

/** 显示视图 */
- (void)showInView:(UIView *)view {
    
    // 添加视图到父视图上面
    self.frame = view.bounds;
    [view addSubview:self];
    
    // 做动画
    [self startAnimation];
    
    // 记录当前已经显示的
    [kDidShowSheetViews addObject:self];
}

/** 做动画 */
- (void)startAnimation {
    
    self.contentViewHeight.constant = self.tableViewHeight + kSpaceHeight + kCancelButtonHeight;
    [self layoutIfNeeded];

    CGRect tempRect = self.contentView.frame;
    
    CGRect rect = tempRect;
    rect.origin.y += rect.size.height;
    self.contentView.frame = rect;
    
    self.bgView.alpha = 0.0;
    
    [UIView animateWithDuration:0.15
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.bgView.alpha = 0.6;
                     } completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:0.15
                                               delay:0.0
                                             options:UIViewAnimationOptionCurveEaseInOut
                                          animations:^{
                                              
                                              self.contentView.frame = tempRect;
                                          } completion:NULL];
                     }];
}

- (void)setDataList:(NSArray *)dataList {
    
    _dataList = dataList;
    
    // 表视图高度计算，表视图最高不能超过屏幕
    CGFloat maxHeight = CGRectGetHeight([UIScreen mainScreen].bounds) - kSpaceHeight - kCancelButtonHeight - kTopSpaceHeight;
    
    CGFloat limitHeight = MIN(maxHeight, dataList.count * kCellHeight);
    
    if (maxHeight < dataList.count * kCellHeight) {
        self.tableView.scrollEnabled = YES;
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataList.count - 1 inSection:0]
                              atScrollPosition:UITableViewScrollPositionBottom
                                      animated:NO];
    }
    
    self.tableViewHeight = limitHeight;
    
    [self.tableView reloadData];
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [HDActionSheetViewCell cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HDActionSheetViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[HDActionSheetViewCell cellIdentifier]];
    
    cell.titleLabel.text = self.dataList[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self endAnimation];
    
    if ([self.delegate respondsToSelector:@selector(hd_actionSheet:clickedButtonAtIndex:)]) {
        
        NSInteger clickIndex = self.dataList.count - indexPath.row;
        [self.delegate hd_actionSheet:self clickedButtonAtIndex:clickIndex];
    }
}

#pragma mark - 取消 
- (IBAction)cancelClick:(UIButton *)sender {
    
    [self endAnimation];
    
    if ([self.delegate respondsToSelector:@selector(hd_actionSheet:clickedButtonAtIndex:)]) {
        
        [self.delegate hd_actionSheet:self clickedButtonAtIndex:0];
    }
}

// 移除视图
- (void)endAnimation {
    
    CGRect rect = self.contentView.frame;
    rect.origin.y += rect.size.height;
    
    [UIView animateWithDuration:0.15
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         self.contentView.frame = rect;
                     } completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:0.15
                                               delay:0.0
                                             options:UIViewAnimationOptionCurveEaseInOut
                                          animations:^{
                                              self.bgView.alpha = 0.0;
                                          } completion:^(BOOL finished) {
                                              [self removeFromSuperview];
                                              
                                              if ([kDidShowSheetViews containsObject:self]) {
                                                  [kDidShowSheetViews removeObject:self];
                                              }
                                              
                                          }];
                     }];

}

#pragma mark - 属性设置
- (void)setCancelButtonTitle:(NSString *)cancelButtonTitle {
    
    _cancelButtonTitle = cancelButtonTitle;
    [self.cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
}

- (void)gestureAction:(UITapGestureRecognizer *)gesture {
    
    CGPoint point = [gesture locationInView:self.contentView];
    
    if (CGRectContainsPoint(self.contentView.bounds, point)) {
        
        NSLog(@"在contentView内");
    }
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        [self endAnimation];
    }
}

#pragma mark - UIGestureRecognizerDelegate

// 解决单元格点击与view点击冲突问题
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}


@end



















