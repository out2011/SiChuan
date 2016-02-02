//
//  SCCompareHelper.m
//  sichuan
//
//  Created by Lu.L on 16/1/28.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "SCCompareHelper.h"

@implementation SCCompareHelper

+ (BOOL)compareNewData:(NSMutableArray *)data withIdentifier:(NSString *)identifier {
    
    NSDictionary *dic = data[0];
    NSNumber *nId;
    
    NSArray *localData = [[NSUserDefaults standardUserDefaults] objectForKey:identifier];
    NSDictionary *localDic = localData[0];
    NSNumber *localNId;
    
    nId = dic[@"nID"];
    localNId = localDic[@"nID"];
    
    
    
    
    
    return [nId isEqualToNumber:localNId];
}

@end
