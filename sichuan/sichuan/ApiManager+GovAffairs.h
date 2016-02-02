//
//  ApiManager+GovAffairs.h
//  sichuan
//
//  Created by Lu.L on 16/1/29.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "ApiManager.h"

@interface ApiManager (GovAffairs)

/**
 *  人事任免
 *
 *  @param pno 页数 psize 容量
 *  @param completeBlock 結果
 *
 *  @return task
 */
- (NSURLSessionDataTask *)requestPersonnelWithPages:(NSNumber *)pages
                                               size:(NSNumber *)size
                                      completeBlock:(SCPersonnelDidCompleteBlock)completeBlock;

/**
 *  公示公告
 *
 *  @param pno 页数 psize 容量
 *  @param completeBlock 結果
 *
 *  @return task
 */
- (NSURLSessionDataTask *)requestBulletinWithPages:(NSNumber *)pages
                                              size:(NSNumber *)size
                                     completeBlock:(SCBulletinDidCompleteBlock)completeBlock;

/**
 *  招考信息
 *
 *  @param pno 页数 psize 容量
 *  @param completeBlock 結果
 *
 *  @return task
 */
- (NSURLSessionDataTask *)requestExaminationWithPages:(NSNumber *)pages
                                                 size:(NSNumber *)size
                                        completeBlock:(SCExaminationDidCompleteBlock)completeBlock;

/**
 *  四川统计
 *
 *  @param pno 页数 psize 容量
 *  @param completeBlock 結果
 *
 *  @return task
 */
- (NSURLSessionDataTask *)requestStatisticsWithPages:(NSNumber *)pages
                                                size:(NSNumber *)size
                                       completeBlock:(SCStatisticsDidCompleteBlock)completeBlock;

/**
 *  计划报告
 *
 *  @param pno 页数 psize 容量
 *  @param completeBlock 結果
 *
 *  @return task
 */
- (NSURLSessionDataTask *)requestPlanWithPages:(NSNumber *)pages
                                          size:(NSNumber *)size
                                 completeBlock:(SCPlanDidCompleteBlock)completeBlock;

@end
