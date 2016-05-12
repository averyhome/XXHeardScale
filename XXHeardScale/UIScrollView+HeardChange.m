//
//  UITableView+HeardChange.m
//  渐变导航栏
//
//  Created by 朱小亮 on 16/5/10.
//  Copyright © 2016年 archerLj. All rights reserved.
//

#import "UIScrollView+HeardChange.h"
#import <objc/runtime.h>
#import <Foundation/Foundation.h>


static NSString *const heardKey = @"heardKey";
static NSString *const edgeTopKey = @"edgeTopKey";
static NSString *const heardBaseFrameKey = @"heardBaseFrameKey";
static NSString *const scalingKey = @"scalingKey";
static NSString *const isScalKey = @"isScalKey";


@implementation UIScrollView (HeardChange)


- (void)xx_setScalkHeardViewWithheardView:(UIView *)heardView isScal:(BOOL)isScal{
    [self xx_setScalkHeardViewWithheardView:heardView edgeTop:0 isScal:isScal];
}

- (void)xx_setScalkHeardViewWithheardView:(UIView *)heardView edgeTop:(CGFloat)edgeTop isScal:(BOOL)isScal{
    
    [self xx_setScalkHeardViewWithheardView:heardView edgeTop:edgeTop isScal:isScal scal:nil];
}

- (void)xx_setScalkHeardViewWithheardView:(UIView *)heardView edgeTop:(CGFloat)edgeTop isScal:(BOOL)isScal scal:(ScalBlock)block{
    
    if (edgeTop<=0||!edgeTop||edgeTop>heardView.frame.size.height) {
        edgeTop = heardView.frame.size.height;
    }
    
    [self setIsScal:[NSNumber numberWithBool:isScal]];
    
    
    
    [self setHeardView:heardView];
    [self setEdgeTop:[NSNumber numberWithFloat:edgeTop]];
    
    self.contentInset = UIEdgeInsetsMake(edgeTop, 0, 0, 0);
    CGRect frame = heardView.frame;
    frame.origin.x = 0;
    frame.origin.y = -edgeTop;
    heardView.frame = frame;
    [self insertSubview:heardView atIndex:0];
    
    [self setHeardBaseFrame:[NSValue valueWithCGRect:frame]];
    
    if (block) {
        [self setScalBlock:block];

    }
    [self observeContentOffset];
}





- (void)observeContentOffset{
    [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        
        if (![[self isScal] boolValue]) {
            return;
        }
        
        id  x = [change objectForKey:@"new"];
        CGPoint point = [x CGPointValue];
        CGFloat offsetY = point.y;
       
        if ((offsetY+[[self edgeTop] floatValue])<0) {
            
            CGRect beforFrame = [[self heardBaseFrame] CGRectValue];
           
            //思路 根据比例变大后 上下左右都要有相同的距离变化才不至于别扭
            
            CGFloat addHeight = ABS((offsetY+[[self edgeTop] floatValue]))*2;
            CGFloat addWidth = addHeight/beforFrame.size.height*beforFrame.size.width;
            
            float ggX = addHeight/beforFrame.size.height;
            float ggY = addWidth/beforFrame.size.width;
            [self heardView].transform = CGAffineTransformMakeScale(ggX+1, ggY+1);
            
            CGRect nowFrame = [self heardView].frame;
            nowFrame.origin.y=offsetY-addHeight/2;
            nowFrame.origin.x=-addWidth/2;
            [self heardView].frame = nowFrame;
            
            if ([self scalBlock]) {
                 [self scalBlock](ggY/2);
            }
        }
        else{
            [self heardView].transform = CGAffineTransformIdentity;
            CGRect beforFrame = [[self heardBaseFrame] CGRectValue];
 
            CGFloat addHeight = ABS((offsetY+[[self edgeTop] floatValue]));
            float gg = -addHeight/beforFrame.size.height;
            if ([self scalBlock]) {
                [self scalBlock](gg);
            }
        }
    }
}



//头部视图
- (UIView *)heardView
{
    return objc_getAssociatedObject(self,&heardKey);
}

- (void)setHeardView:(UIView *)heardView
{
    objc_setAssociatedObject(self, &heardKey,heardView, OBJC_ASSOCIATION_RETAIN);
}

//edgtop的距离
- (NSNumber *)edgeTop{
    return objc_getAssociatedObject(self,&edgeTopKey);
}

- (void)setEdgeTop:(NSNumber *)edgeTop
{
    objc_setAssociatedObject(self, &edgeTopKey,edgeTop, OBJC_ASSOCIATION_RETAIN);
}


//heardView的原始frame
- (NSValue *)heardBaseFrame
{
    return objc_getAssociatedObject(self,&heardBaseFrameKey);
}

- (void)setHeardBaseFrame:(NSValue *)frame
{
    objc_setAssociatedObject(self, &heardBaseFrameKey,frame, OBJC_ASSOCIATION_RETAIN);
}

//isScal
- (NSNumber *)isScal{
    return objc_getAssociatedObject(self, &isScalKey);
}

- (void)setIsScal:(NSNumber *)isScal{
    objc_setAssociatedObject(self, &isScalKey, isScal, OBJC_ASSOCIATION_RETAIN);
}


//回调scaling
- (ScalBlock)scalBlock{
    return objc_getAssociatedObject(self,&scalingKey);
}

- (void)setScalBlock:(ScalBlock)blcok{
    objc_setAssociatedObject(self, &scalingKey, blcok, OBJC_ASSOCIATION_RETAIN);
}
@end
