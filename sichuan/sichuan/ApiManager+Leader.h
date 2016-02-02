//
//  ApiManager+Leader.h
//  sichuan
//
//  Created by Lu.L on 16/1/29.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "ApiManager.h"

@interface ApiManager (Leader)


/**
 *  政府领导
 *
 *  @param
 *  @param completeBlock 結果
 *
 *  @return task
 */
- (NSURLSessionDataTask *)requestLeaderWithCompleteBlock:(SCLeaderDidCompleteBlock)completeBlock;

/**
 *  领导活动
 *
 *  @param nid 领导id pno 页数 psize 容量
 *  @param completeBlock 結果
 *
 *  @return task
 */
- (NSURLSessionDataTask *)requestActivityWithNId:(NSNumber *)nId
                                           Pages:(NSNumber *)pages
                                            size:(NSNumber *)size
                                   completeBlock:(SCActivityDidCompleteBlock)completeBlock;

/**
 *  领导讲话
 *
 *  @param nid 领导id pno 页数 psize 容量
 *  @param completeBlock 結果
 *
 *  @return task
 */
- (NSURLSessionDataTask *)requestSpeechWithNId:(NSNumber *)nId
                                         Pages:(NSNumber *)pages
                                          size:(NSNumber *)size
                                 completeBlock:(SCSpeechDidCompleteBlock)completeBlock;
@end
