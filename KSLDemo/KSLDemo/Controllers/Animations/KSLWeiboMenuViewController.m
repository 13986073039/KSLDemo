//
//  KSLWeiboMenuViewController.m
//  KSLDemo
//
//  Created by 孔森林 on 2017/1/2.
//  Copyright © 2017年 GePingTech. All rights reserved.
//

#import "KSLWeiboMenuViewController.h"
#import "KSLComponentViewController.h"
#import "KSLMenuItem.h"

@interface KSLWeiboMenuViewController ()

@end

@implementation KSLWeiboMenuViewController

- (IBAction)btnClick:(id)sender {
    
    KSLComponentViewController *vc = [[KSLComponentViewController alloc] init];
    
    KSLMenuItem *item0 = [KSLMenuItem itemWithTitle:@"点评" image:[UIImage imageNamed:@"tabbar_compose_review"]];
    KSLMenuItem *item1 = [KSLMenuItem itemWithTitle:@"更多" image:[UIImage imageNamed:@"tabbar_compose_more"]];
    KSLMenuItem *item2 = [KSLMenuItem itemWithTitle:@"拍摄" image:[UIImage imageNamed:@"tabbar_compose_camera"]];
    KSLMenuItem *item3 = [KSLMenuItem itemWithTitle:@"相册" image:[UIImage imageNamed:@"tabbar_compose_photo"]];
    KSLMenuItem *item4 = [KSLMenuItem itemWithTitle:@"文字" image:[UIImage imageNamed:@"tabbar_compose_idea"]];
    KSLMenuItem *item5 = [KSLMenuItem itemWithTitle:@"签到" image:[UIImage imageNamed:@"tabbar_compose_review"]];
    
    
    vc.itemArray = @[item0,item1,item2,item3,item4,item5];
    
    
    [self presentViewController:vc animated:YES completion:nil];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self btnClick:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
