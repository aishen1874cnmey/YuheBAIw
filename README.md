#HDActionSheetView

高仿微信底部弹出视图

###代码使用
```
            HDActionSheetView *actionSheetView = [HDActionSheetView actionSheetView];
            actionSheetView.delegate = self;
            actionSheetView.dataList = @[@"保存图片"];
            actionSheetView.cancelButtonTitle = @"关闭";
            [actionSheetView showInView:self.view];

```
###代理方法
```
- (void)hd_actionSheet:(HDActionSheetView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
}

```

![](zm223333.gif)