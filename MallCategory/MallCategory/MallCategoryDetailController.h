//
//  MallCategoryDetailController.h
//  MallCategory
//
//  Created by mengxiang on 2019/11/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MallCategoryDetailController : UIViewController
@property (nonatomic, strong)UICollectionView * collectionView;

@end

NS_ASSUME_NONNULL_END


NS_ASSUME_NONNULL_BEGIN

@interface MallCategoryMenuDetailCollectionHeader : UICollectionReusableView

@end

NS_ASSUME_NONNULL_END

NS_ASSUME_NONNULL_BEGIN

@interface MallCategoryMenuDetailCollectionCell : UICollectionViewCell
@property (nonatomic,strong) UIImageView * imageView;
@property (nonatomic,strong) UILabel * titleLabel;
@end

NS_ASSUME_NONNULL_END
