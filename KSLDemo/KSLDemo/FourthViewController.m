//
//  FourthViewController.m
//  KSLDemo
//
//  Created by senlink on 2016/11/27.
//  Copyright © 2016年 GePingTech. All rights reserved.
//

#import "FourthViewController.h"
#import "Quartz2dView.h"
#import "KSLStatus.h"
#import "KSLUser.h"
#import "NSObject+KSLModel.h"

@interface FourthViewController ()

@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"FourthView";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
    
    [self setupSubviews];
    
}

- (void)setupSubviews
{
    CGRect rect = [[UIScreen mainScreen] bounds];
    Quartz2dView *view = [[Quartz2dView alloc] initWithFrame:CGRectMake(0, 64 + 10, rect.size.width, rect.size.height - 64 -10)];
    [view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:view];
    [view setNeedsDisplay];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSArray *status = [self statusFromFile];
    for (KSLStatus *aStatus in status) {
        KSLUser *aUser = aStatus.user;
        [aUser insertToDatabase];
    }
}

- (NSArray *)statusFromFile
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"status.plist" ofType:nil];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSArray *dictArr = dict[@"statuses"];
    
    NSMutableArray *statuses = [NSMutableArray array];
    // 遍历字典数组
    for (NSDictionary *dict in dictArr) {
        KSLStatus *status = [KSLStatus modelWithDict:dict];
        [statuses addObject:status];
    }
    return statuses;
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
