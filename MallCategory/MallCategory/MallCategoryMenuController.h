//
//  MallCategoryMenuController.h
//  MallCategory
//
//  Created by mengxiang on 2019/11/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MallCategoryMenuController : UIViewController
@property(nonatomic, strong)UITableView * tableView;
/** 一级分类菜单*/
@property(nonatomic, strong)NSMutableArray * categoryTitlesArray;

@end

NS_ASSUME_NONNULL_END


NS_ASSUME_NONNULL_BEGIN

@interface MallCategoryMenuCell : UITableViewCell

@end
NS_ASSUME_NONNULL_END
