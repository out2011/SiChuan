//
//  ApiManager+Profile.h
//  sichuan
//
//  Created by Lu.L on 16/1/29.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "ApiManager.h"

@interface ApiManager (Profile)

/**
 *  概况介绍
 *
 *  @param 
 *  @param completeBlock 結果
 *
 *  @return task
 */
- (NSURLSessionDataTask *)requestSituationWithCompleteBlock:(SCSituationDidCompleteBlock)completeBlock;

/**
 *  地理位置和自然状况
 *
 *  @param pname 项目名
 *  @param completeBlock 結果
 *
 *  @return task
 */
- (NSURLSessionDataTask *)requestPositionWithPname:(NSString *)pname
                                     completeBlock:(SCPositionDidCompleteBlock)completeBlock;
@end
