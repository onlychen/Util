//
//  FlyMscVc.m
//  Util
//
//  Created by chenliang on 16/7/28.
//  Copyright © 2016年 chenliang. All rights reserved.
//

#import "FlyMscVc.h"
#import <iflyMSC/IFlySpeechRecognizer.h>
#import <iflyMSC/IFlySpeechConstant.h>
#import <iflyMSC/IFlyRecognizerView.h>
#import "IATConfig.h"
#import <iflyMSC/IFlySpeechError.h>
#import "ISRDataHelper.h"
#import "FlySoundView.h"
#import <ReactiveCocoa.h>

@interface FlyMscVc ()<IFlySpeechRecognizerDelegate,UITextFieldDelegate,FlySoundViewDelegate>
/**不带界面的识别对象*/
@property(nonatomic,strong)IFlySpeechRecognizer *iFlySpeechRecognizer;
/**当前是否取消*/
@property(nonatomic,strong)NSString* isCanceled;
/**编辑框*/
@property(nonatomic,strong)UITextField*  textField;
/**弹出视图*/
@property(nonatomic,strong)FlySoundView*  soundView;
//@property(nonatomic,strong)IFlyRecognizerView *iflyRecognizerView;
@end

@implementation FlyMscVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = Util_FlyMscVc_Title;
    [self loadNaviControl];
    
    UITextField* textFd = [UITextField new];
    [self.view addSubview:textFd];
    self.textField = textFd;
    [textFd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(Util_Up_Height + 10);
        make.size.mas_equalTo(CGSizeMake(Util_View_Width - 2*10, 50));
    }];
    textFd.placeholder = @"请输入内容";
    textFd.backgroundColor = [UIColor colorWithRed:0.2 green:0.9 blue:0.5 alpha:0.3];
    textFd.clearButtonMode = UITextFieldViewModeWhileEditing;
    UIImageView* rigImagView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_mircophone2"]];
    rigImagView.userInteractionEnabled = YES;
    textFd.rightView = rigImagView;
    textFd.rightViewMode = UITextFieldViewModeAlways;
    
    [textFd.rac_textSignal subscribeNext:^(id x) {
        NSString* str = x;
        if (str.length > 0)
        {
            textFd.rightView.hidden = YES;
            textFd.clearButtonMode = UITextFieldViewModeWhileEditing;
            textFd.rightViewMode = UITextFieldViewModeNever;
        }
        else
        {
            textFd.rightView.hidden = NO;
            textFd.rightViewMode = UITextFieldViewModeAlways;
        }
    }];
    
    UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(soundAction:)];
    [textFd.rightView addGestureRecognizer:gesture];
}

-(void)soundAction:(UITapGestureRecognizer*)gesture
{
    [self.view endEditing:YES];
    if (!self.soundView)
    {
        self.soundView = [[FlySoundView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        self.soundView.center = CGPointMake(Util_View_Width/2, Util_View_Height/2);
        [self.view addSubview:self.soundView];
        self.soundView.delegate = self;
        self.soundView.hidden = YES;
    }
    self.soundView.hidden = NO;
    [self.soundView resumerTimer];
    //启动语音听写
    [self steupRecognizer];
}

-(void)steupRecognizer
{
    if(self.iFlySpeechRecognizer == nil)
    {
        [self initRecognizer];
    }
    
    [self.iFlySpeechRecognizer cancel];
    
    //设置音频来源为麦克风
    [self.iFlySpeechRecognizer setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
    
    //设置听写结果格式为json
    [self.iFlySpeechRecognizer setParameter:@"json" forKey:[IFlySpeechConstant RESULT_TYPE]];
    
    //保存录音文件，保存在sdk工作路径中，如未设置工作路径，则默认保存在library/cache下
    [self.iFlySpeechRecognizer setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    
    [self.iFlySpeechRecognizer setDelegate:self];
    
    BOOL ret = [self.iFlySpeechRecognizer startListening];
    
    if (ret)
    {
  
    }
    else
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"启动识别服务失败，请稍后重试" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }

}

-(void)initRecognizer
{
    //单例模式，无UI的实例
    if (_iFlySpeechRecognizer == nil)
    {
        self.iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
        [self.iFlySpeechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
        //设置听写模式
        [self.iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
    }
    self.iFlySpeechRecognizer.delegate = self;
    
    if (self.iFlySpeechRecognizer != nil)
    {
        IATConfig *instance = [IATConfig sharedInstance];
        
        //设置最长录音时间
        [self.iFlySpeechRecognizer setParameter:instance.speechTimeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
        //设置后端点
        [self.iFlySpeechRecognizer setParameter:instance.vadEos forKey:[IFlySpeechConstant VAD_EOS]];
        //设置前端点
        [self.iFlySpeechRecognizer setParameter:instance.vadBos forKey:[IFlySpeechConstant VAD_BOS]];
        //网络等待时间
        [self.iFlySpeechRecognizer setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
        
        //设置采样率，推荐使用16K
        [self.iFlySpeechRecognizer setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
        
        if ([instance.language isEqualToString:[IATConfig chinese]])
        {
            //设置语言
            [self.iFlySpeechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
            //设置方言
//            [self.iFlySpeechRecognizer setParameter:instance.accent forKey:[IFlySpeechConstant ACCENT]];
        }
        else if ([instance.language isEqualToString:[IATConfig english]])
        {
            [_iFlySpeechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
        }
        //设置是否返回标点符号
        [_iFlySpeechRecognizer setParameter:instance.dot forKey:[IFlySpeechConstant ASR_PTT]];
        
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IFlySpeechRecognizerDelegate识别代理
/*识别结果返回代理
 @param :results识别结果
 @ param :isLast 表示是否最后一次结果
 */
- (void) onResults:(NSArray *) results isLast:(BOOL)isLast
{
    NSString* strCurrValue = self.textField.text;
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = results[0];
    for (NSString *key in dic)
    {
        [resultString appendFormat:@"%@",key];
    }
    
    NSString* strResult = [NSString stringWithFormat:@"%@%@",strCurrValue,resultString];
    NSLog(@"%@",strResult);
    NSString* resultFromJson =  [ISRDataHelper stringFromJson:resultString];
    NSLog(@"%@",resultFromJson);
    self.textField.text = [NSString stringWithFormat:@"%@%@",self.textField.text,resultFromJson];
}

/*识别会话结束返回代理
 @ param error 错误码,error.errorCode=0表示正常结束,非0表示发生错误。 */
- (void)onError: (IFlySpeechError *) error{
    if (self.isCanceled) {
        NSLog(@"识别取消");
    }
    else if (error.errorCode == 0)
    {
        if (self.textField.text.length == 0)
        {
            NSLog(@"无识别结果");
        }
        else
        {
            NSLog(@"识别成功");
        }
    }
    else
    {
        NSLog(@"发生错误: %d %@",error.errorCode,error.errorDesc);
    }
    

}
/**
 停止录音回调
 ****/
- (void) onEndOfSpeech {
    NSLog(@"onEndOfSpeech");
}
/**
 开始识别回调
 ****/
- (void) onBeginOfSpeech {
    NSLog(@"onBeginOfSpeech");
}
/**
 音量回调函数 volume 0-30
*/
 
-(void) onVolumeChanged: (int)volume {
    NSLog(@"%d",volume);
}
 
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.iFlySpeechRecognizer cancel]; //取消识别
    [self.iFlySpeechRecognizer setDelegate:nil];
    [self.iFlySpeechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
}


#pragma mark - FlySoundViewDelegate
-(void)timerActionCallBack
{
    self.soundView.hidden = YES;
    [self.iFlySpeechRecognizer stopListening];
}
@end
