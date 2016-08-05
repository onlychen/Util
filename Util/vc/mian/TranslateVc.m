//
//  RotationVc.m
//  Util
//
//  Created by chenliang on 16/7/22.
//  Copyright © 2016年 chenliang. All rights reserved.
//

#import "TranslateVc.h"

@interface TranslateVc ()
/**旋转按钮**/
@property(nonatomic,strong)UIButton* rotationBn;
/**旋转图片*/
@property(nonatomic,strong)UIImageView* imgExchg;
@end

@implementation TranslateVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = Util_TranslateVc_Title;
    [self loadNaviControl];
    
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -初始化
-(void)initView
{
    
    UIButton *leftrotatebtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.view addSubview:leftrotatebtn];
    [leftrotatebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.mas_equalTo(100);
        make.size.mas_equalTo(CGSizeMake(100,100));
    }];
    [leftrotatebtn setTitle:@"向左旋转" forState:UIControlStateNormal];
    [leftrotatebtn setBackgroundColor:[UIColor redColor]];
    [leftrotatebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftrotatebtn addTarget:self action:@selector(rotate:) forControlEvents:UIControlEventTouchUpInside];
    self.rotationBn = leftrotatebtn;
    
    UIImage*  img = [UIImage imageNamed:@"trans_img"];
    UIImageView* chgImgView = [UIImageView new];
    [self.view addSubview:chgImgView];
    [chgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.mas_equalTo(220);
        make.size.mas_equalTo(CGSizeMake(img.size.width,img.size.height));
    }];
    chgImgView.image = img;
    self.imgExchg = chgImgView;
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureEvent:)];
    [self.view addGestureRecognizer:tapGesture];
}

#pragma mark -事件处理
-(void)rotate:(UIButton*)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        self.rotationBn.transform = CGAffineTransformTranslate(self.rotationBn.transform,100, 100);
    } completion:^(BOOL finished) {
    }];
    //CGAffineTransformRotate(self.rotationBn.transform, M_PI_2);
}

-(void)gestureEvent:(UITapGestureRecognizer*)gesture
{
    CGPoint  point = [gesture locationInView:self.view];
    if (CGRectContainsPoint(self.imgExchg.frame, point))
    {
        [UIView animateWithDuration:0.5 animations:^{
            self.imgExchg.transform = CGAffineTransformMakeTranslation(100, 100);
        } completion:^(BOOL finished) {
        }];
//        self.rotationBn.transform = CGAffineTransformTranslate(self.rotationBn.transform,100, 100);
    }
    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
