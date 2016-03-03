//
//  SCVersionHelper.h
//  sichuan
//
//  Created by Lu.L on 16/3/3.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCVersionHelper : NSObject

+ (BOOL)updateWithNewVersion:(NSString *)newVersion
                  oldVersion:(NSString *)oldVersion;

@end
