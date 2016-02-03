//
//  ApiManager.h
//  sichuan
//
//  Created by Lu.L on 16/1/27.
//  Copyright © 2016年 L.l. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


#define kPageSize @(15)

extern NSString * const kBaseUrl;

/// base request
typedef void(^SCSessionTaskDidCompleteBlock)(NSURLSessionDataTask *task, id responseObject, NSError *error);

//---------------- 聚焦四川 --------------- //
static NSString *API_FocusList = @"focus-sc";
typedef void(^SCFocusListDidCompleteBlock)(NSDictionary *responseObject, NSError *error);

//---------------- 四川概况 --------------- //
/// 概况介绍
static NSString *API_Situation = @"situation/provinces";
typedef void(^SCSituationDidCompleteBlock)(NSArray *responseObject, NSError *error);
/// 地理位置和自然状况
static NSString *API_Position = @"situation/detail";
typedef void(^SCPositionDidCompleteBlock)(NSArray *responseObject, NSError *error);

/// 最新省情
static NSString *API_News = @"situation/news?type=1&";
typedef void(^SCNewsDidCompleteBlock)(NSDictionary *responseObject, NSError *error);
/// 统计公报
static NSString *API_StaNotice = @"situation/news?type=2&";
typedef void(^SCStaNoticeDidCompleteBlock)(NSDictionary *responseObject, NSError *error);

// --------------- 政府文件 --------------- //
static NSString *API_GovFile = @"docs?";
typedef void(^SCGovFileDidCompleteBlock)(NSDictionary *responseObject, NSError *error);

// --------------- 政务信息 --------------- //
/// 人事任免
static NSString *API_Personnel = @"gov-info/detail?type=1&";

/// 公示公告
static NSString *API_Bulletin = @"gov-info/detail?type=2&";

/// 招考信息
static NSString *API_Examination = @"gov-info/detail?type=3&";

/// 四川统计
static NSString *API_Statistics = @"gov-info/detail?type=4&";

/// 计划报告
static NSString *API_Plan = @"gov-info/detail?type=5&";

typedef void(^SCNormalDidCompleteBlock)(NSDictionary *responsObject, NSError *error);

/// 机构职能
static NSString *API_Organization = @"gov-info/org";
typedef void(^SCOrganizationDidCompleteBlock)(NSArray *responseObject, NSError *error);
/// 机构职能子项
static NSString *API_OrgList = @"gov-info/orgDetailList";
typedef void(^SCOrgListDidCompleteBlock)(NSArray *responseObject, NSError *error);
/// 机构职能详情
static NSString *API_OrgDetail = @"gov-info/orgDetail?";
typedef void(^SCOrgDetailDidCompleteBlock)(NSArray *responseObject, NSError *error);


// --------------- 政府领导 --------------- //
/// 政府领导
static NSString *API_Leader = @"leader";
typedef void(^SCLeaderDidCompleteBlock)(NSArray *responseObject, NSError *error);
/// 领导活动
static NSString *API_Activity = @"leader/activity?type=1&";
typedef void(^SCActivityDidCompleteBlock)(NSDictionary *responseObject, NSError *error);
/// 领导讲话
static NSString *API_Speech = @"leader/activity?type=2&";
typedef void(^SCSpeechDidCompleteBlock)(NSDictionary *responseObject, NSError *error);

// --------------- 图说四川 --------------- //
/// 图说四川列表
static NSString *API_Photo = @"photo-sc";
typedef void(^SCPhotoDidCompleteBlock)(NSDictionary *responseObject, NSError *error);
/// 图说四川详情
static NSString *API_PhotoDetail = @"photo-sc/detail?";
typedef void(^SCPhotoDetailDicCompleteBlock)(NSDictionary *responseObject, NSError *error);

// --------------- 办事服务 --------------- //
///办事指南
static NSString *url_guide = @"http://egov.sczw.gov.cn/";

/// 公交路线
static NSString *url_traffic = @"http://cdgjbus.com/index.aspx";

/// 社保查询
static NSString *url_security = @"http://cdhrss.gov.cn/login.jsp";

/// 交通违章
static NSString *url_rules = @"http://sc.122.gov.cn";

/// 路况查询
static NSString *url_road = @"http://www.scjt.gov.cn/";

/// 公积金查询
static NSString *url_fund = @"http://www.scsjgjj.com/";

/// 办事状态
static NSString *url_doc = @"http://www.sc.gov.cn/10462/include/bjwqjyj20120228.shtml";

/// 电子政务大厅
static NSString *url_holl = @"http://3g.sczw.gov.cn/";

@interface ApiManager : NSObject

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

+ (ApiManager *)sharedInstance;

- (NSURLSessionDataTask *)post:(NSString *)path
                    parameters:(id)parameters
                 completeBlock:(SCSessionTaskDidCompleteBlock)completeBlock;

- (NSURLSessionDataTask *)get:(NSString *)path
                   parameters:(id)parameters
                completeBlock:(SCSessionTaskDidCompleteBlock)completeBlock;
@end

#import "ApiManager+Focus.h"







