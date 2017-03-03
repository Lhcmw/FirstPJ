//
//  ViewController.m
//  TestLaunch
//
//  Created by 石田雨 on 17/1/9.
//  Copyright © 2017年 anlaxy. All rights reserved.
//

#import "ViewController.h"
#import <MBProgressHUD.h>
#import "HttpManager.h"
#import <UIImageView+WebCache.h>

@interface ViewController ()<MBProgressHUDDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self session];
//    [self bookA];
//    [self sd_img];
    [self TestKvo];
}

-(void)http{
    [HttpManager getSystemDateTime:^(id response) {
        if (response) {
            NSLog(@"%@",response);
        }
    } failure:^(NSError *err) {
        NSLog(@"%@",err);
    }];
}

#pragma mark - MBProgressHUD
-(void)MB{
    MBProgressHUD *hud;
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.delegate = self;
    hud.backgroundColor = [UIColor clearColor];
    hud.labelText = @"Test";
    hud.detailsLabelText = @"Test detail";
    hud.dimBackground = YES;
    hud.mode = MBProgressHUDModeDeterminate;
    [hud hideAnimated:YES afterDelay:2];

}

#pragma mark - NSURLSession
-(void)session{
    
    //1.get请求
    //快捷方式获得session对象
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
//    //通url初始化task，在block内部可以直接对返回的数据进行处理
//    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSLog(@"%@",[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]);
//    }];
//    //启动任务
//    [task resume];
    
    //POST和GET的区别就在于request,所以使用session的POST请求和GET过程是一样的,区别就在于对request的处理.
    
    //2.post请求
    //快捷方式获得session对象
    
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [@"username=daka&pwd=123" dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSession *session = [NSURLSession sharedSession];
    
    //通url初始化task，在block内部可以直接对返回的数据进行处理
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@", [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]);
    }];
    //启动任务
    [task resume];
}

-(void)bookA{
    NSMutableArray *books = [@[@"book1"] mutableCopy];
    self.bookArray1 = books;
    self.bookArray2 = books;
    [books addObject:@"book2"];
    NSLog(@"bookArray1:%@",self.bookArray1);
    NSLog(@"bookArray2:%@",self.bookArray2);
}

-(void)sd_img{

    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 50, 50)];
    NSURL *urlStr = [NSURL URLWithString:@"https://image.baidu.com/search/detail?ct=503316480&z=0&ipn=d&word=雪花&hs=2&pn=0&spn=0&di=118439889040&pi=0&rn=1&tn=baiduimagedetail&is=0%2C0&ie=utf-8&oe=utf-8&cl=2&lm=-1&cs=721200671%2C2704490197&os=2565891970%2C376661880&simid=59620478%2C1068181864&adpicid=0&lpn=0&ln=30&fr=ala&fm=&sme=&cg=&bdtype=0&oriquery=雪花&objurl=http%3A%2F%2Fpic.58pic.com%2F58pic%2F12%2F02%2F44%2F30H58PICbQV.jpg&fromurl=ippr_z2C%24qAzdH3FAzdH3Fooo_z%26e3Bcbrtv_z%26e3Bv54AzdH3F3tj6tAzdH3F8dad99na_z%26e3Bip4s&gsm=0"];
//    [imgV sd_setImageWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    [imgV sd_setImageWithURL:urlStr placeholderImage:nil options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        NSLog(@"%ld",(long)receivedSize);
        NSLog(@"%ld",(long)expectedSize);
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    [self.view addSubview:imgV];
}

-(void)TestKvo{
    [self setValue:@"10.0" forKey:@"price"];
    [self addObserver:self forKeyPath:@"price" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"price"])
    {
//        myLabel.text = [stockForKVO valueForKey:@"price"];
        self.view.backgroundColor = [UIColor redColor];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self setValue:@"9.0" forKey:@"price"];
}
@end
