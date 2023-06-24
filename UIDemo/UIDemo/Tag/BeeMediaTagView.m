//
//  BeeMediaTagView.m
//  BeeMediaFileEditor
//
//  Created by fengjiu on 2023/6/19.
//  Copyright © 2023 Alipay. All rights reserved.
//

#import "BeeMediaTagView.h"
#import "BMTopicCollectionViewCell.h"
#import "BMTagModel.h"
#import "BMCollectionViewHorzontalLayout.h"
#import "BMSelectedTagContainer.h"



@interface BeeMediaTagView ()<UICollectionViewDelegate, UICollectionViewDataSource, BMCollectionViewBaseFlowLayoutDelegate>

@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UICollectionView *collectionView;
//左上的图片
@property (nonatomic, strong) UIImageView *topIV;
//左下的图片
@property (nonatomic, strong) UIImageView *bottomIV;
@property (nonatomic, strong) UIButton *foldBtn;
@property (nonatomic, strong) UIImageView *leftIcon;
@property (nonatomic, strong) UIView *shadowView;

@property (nonatomic, strong) BMTopicCollectionViewCell *selectedCell;
@property (nonatomic, copy) NSArray *dataSource;

@property (nonatomic, strong) BMSelectedTagContainer *selectedContainer;

@property (nonatomic, assign) BOOL twoLineHasSetup;
@property (nonatomic, assign) BOOL selectedHasSetup;
@property (nonatomic, assign) BOOL oneLineHasSetup;

@end


#define leftIconWidth 65

@implementation BeeMediaTagView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self fireRequest];
        self.twoCol = YES;
        [self setupUI];
    }
    return self;
}

- (void)fireRequest
{
    self.dataSource = @[@"特种兵极限挑战",@"天南地北粽子大赏",@"特种兵旅游",@"端午节传统",@"拍背六月份需求做完了吗",@"可能做不完了",@"不会影响假期吧",@"就是这么多需求",@"这也看不掉",@"就这样写吧huugugfhfghgf"];
}

- (void)setupUI
{
    if ([self selectedCellIndex] != NSNotFound) {
        [self setupSelectedUI];
    } else if (self.twoCol) {
        [self setupTwoColUI];
    } else {
        [self setupSingleColUI];
    }
}

- (void)setupTwoColUI
{
    if (self.height != [self.class defaultHeight] &&
        [self.delegate respondsToSelector:@selector(tagView:heightChanged:)]) {
        [self.delegate tagView:self heightChanged:[self.class defaultHeight]];
    }
    self.container.hidden = NO;
    self.selectedContainer.hidden = YES;
    
    if (self.twoLineHasSetup) {
        return;
    }
    self.twoLineHasSetup = YES;
    
    CGFloat contentGap = 0.;
    CGFloat foldBtnWidth = 120.;
    CGFloat foldBtnheight = self.height/2.;
    CGFloat bottomIVWidth = 80.;
//    左侧发什么按钮和下面icon的间距
    CGFloat gapBetween = 0.;
//    图片或按钮与cell的间距
    CGFloat gap = 0.;
    self.container.frame = CGRectMake(contentGap,
                                      0,
                                      self.width-contentGap*2,
                                      self.height);
    [self addSubview:self.container];
    
//    self.foldBtn.frame = CGRectMake(0,
//                                    0,
//                                    foldBtnWidth,
//                                    foldBtnheight);
//    [self.container addSubview:self.foldBtn];
//
//    CGFloat height = self.height - CGRectGetMaxY(self.foldBtn.frame) - gapBetween;
//    self.bottomIV.frame = CGRectMake(0,
//                                     CGRectGetMaxY(self.foldBtn.frame),
//                                     bottomIVWidth,
//                                     height);
//    [self.container addSubview:self.bottomIV];

    self.leftIcon.frame = CGRectMake(0,
                                     0,
                                     leftIconWidth,
                                     self.height);
    [self.container addSubview:self.leftIcon];
    
    self.shadowView.frame = CGRectMake(self.leftIcon.right,
                                       0,
                                       12,
                                       self.height);
    [self setupShadow];
    [self.container addSubview:self.shadowView];
    
    CGFloat left = CGRectGetMaxX(self.leftIcon.frame)+gap;
    self.collectionView.frame = CGRectMake(left,
                                           0,
                                           self.width-left,
                                           self.height);
    [self.container insertSubview:self.collectionView atIndex:0];

}

- (void)setupShadow
{
    // 创建 CAGradientLayer
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.shadowView.bounds; // 设置渐变层的大小
    gradientLayer.colors = @[ (__bridge id)[UIColor blackColor].CGColor,
                              (__bridge id)[UIColor clearColor].CGColor ]; // 渐变颜色数组
    gradientLayer.startPoint = CGPointMake(0, 0.5); // 渐变起点
    gradientLayer.endPoint = CGPointMake(1, 0.5); // 渐变终点

    // 将渐变层添加到目标视图上
    [_shadowView.layer addSublayer:gradientLayer];
}

- (void)setupSingleColUI
{
    self.selectedContainer.frame = CGRectMake(0,
                                              0,
                                              self.width,
                                              self.height);
}

- (void)setupSelectedUI
{
    if (self.height != [self.class selectedHeight] &&
        [self.delegate respondsToSelector:@selector(tagView:heightChanged:)]) {
        [self.delegate tagView:self heightChanged:[self.class selectedHeight]];
    }
    
    self.container.hidden = YES;
    self.selectedContainer.hidden = NO;
    self.selectedContainer.frame = CGRectMake(0,
                                              0,
                                              self.width,
                                              [self.class selectedHeight]);
    NSInteger index = [self selectedCellIndex];
    if (index != NSNotFound) {
        BMTagModel *mode = [[BMTagModel alloc ] init];
        mode.name = self.dataSource[index];
        self.selectedContainer.model = mode;
    }

    [self addSubview:self.selectedContainer];
    
}

- (NSInteger)selectedCellIndex
{
    NSIndexPath *indexPath = [self.collectionView indexPathsForSelectedItems].firstObject;
    if (indexPath) {
        return indexPath.row;
    }
    return NSNotFound;
}

/// 默认标签view的高度（两行）
+ (CGFloat)defaultHeight
{
    return 102;
}

/// 选中标签后的高度
+ (CGFloat)selectedHeight
{
    return [BMSelectedTagContainer defaultHeight];
}


#pragma mark -
//- (void)foldBtnClicked
//{
//    self.selectedCell
//}

#pragma mark -
- (BMLayoutType)collectionView:(UICollectionView *)collectionView
                        layout:(BMCollectionViewBaseFlowLayout *)collectionViewLayout
                  typeOfLayout:(NSInteger)section
{
    return BMLayoutTypeColumnLayout;
}

- (BOOL)collectionView:(UICollectionView *)collectionView layout:(BMCollectionViewBaseFlowLayout *)collectionViewLayout attachToTop:(NSInteger)section {
    return NO;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(BMCollectionViewBaseFlowLayout *)collectionViewLayout columnCountOfSection:(NSInteger)section {
    return 2;
}

/******** 设置每个section的背景色 ***********/
//设置每个section的背景色
- (UIColor*)collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewFlowLayout *)collectionViewLayout
       backColorForSection:(NSInteger)section
{
    return [UIColor blackColor];
}

/******** AbsoluteLayout绝对定位布局需要的代理 ***********/
//在AbsoluteLayout绝对定位布局中指定每个item的frame，不指定默认为CGRectZero
- (CGRect)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewFlowLayout*)collectionViewLayout
              rectOfItem:(NSIndexPath*)indexPath
{
    return CGRectZero;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString *string = self.dataSource[indexPath.row];
    BMTagModel *model = [[BMTagModel alloc] init];
    model.name = string;
    if (indexPath.row == 1) {
        model.isHotTopic = @"1";
    }
    CGFloat extW = [BMTopicCollectionViewCell extWidthWithModel:model];
    CGFloat width = [string sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.f]}].width +
    extW;
    return CGSizeMake(width, 36);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

// 横向和纵向滑动时：横向两个元素间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 4;
}

// 横向和纵向滑动时：纵向两个元素间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 4;
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *tmpCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(BMTopicCollectionViewCell.class)
                                                                           forIndexPath:indexPath];
    BMTopicCollectionViewCell *cell = (BMTopicCollectionViewCell *)tmpCell;
    BMTagModel *model = [[BMTagModel alloc] init];
    model.name = self.dataSource[indexPath.row];
    if (indexPath.row == 1) {
        model.isHotTopic = @"1";
    }
    cell.model = model;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BMTagModel *model = [[BMTagModel alloc] init];
    model.name = self.dataSource[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(tagView:tagSelected:)]) {
        [self.delegate tagView:self tagSelected:model];
    }
    [self setupUI];
}

#pragma mark -
- (void)selectedTagContainerDeseleted:(BMSelectedTagContainer *)container
{
    NSIndexPath *path = [self.collectionView indexPathsForSelectedItems].firstObject;
    if (path) {
        [self.collectionView deselectItemAtIndexPath:path animated:NO];
        [self setupUI];
    }
}

#pragma mark - getter

- (UIView *)container
{
    if (!_container) {
        _container = [[UIView alloc] init];
        _container.backgroundColor = [UIColor clearColor];
        _container.layer.cornerRadius = 12;
        _container.layer.masksToBounds = YES;
    }
    return _container;
}

- (UIButton *)foldBtn
{
    if (!_foldBtn) {
        _foldBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _foldBtn.backgroundColor = [UIColor blueColor];
        [_foldBtn addTarget:self action:@selector(foldBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _foldBtn;
}

- (UIImageView *)bottomIV
{
    if (!_bottomIV) {
        _bottomIV = [[UIImageView alloc] initWithImage:nil];
        _bottomIV.backgroundColor = [UIColor blackColor];
    }
    return _bottomIV;
}

- (UIImageView *)leftIcon
{
    if (!_leftIcon) {
        _leftIcon = [[UIImageView alloc] initWithImage:BME_IMG(@"bee_topic_tagsIcon")];
        _leftIcon.backgroundColor = [UIColor clearColor];
    }
    return _leftIcon;
}

- (UIView *)selectedContainer
{
    if (!_selectedContainer) {
        _selectedContainer = [[BMSelectedTagContainer alloc] init];
        _selectedContainer.backgroundColor = [UIColor blackColor];
        _selectedContainer.delegate = self;
    }
    return _selectedContainer;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        BMCollectionViewHorzontalLayout* layout = [[BMCollectionViewHorzontalLayout alloc]init];
        layout.delegate = self;
        layout.canDrag = YES;
        layout.columnSortType = BMColumnSortTypeSequence;
        layout.topLeftGap = 16;
//        layout.bottomLeftGap = leftIconWidth;
        layout.header_suspension = YES;
        
        
        layout.minimumLineSpacing = 1.f; //纵向或横向：纵向间距
        layout.minimumInteritemSpacing = 1.f; //纵向或横向滑动：横向间距
        layout.scrollDirection =  UICollectionViewScrollDirectionHorizontal;
        
//        layout.columnCount = 2;
    

        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:BMTopicCollectionViewCell.class forCellWithReuseIdentifier:NSStringFromClass(BMTopicCollectionViewCell.class)];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;
}

- (UIView *)shadowView
{
    if (!_shadowView) {
        _shadowView = [[UIView alloc] init];
        _shadowView.backgroundColor = [UIColor clearColor];
    }
    return _shadowView;
}
@end
