//
//  SCCompareHelper.h
//  sichuan
//
//  Created by Lu.L on 16/1/28.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCCompareHelper : NSObject

+ (BOOL)compareNewData:(NSArray *)data withIdentifier:(NSString *)identifier;
+ (BOOL)compareNIdWithData:(NSArray *)data withIdentifier:(NSString *)identifier;

@end
