//
//  NoteHelper.h
//  sichuan
//
//  Created by Lu.L on 16/2/1.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCNoteHelper : NSObject

+ (NSString *)noteWithDate:(NSString *)date from:(NSString *)from;

+ (NSInteger)imagesNumber:(NSString *)data;
@end
