//
//  ApiManager+Service.h
//  sichuan
//
//  Created by Lu.L on 16/2/17.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import "ApiManager.h"

@interface ApiManager (Service)

/**
 *  地图服务
 *
 *  @param
 *  @param completeBlock 結果
 *
 *  @return task
 */
- (NSURLSessionDataTask *)requestAddressWithCompleteBlock:(SCAddressDicCompleteBlock)completeBlock;


@end
