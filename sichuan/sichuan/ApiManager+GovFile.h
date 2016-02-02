//
//  ApiManager+GovFile.h
//  sichuan
//
//  Created by Lu.L on 16/1/29.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "ApiManager.h"

@interface ApiManager (GovFile)

/**
 *  政府文件列表
 *
 *  @param pno 页数
 *  @param psize 容量
 *  @param completeBlock 結果
 *
 *  @return task
 */
- (NSURLSessionDataTask *)requestGovFileWithPages:(NSNumber *)pages
                                             size:(NSNumber *)size
                                    completeBlock:(SCGovFileDidCompleteBlock)completeBlock;



@end
