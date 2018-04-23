//
//  DYMomentsFirstViewController.m
//  DYWeChatMoments
//
//  Created by admin on 2018/4/18.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYMomentsFirstViewController.h"
#import "DYMoment1Cell.h"
#import "DYMonents1CellModel.h"


@interface DYMomentsFirstViewController () <DYMomentsCellOperationDelegate>

@end

@implementation DYMomentsFirstViewController

#pragma mark --- 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavgationBar];

    [self.dataArray addObjectsFromArray:[self creatModelsWithCount:50]];

    [self setUpMainView];
}

#pragma mark --- 创建视图
/*
 设置视图控制器
 **/
- (void)setupNavgationBar {
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];

    self.navigationItem.title = @"朋友圈";
}

- (void)setUpMainView {
    self.tableView.frame = CGRectMake(0, 0, DYScreenWidth, DYScreenHeight);

    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return DYAlmostZero;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return DYAlmostZero;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
    id model = self.dataArray[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"moments1CellModel" cellClass:[DYMoment1Cell class] contentViewWidth:[self cellContentViewWith]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak __typeof(self) weakSelf = self;
    DYMoment1Cell *cell = [DYMoment1Cell dy_moment1CellForTableView:tableView];
    cell.moments1CellModel = self.dataArray[indexPath.row];
    cell.indexPath = indexPath;
    cell.delegate = self;
    //点击更多的block
    cell.moreBlock = ^(NSIndexPath *currentIndexPath) {
        DYMonents1CellModel *model = [weakSelf.dataArray objectAtIndex:currentIndexPath.row];
        model.isOpening = !model.isOpening;
        [weakSelf.tableView reloadRowsAtIndexPaths:@[currentIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    };
    //点击内层cell所做的操作
    cell.clickedToCommentBlock = ^(NSIndexPath *outerIndexPath, NSIndexPath *innerIndexPath, DYMonents1CellCommentItemModel *innerCommentModel) {
        NSLog(@"点击了第%ld个动态\n 里面第%ld个评论\n评论的内容是%@",outerIndexPath.row,innerIndexPath.row,innerCommentModel.attributedContent);
    };
    //此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    DYMonents1CellModel *model = [self.dataArray objectAtIndex:indexPath.row];
//
//    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
}

- (CGFloat)cellContentViewWith {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

#pragma mark --- DYMomentsCellOperationDelegate
//点击喜欢
- (void)didClickLikeBtnInCell:(UITableViewCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    DYMonents1CellModel *model = [self.dataArray objectAtIndex:indexPath.row];
    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:model.likeItemsArray];
    if (!model.isLiked) {
        DYMonents1CellLikeItemModel *likeModel = [DYMonents1CellLikeItemModel new];
        likeModel.userName = @"elite_kyo";
        likeModel.userId = @"elite_kyo_iOS";
        [tempArr addObject:likeModel];
        model.liked = YES;
    } else {
        DYMonents1CellLikeItemModel *tempLikeModel = nil;
        for (DYMonents1CellLikeItemModel *likeModel in model.likeItemsArray) {
            if ([likeModel.userName isEqualToString:@"elite_kyo"]) {
                tempLikeModel = likeModel;
            }
        }
        [tempArr removeObject:tempLikeModel];
        model.liked = NO;
    }
    model.likeItemsArray = [tempArr copy];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

    });
}
//点击评论
- (void)didClickCommentBtnInCell:(UITableViewCell *)cell {

}


- (NSArray *)creatModelsWithCount:(NSInteger)count {
    NSArray *iconImageNamesArray = @[@"icon0.jpg",
                                     @"icon1.jpg",
                                     @"icon2.jpg",
                                     @"icon3.jpg",
                                     @"icon4.jpg",
                                     ];
    
    NSArray *namesArray = @[@"elite_kyo",
                            @"风口上的猪",
                            @"当今世界网名都不好起了",
                            @"我叫郭德纲",
                            @"Hello Kitty"];
    
    NSArray *textArray = @[@"当你的 app 没有提供 3x 的 LaunchImage 时，系统默认进入兼容模式，https://github.com/gsdios/SDAutoLayout大屏幕一切按照 320 宽度渲染，屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。",
                           @"然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，https://github.com/gsdios/SDAutoLayout等于把小屏完全拉伸。",
                           @"当你的 app 没有提供 3x 的 LaunchImage 时屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。屏幕宽度返回 320；https://github.com/gsdios/SDAutoLayout然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。",
                           @"但是建议不要长期处于这种模式下，否则在大屏上会显得字大，内容少，容易遭到用户投诉。",
                           @"屏幕宽度返回 320；https://github.com/gsdios/SDAutoLayout然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。"
                           ];
    
    NSArray *commentsArray = @[@"社会主义好！👌👌👌👌",
                               @"正宗好凉茶，正宗好声音。。。",
                               @"你好，我好，大家好才是真的好",
                               @"有意思",
                               @"你瞅啥？",
                               @"瞅你咋地？？？！！！",
                               @"hello，看我",
                               @"曾经在幽幽暗暗反反复复中追问，才知道平平淡淡从从容容才是真",
                               @"人艰不拆",
                               @"咯咯哒",
                               @"呵呵~~~~~~~~",
                               @"我勒个去，啥世道啊",
                               @"真有意思啊你💢💢💢"];
    
    NSArray *picImageNamesArray = @[ @"pic0.jpg",
                                     @"pic1.jpg",
                                     @"pic2.jpg",
                                     @"pic3.jpg",
                                     @"pic4.jpg",
                                     @"pic5.jpg",
                                     @"pic6.jpg",
                                     @"pic7.jpg",
                                     @"pic8.jpg"
                                     ];
    NSMutableArray *resArr = [NSMutableArray new];
    
    for (int i = 0; i < count; i++) {
        int iconRandomIndex = arc4random_uniform(5);
        int nameRandomIndex = arc4random_uniform(5);
        int contentRandomIndex = arc4random_uniform(5);
        
        DYMonents1CellModel *model = [DYMonents1CellModel new];
        model.iconName = iconImageNamesArray[iconRandomIndex];
        model.name = namesArray[nameRandomIndex];
        model.msgContent = textArray[contentRandomIndex];
        
        // 模拟“随机图片”
        int random = arc4random_uniform(6);
        
        NSMutableArray *temp = [NSMutableArray new];
        for (int i = 0; i < random; i++) {
            int randomIndex = arc4random_uniform(9);
            [temp addObject:picImageNamesArray[randomIndex]];
        }
        if (temp.count) {
            model.picNamesArray = [temp copy];
        }
        
        // 模拟随机评论数据
        int commentRandom = arc4random_uniform(3);
        NSMutableArray *tempComments = [NSMutableArray new];
        for (int i = 0; i < commentRandom; i++) {
            DYMonents1CellCommentItemModel *commentItemModel = [DYMonents1CellCommentItemModel new];
            int index = arc4random_uniform((int)namesArray.count);
            commentItemModel.firstUserName = namesArray[index];
            commentItemModel.firstUserId = @"666";
            if (arc4random_uniform(10) < 5) {
                commentItemModel.secondUserName = namesArray[arc4random_uniform((int)namesArray.count)];
                commentItemModel.secondUserId = @"888";
            }
            commentItemModel.commentString = commentsArray[arc4random_uniform((int)commentsArray.count)];
            [tempComments addObject:commentItemModel];
        }
        model.commentItemsArray = [tempComments copy];
        
        // 模拟随机点赞数据
        int likeRandom = arc4random_uniform(3);
        NSMutableArray *tempLikes = [NSMutableArray new];
        for (int i = 0; i < likeRandom; i++) {
            DYMonents1CellLikeItemModel *model = [DYMonents1CellLikeItemModel new];
            int index = arc4random_uniform((int)namesArray.count);
            model.userName = namesArray[index];
            model.userId = namesArray[index];
            [tempLikes addObject:model];
        }
        
        model.likeItemsArray = [tempLikes copy];
    
        [resArr addObject:model];
    }
    return [resArr copy];
}


@end
