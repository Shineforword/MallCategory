//
//  ViewController.m
//  MallCategory
//
//  Created by mengxiang on 2019/11/21.
//

#import "ViewController.h"
#import "MallCategoryParams.h"
#import "MallCategoryMenuController.h"
#import "MallCategoryDetailController.h"

@interface ViewController ()
@property (nonatomic, strong) MallCategoryMenuController * categoryMenuVC;
@property (nonatomic, strong) MallCategoryDetailController * categoryMenuDetailVC;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MALLHEXCOLOR(@"FFFFFF");
    [self addCategoryMenuView];
    [self addCategoryDetailCollectionView];

    // Do any additional setup after loading the view.
}

- (MallCategoryMenuController *)categoryMenuVC {
    if (!_categoryMenuVC) {
        _categoryMenuVC = [[MallCategoryMenuController alloc] init];
    }
    return _categoryMenuVC;
}

- (MallCategoryDetailController *)categoryMenuDetailVC{
    if (!_categoryMenuDetailVC) {
        _categoryMenuDetailVC = [[MallCategoryDetailController alloc] init];
    }
    return _categoryMenuDetailVC;
}
#pragma mark - 添加一级分类菜单
- (void)addCategoryMenuView{
    [self.view addSubview:self.categoryMenuVC.view];
    [self.categoryMenuVC.view setRTLFrame:CGRectMake(0, 0, CATEGORYMENU_WIDTH, kMain_Height)];
}
#pragma mark - 添加详细分类列表
- (void)addCategoryDetailCollectionView{
    [self.view addSubview:self.categoryMenuDetailVC.view];
    [self.categoryMenuDetailVC.view setRTLFrame:CGRectMake(CATEGORYMENU_WIDTH, 0, CATEGORYDETAIL_WIDTH, kMain_Height)];
}



@end
