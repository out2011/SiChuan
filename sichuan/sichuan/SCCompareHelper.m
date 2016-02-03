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
    NSString *key = @"nID";
    
    nId = dic[key];
    localNId = localDic[key];
    
    return [nId isEqualToNumber:localNId];
}

+ (BOOL)compareNIdWithData:(NSMutableArray *)data withIdentifier:(NSString *)identifier{
    
    NSDictionary *dic = data[0];
    NSNumber *nId;
    
    NSArray *localData = [[NSUserDefaults standardUserDefaults] objectForKey:identifier];
    NSDictionary *localDic = localData[0];
    NSNumber *localNId;
    NSString *key = @"nId";
    
    nId = dic[key];
    localNId = localDic[key];
    
    return [nId isEqualToNumber:localNId];
    
}
@end
