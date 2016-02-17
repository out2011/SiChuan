//
//  FoldInfo.h
//  sichuan
//
//  Created by Lu.L on 16/1/25.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoldInfo : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *information;
@property (nonatomic, strong) NSNumber *nId;
@property (nonatomic, getter=isFold) BOOL isFold;

@property (nonatomic, getter=isLoad) BOOL isLoad;

/**
 *  分组列表数据填充
 *
 *  @param array json
 *
 *  @return array
 */
+ (NSArray *)fillFoldInformation:(NSArray *)array;
@end
