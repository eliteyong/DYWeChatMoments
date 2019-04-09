//
//  DYHomeViewController.m
//  DYWeChatMoments
//
//  Created by admin on 2018/4/9.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYHomeViewController.h"
#import "DYHomeCell.h"
#import <objc/runtime.h>

@interface DYHomeViewController () <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *titles;

@end

@implementation DYHomeViewController
//   FIXME:此处有错误待修复
//   TODO:此处有问题未处理完成
//   XXX:1111

- (void)viewDidLoad {
//    self.navigationItem.titleView
    [super viewDidLoad];
    self.titles = @[@"DYSheetView",@"",@"",@""];
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(0);
        if (@available(iOS 11, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuide);
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
        }
    }];
    
}


- (void)performAndDispatch {
    NSLog(@"---------");;
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 2);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        NSLog(@"11111");
    });
    
    
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(test3) userInfo:nil repeats:NO];
    
    [self performSelector:@selector(test1) withObject:nil afterDelay:2.0];
    
    //    dispatch_queue_t serialQueue = dispatch_queue_create("12312312", DISPATCH_QUEUE_CONCURRENT);
    //
    //    dispatch_async(serialQueue, ^{
    //        @autoreleasepool {
    //            [NSThread currentThread].name = @"自定义线程名字";
    //            NSRunLoop * runloop = [NSRunLoop currentRunLoop];
    //            [runloop addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    //            [self performSelector:@selector(test1) withObject:nil afterDelay:2.0];
    //
    //            [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(test3) userInfo:nil repeats:NO];
    //            [runloop run];
    //
    //        }
    //
    //
    //    });
    [self performSelector:@selector(test2)];
}
-(void)test1{
    NSLog(@"----1-----%@", [NSThread currentThread]);
}
-(void)test2{
    NSLog(@"----2-----%@", [NSThread currentThread]);
}
-(void)test3{
    NSLog(@"----5-----%@", [NSThread currentThread]);
}
/**
 dispatch的使用
 */
- (void)dispatch_test {
    //串行队列 创建
    dispatch_queue_t queueSerial = dispatch_queue_create("com.dayong.testSerial", DISPATCH_QUEUE_SERIAL);
    //并发队列 创建
    dispatch_queue_t queueConcurrent = dispatch_queue_create("com.dayong.testConcurrent", DISPATCH_QUEUE_CONCURRENT);
    //得到主队列 特殊的串行队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    //得到全局并发队列
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //同步执行任务创建
    dispatch_sync(queueSerial, ^{
        
    });
    //异步执行任务创建
    dispatch_async(queueSerial, ^{
        
    });
}


/**
 串行队列同步执行
 */
- (void)serialQueueSync {
    
    NSLog(@"currentThread---%@",[NSThread currentThread]); //打印当前线程
    NSLog(@"___begin");
    //创建串行队列
    dispatch_queue_t serialQueue = dispatch_queue_create("serialQueue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(serialQueue, ^{
        NSLog(@"1---%@",[NSThread currentThread]);
    });
    
    dispatch_sync(serialQueue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"2---%@",[NSThread currentThread]);
    });
    dispatch_async(serialQueue, ^{
        
        NSLog(@"3---%@",[NSThread currentThread]);
    });
    
    NSLog(@"s___end");
    
}
/**
 并发队列同步执行
 */
- (void)concurrentQueueSync {
    NSLog(@"currentThread---%@",[NSThread currentThread]);
    NSLog(@"concurrentQueueSync___begin");
    
    dispatch_queue_t concurrentQueue = dispatch_queue_create("concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(concurrentQueue, ^{
        NSLog(@"1---%@",[NSThread currentThread]);
    });
    dispatch_async(concurrentQueue, ^{
        
        NSLog(@"2---%@",[NSThread currentThread]);
    });
    dispatch_sync(concurrentQueue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"3---%@",[NSThread currentThread]);
    });
//    dispatch_sync(concurrentQueue, ^{
//        for (NSInteger i = 0; i < 2; i ++) {
//            [NSThread sleepForTimeInterval:2];
//            NSLog(@"2---%@",[NSThread currentThread]);
//        }
//    });
    
    NSLog(@"concurrentQueueSync___end");
}
/**
 串行队列异步
 */
- (void)serailQueueAsync {
    NSLog(@"currentThread---%@",[NSThread currentThread]);
    NSLog(@"serialQueueAsync___begin");
    
    dispatch_queue_t serialQueue = dispatch_queue_create("com.dayong.testConcurrent", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(serialQueue, ^{
        NSLog(@"1---%@",[NSThread currentThread]);
    });
    dispatch_async(serialQueue, ^{
        for (NSInteger i = 0; i < 2; i ++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2---%@",[NSThread currentThread]);
        }
    });
    NSLog(@"serialQueueAsync___end");
    
}

/**
 并发队列异步执行
 */
- (void)concurrentQueueAsync {
    
    NSLog(@"currentThread---%@",[NSThread currentThread]);
    NSLog(@"concurrentQueueSync___begin");
    
    dispatch_queue_t concurrentQueue = dispatch_queue_create("concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(concurrentQueue, ^{
        NSLog(@"1---%@",[NSThread currentThread]);
    });
    dispatch_async(concurrentQueue, ^{
        for (NSInteger i = 0; i < 2; i ++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2---%@",[NSThread currentThread]);
        }
    });
    
    NSLog(@"concurrentQueueSync___end");
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titles.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, DYScreenWidth, 20)];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return DYAlmostZero;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DYHomeCell *cell = [DYHomeCell dy_homeCellForTableView:tableView];
    cell.name = self.titles[indexPath.section];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
