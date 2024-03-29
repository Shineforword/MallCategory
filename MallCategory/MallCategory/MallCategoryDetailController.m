//
//  MallCategoryDetailController.m
//  MallCategory
//
//  Created by mengxiang on 2019/11/21.
//

#import "MallCategoryDetailController.h"
#import "MallCategoryParams.h"

@interface MallCategoryDetailController ()<UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
UIScrollViewDelegate>
//判断是否从下往上滑
@property (nonatomic) BOOL isScrollDown;
//记录上次滑动位置
@property (nonatomic) CGFloat lastOffsetY;

@end

@implementation MallCategoryDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MALLHEXCOLOR(@"#F5F5F5");
    [self.view addSubview:self.collectionView];
    [self.collectionView setFrame:CGRectMake(10, 10, CATEGORYDETAIL_WIDTH-20, kMain_Height-10)];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(didSelectRowAtIndexPath:)
                                                name:MALL_CATEGORY_MENU_DIDSELECTROWATINDEXPATH
                                              object:nil];

    // Do any additional setup after loading the view.
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)didSelectRowAtIndexPath:(NSNotification *)noti{
    NSIndexPath * indexPath = noti.object;
    UICollectionViewLayoutAttributes * attributes = [self.collectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row]];
    CGRect rect = attributes.frame;
    //滑动至相应位置
    [self.collectionView setContentOffset:CGPointMake(self.collectionView.frame.origin.x-10, rect.origin.y-CATEGORY_DETAIL_HEADER_H-20)
                                 animated:YES];

}
- (UICollectionView *)collectionView{
    if(!_collectionView){
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView= [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        flowLayout.sectionInset = CATEGORY_DETAIL_SECTIONINSET;
        //悬浮头部
//        flowLayout.sectionHeadersPinToVisibleBounds = YES;
        _collectionView.contentInset = CATEGORY_DETAIL_CONTENTINSET;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[MallCategoryMenuDetailCollectionCell class]
            forCellWithReuseIdentifier:@"MallCategoryMenuDetailCollectionCell"];
        [_collectionView registerClass:[MallCategoryMenuDetailCollectionHeader class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:@"HeaderView"];
    }
    return  _collectionView;
}
#pragma mark - <UICollectionViewDelegate,UICollectionViewDataSource>
//组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 12;
}
//数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 9;
}
//大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(CATEGORY_DETAIL_ITEM_W, CATEGORY_DETAIL_ITEM_H);
}
//行间隙
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return  CATEGORY_DETAIL_MINIMUMLINE_SPACE;
}
//列间隙
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return CATEGORY_DETAIL_MINIMUMINTERITEMS_SPACE;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * ID = @"MallCategoryMenuDetailCollectionCell";
    MallCategoryMenuDetailCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    return cell;
}
//头大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return (CGSize){CATEGORYDETAIL_WIDTH-20,CATEGORY_DETAIL_HEADER_H};
}
//头
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader){
        static NSString * ID = @"HeaderView";
        MallCategoryMenuDetailCollectionHeader * reusableView = nil;
        reusableView = (MallCategoryMenuDetailCollectionHeader *)[collectionView
                                                                 dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                 withReuseIdentifier:ID
                                                                 forIndexPath:indexPath];
        return reusableView;
    }
    return 0;
}
//滑入
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    

}
//滑出
-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    

}
//头滑入
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    if (!self.isScrollDown && self.collectionView.dragging){
        [[NSNotificationCenter defaultCenter]postNotificationName:MALL_CATEGORY_DETAIL_WILLDISPLAY_HEADER object:indexPath];
    }
}
//头滑出
-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    if (self.isScrollDown && self.collectionView.dragging){
        [[NSNotificationCenter defaultCenter]postNotificationName:MALL_CATEGORY_DETAIL_DIDENDDISPLAY_HEADER object:indexPath];
    }
}
//选中
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {


}
#pragma scorllView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.isScrollDown = self.lastOffsetY < scrollView.contentOffset.y;
    self.lastOffsetY = scrollView.contentOffset.y;
}


@end


#pragma mark - MallCategoryMenuDetailCollectionHeader
@interface MallCategoryMenuDetailCollectionHeader()
@property (nonatomic, strong)UILabel * specificationName;
@property (nonatomic, strong)UIView *  titleWhiteBgView;
@property (nonatomic, strong)UIImageView * adImageView;

@end
@implementation MallCategoryMenuDetailCollectionHeader

-(UIView *)titleWhiteBgView{
    if (!_titleWhiteBgView) {
        _titleWhiteBgView = [[UIView alloc]init];
        _titleWhiteBgView.backgroundColor = MALLHEXCOLOR(@"ffffff");
    }
    return _titleWhiteBgView;
}

- (UIImageView *)adImageView{
    if (!_adImageView) {
        _adImageView = [[UIImageView alloc]init];
        _adImageView.backgroundColor = MALLHEXCOLOR(@"FB3F49");
        _adImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _adImageView;
}

- (UILabel *)specificationName{
    if(!_specificationName){
        _specificationName = [[UILabel alloc]init];
        _specificationName.textColor = MALLHEXCOLOR(@"#333333");
        _specificationName.font = [UIFont fontWithName:(@"ArialMT") size:(13)];
        _specificationName.text= @"Best Sellers";

    }
    return _specificationName;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if(self){
        [self addSubview:self.adImageView];
        [self addSubview:self.titleWhiteBgView];
        [self addSubview:self.specificationName];
        self.backgroundColor = MALLHEXCOLOR(@"f5f5f5");
        [self.adImageView setRTLFrame:CGRectMake(0,0,CATEGORYDETAIL_WIDTH-20, 95)];
        [self.titleWhiteBgView setRTLFrame:CGRectMake(0,105,CATEGORYDETAIL_WIDTH-20, 30)];
        [self.specificationName setRTLFrame:CGRectMake(15,120,100, 15)];
    }
    return self;
}
@end

#pragma mark - 集合视图cell

@implementation MallCategoryMenuDetailCollectionCell

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.backgroundColor = MALLHEXCOLOR(@"FB3F49");
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = MALLHEXCOLOR(@"#333333");
        _titleLabel.font =[UIFont fontWithName:(@"ArialMT") size:(13)];
        _titleLabel.text= @"T-M-C";
    }
    return _titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.titleLabel];
        [self.imageView setRTLFrame:CGRectMake(10, 0, CATEGORY_DETAIL_ITEM_W-20, CATEGORY_DETAIL_ITEM_W-20)];
        [self.titleLabel setRTLFrame:CGRectMake(0, 72, 72, 15)];
    }
    return self;
}

@end
