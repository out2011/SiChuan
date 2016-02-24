//
//  ApiManager+Push.h
//  sichuan
//
//  Created by Lu.L on 16/2/24.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "ApiManager.h"

@interface ApiManager (Push)

/**
 *  推送通知
 *
 *  @param nid 编号
 *  @param type 分类
 *  @param completeBlock 結果
 *
 *  @return task
 */
- (NSURLSessionDataTask *)requestPushMsgWithNid:(NSNumber *)nid
                                           type:(NSString *)type
                                  completeBlock:(SCPushMsgDidCompleteBlock)completeBlock;

@end
