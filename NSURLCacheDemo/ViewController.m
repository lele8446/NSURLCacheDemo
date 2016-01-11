//
//  ViewController.m
//  NSURLCacheDemo
//
//  Created by C.K.Lian on 16/1/8.
//  Copyright © 2016年 C.K.Lian. All rights reserved.
//

#import "ViewController.h"
#import "CJHttpClient.h"

/*阿里云根据地区名获取经纬度接口
 *http://gc.ditu.aliyun.com/geocoding?a=北京市
 */
#define GETURL @"http://gc.ditu.aliyun.com/geocoding"

@interface ViewController ()
@property(nonatomic, weak)IBOutlet UILabel *label;
@end

@implementation ViewController

- (void)dealloc
{
    NSLog(@"ViewController dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.label.text = @"经纬度";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getAsyncUrl:(id)sender
{
    __weak __typeof(self) wSelf = self;
    self.label.text = @"经纬度";
    NSLog(@"开始get请求");
    [CJHttpClient getUrl:GETURL parameters:@{@"a":@"北京市"} timeoutInterval:HTTP_DEFAULT_TIMEOUT cachPolicy:CJRequestReturnCacheDataElseLoad completionHandler:^(NSData *data, NSURLResponse *response){
        NSError *error;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        NSLog(@"请求结果 dic %@",dic);
        [wSelf setLabelTitle:dic];
    }errorHandler:^(NSError *error){
        NSLog(@"error %@",error);
    }];
    NSLog(@"next");
}

- (IBAction)postUrl:(id)sender
{
    __weak __typeof(self) wSelf = self;
    self.label.text = @"经纬度";
    NSLog(@"开始post请求");
    [CJHttpClient postUrl:GETURL parameters:@{@"a":@"北京市"} timeoutInterval:HTTP_DEFAULT_TIMEOUT completionHandler:^(NSData *data, NSURLResponse *response){
        NSError *error;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        NSLog(@"请求结果 dic %@",dic);
        [wSelf setLabelTitle:dic];
    }errorHandler:^(NSError *error){
        NSLog(@"error %@",error);
    }];
    NSLog(@"next");
}

- (IBAction)clearCache:(id)sender
{
    [CJHttpClient removeAllCachedResponses];
}

- (void)setLabelTitle:(NSDictionary *)dic
{
    self.label.text = [NSString stringWithFormat:@"经度%@\n纬度%@",dic[@"lon"],dic[@"lat"]];
}

@end
