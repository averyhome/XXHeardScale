//
//  UITableView+HeardChange.h
//  渐变导航栏
//
//  Created by 朱小亮 on 16/5/10.
//  Copyright © 2016年 archerLj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void (^ScalBlock)(float scal);

@interface UIScrollView (HeardChange)


#pragma mark  设置scrollView的背景  通用 scrollView tableView collectionView
- (void)xx_setScalkHeardViewWithheardView:(UIView *)heardView isScal:(BOOL)isScal;

- (void)xx_setScalkHeardViewWithheardView:(UIView *)heardView edgeTop:(CGFloat)edgeTop isScal:(BOOL)isScal;

- (void)xx_setScalkHeardViewWithheardView:(UIView *)heardView edgeTop:(CGFloat)edgeTop isScal:(BOOL)isScal scal:(ScalBlock)block;

@end
