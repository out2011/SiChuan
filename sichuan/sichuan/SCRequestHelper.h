//
//  SCRequestHelper.h
//  sichuan
//
//  Created by Lu.L on 16/1/27.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCRequestHelper : NSObject

+ (void)setRequestHeaderAtPath:(NSString *)path request:(id)request;

@end
