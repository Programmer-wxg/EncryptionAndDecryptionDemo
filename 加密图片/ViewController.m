//
//  ViewController.m
//  加密图片
//
//  Created by admin on 2018/11/7.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewController.h"

#define PASSWORD1 @"123"

@interface ViewController ()
@property (nonatomic,strong) UIImageView *imageview;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"加密" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(10, 100, 100, 100);
    button.backgroundColor = [UIColor blueColor];
    [self.view addSubview:button];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitle:@"解密" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(imageInSnView) forControlEvents:UIControlEventTouchUpInside];
    button1.frame = CGRectMake(130, 100, 100, 100);
    button1.backgroundColor = [UIColor blueColor];
    [self.view addSubview:button1];
    
    self.imageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 225, [UIScreen mainScreen].bounds.size.width-20, 300)];
    self.imageview.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.imageview];
}

- (void)save{
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSArray *array = [manager contentsOfDirectoryAtPath:@"/Users/admin/Desktop/加密图片demo 2/加密图片/JYSDKResource" error:nil];

    NSData* data = [PASSWORD1 dataUsingEncoding:NSUTF8StringEncoding];

    for (int i = 0; i < array.count; i++) {

        NSMutableData *sn = [[NSMutableData alloc] init];

        NSString *docName = array[i];

        //由于打包进bundle中加密图片格式会出现错误，所以需要将.png去掉
        NSArray *array1 = [docName componentsSeparatedByString:@".png"];
        
        NSString *newdocName = array1[0];

        NSMutableData *imageData = [NSMutableData dataWithContentsOfFile:[NSString stringWithFormat:@"/Users/admin/Desktop/加密图片demo 2/加密图片/JYSDKResource/%@",docName]];
        
        [sn appendData:data];
        [sn appendData:imageData];
        
        [sn writeToFile:[NSString stringWithFormat:@"/Users/admin/Desktop/加密图片demo 2/加密图片/秘密/%@",newdocName] atomically:YES];
    }
}

-(void)imageInSnView{
    
    NSData *imageData = [NSData dataWithContentsOfFile:@"/Users/admin/Desktop/加密图片demo 2/加密图片/秘密/59c0a6f24df7d" ];
    
    //密码文件
    NSData *sn = [PASSWORD1 dataUsingEncoding:NSUTF8StringEncoding];
    
    NSUInteger pre = sn.length;
    NSUInteger total = imageData.length;
    NSRange range = {pre,total-pre};
    //除去加密文件
    NSData *imData = [imageData subdataWithRange:range];
    
    UIImage *image = [[UIImage alloc]initWithData:imData];
    
    self.imageview.image = image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
