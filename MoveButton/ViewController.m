//
//  ViewController.m
//  MoveButton
//
//  Created by fuzheng on 16-5-26.
//  Copyright © 2016年 付正. All rights reserved.
//

#import "ViewController.h"
#import "CustomGrid.h"
#import "PTSingletonManager.h"

@interface ViewController ()<CustomGridDelegate,UIScrollViewDelegate>
{
    BOOL isSelected;
    BOOL contain;
    //是否可跳转应用对应的详细页面
    BOOL isSkip;
    UIScrollView * myScrollView;
    
    //选中格子的起始位置
    CGPoint startPoint;
    //选中格子的起始坐标位置
    CGPoint originPoint;
    
    UIImage *normalImage;
    UIImage *highlightedImage;
    UIImage *deleteIconImage;
}
@end

@implementation ViewController

- (instancetype)init
{
    if (self = [super init]) {
        
        self.gridListArray = [[NSMutableArray alloc] initWithCapacity:9];
        
        self.showGridArray = [[NSMutableArray alloc] initWithCapacity:9];
        self.showGridImageArray = [[NSMutableArray alloc] initWithCapacity:9];
        self.showGridIDArray = [[NSMutableArray alloc] initWithCapacity:9];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.title = @"九宫格菜单";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.gridListArray = [[NSMutableArray alloc] initWithCapacity:9];
    
    self.showGridArray = [[NSMutableArray alloc] initWithCapacity:9];
    self.showGridImageArray = [[NSMutableArray alloc] initWithCapacity:9];
    self.showGridIDArray = [[NSMutableArray alloc] initWithCapacity:9];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    isSelected = NO;
    
    NSMutableArray *titleArr = [PTSingletonManager shareInstance].showGridArray;
    NSMutableArray *imageArr = [PTSingletonManager shareInstance].showImageGridArray;
    NSMutableArray *idArr = [PTSingletonManager shareInstance].showGridIDArray;
    _showGridArray = [[NSMutableArray alloc]initWithArray:titleArr];
    _showGridImageArray = [[NSMutableArray alloc]initWithArray:imageArr];
    _showGridIDArray = [[NSMutableArray alloc]initWithArray:idArr];
    
    [myScrollView removeFromSuperview];
    [self creatMyScrollView];
    
}

- (void)creatMyScrollView
{
#pragma mark - 可拖动的按钮
    normalImage = [UIImage imageNamed:@"app_item_bg"];
    highlightedImage = [UIImage imageNamed:@"app_item_bg"];
    deleteIconImage = [UIImage imageNamed:@"app_item_plus"];
    
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
    myScrollView.contentInset = UIEdgeInsetsMake(0, 0, ScreenHeight*2, 0);
    myScrollView.backgroundColor = [UIColor clearColor];
    myScrollView.delegate = self;
    [self.view addSubview:myScrollView];
    
    _gridListView = [[UIView alloc] init];
    [_gridListView setFrame:CGRectMake(0, 0, ScreenWidth, GridHeight * PerColumGridCount)];
    [_gridListView setBackgroundColor:[UIColor whiteColor]];
    
    [myScrollView addSubview:_gridListView];
    
    [self.gridListArray removeAllObjects];
    for (NSInteger index = 0; index < [_showGridArray count]; index++)
    {
        NSString *gridTitle = _showGridArray[index];
        NSString *gridImage = _showGridImageArray[index];
        NSInteger gridID = [self.showGridIDArray[index] integerValue];
        CustomGrid *gridItem = [[CustomGrid alloc] initWithFrame:CGRectZero title:gridTitle normalImage:normalImage highlightedImage:highlightedImage gridId:gridID atIndex:index withIconImage:gridImage];
        gridItem.delegate = self;
        gridItem.gridTitle = gridTitle;
        gridItem.gridImageString = gridImage;
        gridItem.gridId = gridID;
        
        [self.gridListView addSubview:gridItem];
        [self.gridListArray addObject:gridItem];
        
    }
    
    //for test print out
    for (NSInteger i = 0; i < _gridListArray.count; i++) {
        CustomGrid *gridItem = _gridListArray[i];
        gridItem.gridCenterPoint = gridItem.center;
    }
    
    NSInteger gridHeight;
    gridHeight = 123 * self.showGridArray.count/3;
    
    myScrollView.contentInset = UIEdgeInsetsMake(0, 0, gridHeight, 0);
}

#pragma mark - 可拖动按钮
#pragma mark - 点击格子
- (void)gridItemDidClicked:(CustomGrid *)gridItem
{
    [self itemAction:gridItem.gridTitle];
}


#pragma mark 点击 按钮
- (void)itemAction:(NSString *)title
{
    if ([title isEqualToString:@"更多"])
    {
        
    }
    else {
        NSLog(@"点击了%@格子",title);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
