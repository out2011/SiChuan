//
//  ApiManager+Photo.h
//  sichuan
//
//  Created by Lu.L on 16/1/29.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "ApiManager.h"

@interface ApiManager (Photo)

/**
 *  图说四川列表获取
 *
 *  @param pno 页数
 *  @param psize 容量
 *  @param completeBlock 結果
 *
 *  @return task
 */
- (NSURLSessionDataTask *)requestPhotoWithPages:(NSNumber *)pages
                                           size:(NSNumber *)size
                                  completeBlock:(SCPhotoDidCompleteBlock)completeBlock;

/**
 *  图说四川列表获取
 *
 *  @param nId 详情id
 *  @param completeBlock 結果
 *
 *  @return task
 */
- (NSURLSessionDataTask *)requestPhotoDetailWithNId:(NSNumber *)nId
                                  completeBlock:(SCPhotoDetailDicCompleteBlock)completeBlock;


@end
