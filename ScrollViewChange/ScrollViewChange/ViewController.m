//
//  ViewController.m
//  ScrollViewChange
//
//  Created by 朱小亮 on 16/5/10.
//  Copyright © 2016年 zhusven. All rights reserved.
//

#import "ViewController.h"
#import "XXHeardChange.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)UITableView *tableView;

@end

static CGFloat const heardH = 500;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setAutomaticallyAdjustsScrollViewInsets:YES];
    [self.view addSubview:self.tableView];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    UIView *heardView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, heardH)];
    UIImage *image = [UIImage imageNamed:@"test.jpeg"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.frame = heardView.frame;
    imageView.center = heardView.center;
    [heardView addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 60)];
    label.text = @"demo";

    label.center = heardView.center;
    label.textAlignment = NSTextAlignmentCenter;
    [heardView addSubview:label];
    
    self.title = @"Demo";
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [_tableView xx_setScalkHeardViewWithheardView:heardView edgeTop:300 isScal:YES scal:^(float scal) {
//        
        float alpha = 1-ABS(scal);
//
//        NSLog(@"alpha = %f",alpha);
//        
//        if (alpha <= 0.6) {
//            _tableView.contentInset = UIEdgeInsetsMake(300, 0, 0, 0);
//        }
//        else if(alpha >=0.8){
//            _tableView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
//        }
        
    

        
        self.navigationController.navigationBar.alpha = alpha;
//        if (scal<=-1) {
//            self.navigationController.navigationBar.hidden = YES;
//        }
//        else
//        {
//            self.navigationController.navigationBar.hidden = NO;
//
//        }
    }];
    
}



- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:0];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sdfasdf"];
    [cell setBackgroundColor:[UIColor redColor]];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

}



@end
