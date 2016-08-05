//
//  RotationVc.m
//  Util
//
//  Created by chenliang on 16/7/22.
//  Copyright © 2016年 chenliang. All rights reserved.
//

#import "ScaleVc.h"

@interface ScaleVc ()
/**缩放按钮**/
@property(nonatomic,strong)UIButton* rotationBn;
/**缩放图片*/
@property(nonatomic,strong)UIImageView* imgExchg;
/**缩放比例*/
@property(nonatomic,assign)CGFloat angle;
@end

@implementation ScaleVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = Util_ScaleVc_Title;
    [self loadNaviControl];
    
    self.angle = -1;
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
        self.rotationBn.transform = CGAffineTransformScale(self.rotationBn.transform, -1, -1);
    } completion:^(BOOL finished) {
    }];
}

-(void)gestureEvent:(UITapGestureRecognizer*)gesture
{
    CGPoint  point = [gesture locationInView:self.view];
    if (CGRectContainsPoint(self.imgExchg.frame, point))
    {
        [UIView animateWithDuration:0.5 animations:^{
            self.imgExchg.transform = CGAffineTransformScale(self.imgExchg.transform, 1, -1);
//            CGAffineTransformMakeScale(self.angle,1);
//            if (self.angle == -1)
//            {
//                self.angle = 1;
//            }
//            else
//            {
//                self.angle = -1;
//            }
        } completion:^(BOOL finished) {

        }];

//        self.imgExchg.transform = CGAffineTransformScale(self.imgExchg.transform, -1, 1);
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
