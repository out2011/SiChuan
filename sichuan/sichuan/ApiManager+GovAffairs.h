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
 *
 *
 *  @param pno 页数 psize 容量
 *  @param completeBlock 結果
 *
 *  @return task
 */
- (NSURLSessionDataTask *)requestNormalWithPages:(NSNumber *)pages
                                            size:(NSNumber *)size
                                             api:(NSString *)api
                                   completeBlock:(SCNormalDidCompleteBlock)completeBlock;


/**
 *  机构职能
 *
 *  @param
 *  @param completeBlock 結果
 *
 *  @return task
 */
- (NSURLSessionDataTask *)requestOrganizationWithCompleteBlock:(SCOrganizationDidCompleteBlock)completeBlock;

/**
 *  机构职能子项
 *
 *  @param pname 项目名
 *  @param completeBlock 結果
 *
 *  @return task
 */
- (NSURLSessionDataTask *)requestOrgListWithPname:(NSString *)pname
                                    completeBlock:(SCOrgListDidCompleteBlock)completeBlock;


@end
