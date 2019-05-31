//
//  EasyTextGlobalConfig.m
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2018/3/3.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import "EasyTextGlobalConfig.h"

@implementation EasyTextGlobalConfig

easyShowView_singleton_implementation(EasyTextGlobalConfig)

- (instancetype)init
{
    if (self = [super init]) {
        
        _showOnWindow = YES ;
        _superReceiveEvent = YES ;

        _animationType = TextAnimationTypeBounce ;
        _statusType = TextStatusTypeMidden  ;
        
        _titleFont = [UIFont systemFontOfSize:14*kWidthRate];
        _titleColor = KUIColorFontColor_SH;
        //[[UIColor whiteColor]colorWithAlphaComponent:1.7];
        _bgColor = KUIColorFontColor_BGH;
        _shadowColor = KUILineColor;
        
    }
    return self ;
}

+ (BOOL)isUseTextGlobalConfig
{
    return _showInstance!=nil ? YES : NO ;
}
@end
