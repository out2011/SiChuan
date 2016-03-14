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

//---------------- 今日四川 --------------- //
static NSString *api_focusList = @"focus-sc";
typedef void(^SCFocusListDidCompleteBlock)(NSDictionary *responseObject, NSError *error);

//---------------- 四川概况 --------------- //
/// 概况介绍
static NSString *api_situation = @"situation/provinces";
typedef void(^SCSituationDidCompleteBlock)(NSArray *responseObject, NSError *error);
/// 地理位置和自然状况
static NSString *api_position = @"situation/detail";
typedef void(^SCPositionDidCompleteBlock)(NSArray *responseObject, NSError *error);

/// 最新省情
static NSString *api_news = @"situation/news?type=1&";
typedef void(^SCNewsDidCompleteBlock)(NSDictionary *responseObject, NSError *error);
/// 统计公报
static NSString *api_staNotice = @"situation/news?type=2&";
typedef void(^SCStaNoticeDidCompleteBlock)(NSDictionary *responseObject, NSError *error);

// --------------- 政府文件 --------------- //
static NSString *api_govFile = @"docs?";
typedef void(^SCGovFileDidCompleteBlock)(NSDictionary *responseObject, NSError *error);

// --------------- 政务信息 --------------- //
/// 人事任免
static NSString *api_personnel = @"gov-info/detail?type=1&";

/// 公示公告
static NSString *api_bulletin = @"gov-info/detail?type=2&";

/// 招考信息
static NSString *api_examination = @"gov-info/detail?type=3&";

/// 四川统计
static NSString *api_statistics = @"gov-info/detail?type=4&";

/// 计划报告
static NSString *api_plan = @"gov-info/detail?type=5&";

typedef void(^SCNormalDidCompleteBlock)(NSDictionary *responsObject, NSError *error);

/// 机构职能
static NSString *api_organization = @"gov-info/org";
typedef void(^SCOrganizationDidCompleteBlock)(NSArray *responseObject, NSError *error);
/// 机构职能子项
static NSString *api_orgList = @"gov-info/orgDetailList";
typedef void(^SCOrgListDidCompleteBlock)(NSArray *responseObject, NSError *error);
/// 机构职能详情
static NSString *api_orgDetail = @"gov-info/orgDetail?";
typedef void(^SCOrgDetailDidCompleteBlock)(NSArray *responseObject, NSError *error);


// --------------- 政府领导 --------------- //
/// 政府领导
static NSString *api_leader = @"leader";
typedef void(^SCLeaderDidCompleteBlock)(NSArray *responseObject, NSError *error);
/// 领导活动
static NSString *api_activity = @"leader/activity?type=1&";
typedef void(^SCActivityDidCompleteBlock)(NSDictionary *responseObject, NSError *error);
/// 领导讲话
static NSString *api_speech = @"leader/activity?type=2&";
typedef void(^SCSpeechDidCompleteBlock)(NSDictionary *responseObject, NSError *error);

// --------------- 图说四川 --------------- //
/// 图说四川列表
static NSString *api_photo = @"photo-sc";
typedef void(^SCPhotoDidCompleteBlock)(NSDictionary *responseObject, NSError *error);
/// 图说四川详情
static NSString *api_photoDetail = @"photo-sc/detail?";
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

/// 地图服务
static NSString *api_address = @"contacts";
typedef void(^SCAddressDidCompleteBlock)(NSArray *responseObject, NSError *error);

// --------------- 版本检测 --------------- //
static NSString *api_version = @"version";
typedef void(^SCVersionDidCompleteBlock)(NSDictionary *responseObject, NSError *error);

// --------------- 推送通知 --------------- //
static NSString *api_pushMsg = @"pushMsg";
typedef void(^SCPushMsgDidCompleteBlock)(NSDictionary *responseObject, NSError *error);
@interface ApiManager : NSObject

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;


#pragma  mark - manager
+ (ApiManager *)sharedInstance;

/// post request
- (NSURLSessionDataTask *)post:(NSString *)path
                    parameters:(id)parameters
                 completeBlock:(SCSessionTaskDidCompleteBlock)completeBlock;

/// get request
- (NSURLSessionDataTask *)get:(NSString *)path
                   parameters:(id)parameters
                completeBlock:(SCSessionTaskDidCompleteBlock)completeBlock;
@end

#import "ApiManager+Focus.h"
#import "ApiManager+Profile.h"
#import "ApiManager+GovFile.h"
#import "ApiManager+GovAffairs.h"
#import "ApiManager+Leader.h"
#import "ApiManager+Photo.h"
#import "ApiManager+Service.h"
#import "ApiManager+Push.h"
#import "ApiManager+Version.h"

