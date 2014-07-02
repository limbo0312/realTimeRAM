//
//  auto_showRAM_Lbl.m
//  egsFramework
//
//  Created by EGS on 14-6-27.
//  Copyright (c) 2014年 EGS. All rights reserved.
//

#import "auto_showRAM_Lbl.h"
//=>
//#import "UIDevice+MemoryInfo.h"//内存相关
//#define MEMO_available      [[UIDevice currentDevice]  availableMemory]
//#define MEMO_used           [[UIDevice currentDevice]  usedMemory]

@interface auto_showRAM_Lbl ()

@property (nonatomic,strong)NSTimer *autoTimer;

@end

@implementation auto_showRAM_Lbl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
        [self performSelector:@selector(startRunCheck)
                   withObject:nil
                   afterDelay:2];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)startRunCheck{
    
    self.autoTimer = [NSTimer  scheduledTimerWithTimeInterval:2
                                                       target:self
                                                     selector:@selector(updateRam)
                                                     userInfo:nil
                                                      repeats:YES];
}

-(void)updateRam
{

    if ([NSThread isMainThread])
    {
        
        //===update info on RAM
        self.text = [NSString   stringWithFormat:@"MEMO_available is %f, MEMO_used is %f",MEMO_available,MEMO_used];
        
        if (DELEGATE_OF_APP.window!=self.superview) {
            [DELEGATE_OF_APP.window addSubview:self];
        }
        [DELEGATE_OF_APP.window bringSubviewToFront:self];

    }
    else
    {
        dispatch_sync(dispatch_get_main_queue(), ^(){
            
            //===update info on RAM
            self.text = [NSString   stringWithFormat:@"MEMO_available is %f, MEMO_used is %f",MEMO_available,MEMO_used];
            
        });
    }
}

@end
