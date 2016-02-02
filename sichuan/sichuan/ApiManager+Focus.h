//
//  ApiManager+Focus.h
//  sichuan
//
//  Created by Lu.L on 16/1/27.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "ApiManager.h"

@interface ApiManager (Focus)

/**
 *  聚焦四川列表获取
 *
 *  @param pno 页数 psize 容量
 *  @param completeBlock 結果
 *
 *  @return task
 */
- (NSURLSessionDataTask *)requestFocusListWithPages:(NSNumber *)pages
                                               size:(NSNumber *)size
                                      completeBlock:(SCFocusListDidCompleteBlock)completeBlock;

@end
