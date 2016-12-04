//
//  DeepShallowCopyViewController.m
//  KSLDemo
//
//  Created by senlink on 2016/12/4.
//  Copyright © 2016年 GePingTech. All rights reserved.
//

#import "DeepShallowCopyViewController.h"
#import "KSLUser.h"

@interface DeepShallowCopyViewController ()

@end

@implementation DeepShallowCopyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"CopyView";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setupSubviews];
}

- (void)setupSubviews
{
    [self copy1];
    [self copy2];
    [self copy3];
}

- (void)copy1
{
    NSString *str1 = [NSString stringWithFormat:@"01"];
    NSString *str2 = [NSString stringWithFormat:@"02"];
    NSArray *array1 = [NSArray arrayWithObjects:str1,str2, nil];
    NSArray *array2 = [array1 copy];
    NSArray *array3 = [[NSArray alloc] initWithArray:array1 copyItems:YES];
    
    
    for (int i = 0; i < [array1 count]; i++)
    {
        NSLog(@"%p",array1[i]);
        NSLog(@"%p",array2[i]);
        NSLog(@"%p",array3[i]);
        NSLog(@"---------------");
    }
}

- (void)copy2
{
    NSMutableString *str1 = [NSMutableString stringWithFormat:@"01"];
    NSString *str2 = [NSString stringWithFormat:@"02"];
    NSArray *array1 = [NSArray arrayWithObjects:str1,str2, nil];
    NSArray *array2 = [array1 copy];
    NSArray *array3 = [[NSArray alloc] initWithArray:array1 copyItems:YES];
    
    
    for (int i = 0; i < [array1 count]; i++)
    {
        NSLog(@"%p",array1[i]);
        NSLog(@"%p",array2[i]);
        NSLog(@"%p",array3[i]);
        NSLog(@"---------------");
    }
}

- (void)copy3
{
    KSLUser *user = [[KSLUser alloc] init];
    user.profile_image_url = @"01";
    user.vip = NO;
    user.name = @"01";
    user.mbtype = 1;
    user.mbrank = 1;
    NSArray *array1 = [NSArray arrayWithObject:user];
    NSArray *array2 = [array1 copy];
    NSMutableArray *array3 = [NSMutableArray arrayWithArray:array1];
    NSArray *array4 = [[NSArray alloc] initWithArray:array1 copyItems:YES];
    
    /*
     数据本身地址变化
    (lldb) p array1
    (__NSSingleObjectArrayI *) $1 = 0x000060000000b9f0 @"1 element"
    (lldb) p array2
    (__NSSingleObjectArrayI *) $2 = 0x000060000000b9f0 @"1 element"
    (lldb) p array3
    (__NSArrayM *) $3 = 0x00006000002408a0 @"1 element"
    (lldb) p array4
    (__NSSingleObjectArrayI *) $4 = 0x000060000000b8e0 @"1 element"
     */

    /*
     * 数据内容地址变化
     2016-12-04 17:57:09.943 KSLDemo[1382:115289] p array1:(
     "<KSLUser: 0x60800005e240>"
     )
     2016-12-04 17:57:09.943 KSLDemo[1382:115289] p array2:(
     "<KSLUser: 0x60800005e240>"
     )
     2016-12-04 17:57:09.943 KSLDemo[1382:115289] p array3:(
     "<KSLUser: 0x60800005e240>"
     )
     2016-12-04 17:57:09.944 KSLDemo[1382:115289] p array4:(
     "<KSLUser: 0x60800005d910>"
     )
     */
    
    NSLog(@"p array1:%@",array1);
    NSLog(@"p array2:%@",array2);
    NSLog(@"p array3:%@",array3);
    NSLog(@"p array4:%@",array4);
    
    KSLUser *user2 = [array2 objectAtIndex:0];
    KSLUser *user3 = [array3 objectAtIndex:0];
    KSLUser *user4 = [array4 objectAtIndex:0];
    user3.profile_image_url = @"http://www.baidu.com";
    
    NSLog(@"p user.name %p",user3.name);
    NSLog(@"p user.name %p",user4.name);
    
    NSLog(@"%@",user3.profile_image_url);
    NSLog(@"%@",user4.profile_image_url);
    NSLog(@"%@",user2.profile_image_url);
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
