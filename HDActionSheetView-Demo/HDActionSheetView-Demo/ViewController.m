//
//  ViewController.m
//  HDActionSheetView-Demo
//
//  Created by 赵国腾 on 16/5/16.
//  Copyright © 2016年 赵国腾. All rights reserved.
//

#import "ViewController.h"
#import "HDActionSheetView.h"

@interface ViewController ()<HDActionSheetViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClick:(UIButton *)sender {
    
    HDActionSheetView *actionSheetView = [HDActionSheetView actionSheetView];
    actionSheetView.delegate = self;
    
    NSMutableArray *mutaArr = [NSMutableArray array];
    for (NSInteger i = 0; i < sender.tag; i++) {
        [mutaArr addObject:[NSString stringWithFormat:@"保存-%zd", i]];
    }
    
    actionSheetView.dataList = mutaArr;
    [actionSheetView showInView:self.view];
}

#pragma mark - <HDActionSheetViewDelegate>
- (void)hd_actionSheet:(HDActionSheetView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSLog(@"buttonIndex: %zd", buttonIndex);
}

@end
