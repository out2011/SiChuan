//
//  ApiManager+Version.h
//  sichuan
//
//  Created by Lu.L on 16/3/1.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "ApiManager.h"

@interface ApiManager (Version)

/**
 *  版本检测
 *
 *  @param
 *  @param completeBlock 結果
 *
 *  @return task
 */
- (NSURLSessionDataTask *)requestVersionWithCompleteBlock:(SCVersionDidCompleteBlock)completeBlock;

@end
