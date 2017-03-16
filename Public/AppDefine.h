//
//  JusTexDefine.h
//  JusTalk
//
//  Created by Cathy on 14-6-20.
//  Copyright (c) 2014年 Cathy. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import "UIViewController+Present.h"

#define SUPPORT_ANONYMOUS

#define kMtcProductionAppKey @"6c015730e5118e0f15b44095"
#define kMtcProductionRouter @"http:router.justalkcloud.com:8080"
#define kMtcProductionAccessEntry @""
#define kMtcProductionAccessEntryChina @""

#define kMtcDevelopmentAppKey @"28ee4fa00244030f59334097"
#define kMtcDevelopmentRouter @""
#define kMtcDevelopmentAccessEntry @"sudp:182.92.66.126:9851;sudp:112.124.116.65:9851"

#define kMtcLabAppKey @"28ee4fa00244030f59334097"
#define kMtcLabRouter @"udp:121.40.103.170:8000"
#define kMtcLabAccessEntry @"sarc:1:98"

#define kMtcSoftwareVendor "Juphoon"

#define kMtcAppId 627958823
#define kIntroduceAppVersion 693101170

//分享链接替换jusauto
#define kMtcUrlInviteMessage @"http://jusauto.justalk.com"//@"https://justalk.com/?p=m"
#define kMtcUrlInviteEmail @"http://jusauto.justalk.com"//@"https://justalk.com/?p=e"
#define kMtcUrlInviteTwitter @"http://jusauto.justalk.com"//@"https://justalk.com/?p=t"
#define kMtcUrlInviteFacebook @"http://jusauto.justalk.com"//@"https://facebook.com/justalkapp"
#define kMtcUrlInviteMessenger @"http://jusauto.justalk.com"//@"https://facebook.com/justalkapp"
#define kMtcUrlInviteSinaWeibo @"http://jusauto.justalk.com"//@"https://justalk.com/?p=w"
#define kMtcUrlInviteWeChatContacts @"http://jusauto.justalk.com"//@"https://justalk.com/?p=wc"
#define kMtcUrlInviteWeChatMoments @"http://jusauto.justalk.com"//@"https://justalk.com/?p=wm"
#define kMtcUrlInviteQQ @"http://jusauto.justalk.com"//@"https://justalk.com/?p=qq"
#define kMtcUrlInviteQZone @"http://jusauto.justalk.com"//@"https://justalk.com/?p=qz"
#define kMtcUrlInviteWhatsApp @"http://jusauto.justalk.com"//@"https://justalk.com"

#define kStringJusTalkAllRightReserved LocalizedString(@"© %@ JusAuto. All rights reserved.")

#define kMtcUrlLegal @"http://jusauto.justalk.com/legal"
#define kMtcUrlTerms @"http://jusauto.justalk.com/terms"
#define kMtcUrlPrivacy @"http://jusauto.justalk.com/privacy"
#define kMtcUrlFaq @"https://justalk.com/faq"
#define kMtcUrlSurvey @"https://justalk.com/survey"
#define kMtcUrlHome @"http://jusauto.justalk.com"//@"https://justalk.com"
#define kMtcUrlUpdate @"https://justalk.com/download.php?flag=ios"

#define kMtcUrlContactUsMail @"support@justalk.com"
#define kMtcUrlContactUsFacebook @"https://facebook.com/justalkapp"
#define kMtcUrlContactUsTwitter @"https://twitter.com/JusTalkApps"
#define kMtcUrlContactUsSinaWeibo @"https://weibo.com/JusTalkApp"
#define kMtcUrlContactUsGoogle @"https://plus.google.com/u/0/communities/105503762439101226661"

#define kMtcUrlTwitterAccount @"@JusTalkApps"
#define kMtcUrlFacebookAccount @"JusTalkApp"
#define kMtcUrlSinaWeiboAccount @"JusTalk"
#define kMtcUrlGoogleAccount @"JusTalk"

#define kMtcUrlVersionCheck @"https://justalk.com/versioncheckjson/?name=com_juphoon_justalk-iphone&ext=json"

//#import <UMMobClick/MobClick.h>
//#define kUmengKey @"53e853adfd98c5062a007ee3"

#ifdef APP_STORE
#define kUmengChannel @""
#else
#ifdef DEBUG
#define kUmengChannel @"Debug"
#else
#define kUmengChannel @"Release"
#endif
#endif

#ifdef UMEvent
#undef UMEvent
#define UMEvent(e,l) if(e){[MobClick event:@e label:l];PRINT("UMEvent:%s", e)}
#endif

#ifdef UMEventDuration
#undef UMEventDuration
#define UMEventDuration(e,d) if(d){[MobClick event:e attributes:@{@"__ct__":[NSString stringWithFormat:@"%d",(int)(-[d timeIntervalSinceNow]*1000)]}];}
#endif

#ifdef UMPageBegin
#undef UMPageBegin
#define UMPageBegin(p) [MobClick beginLogPageView:p];
#endif

#ifdef UMPageEnd
#undef UMPageEnd
#define UMPageEnd(p) [MobClick endLogPageView:p];
#endif

#ifdef TrackEvent
#undef TrackEvent
#define TrackEvent(e,p) if(e){[FBSDKAppEvents logEvent:@e parameters:p];PRINT("TrackEvent:%s", e)}
#endif

#define SuppressPerformSelectorLeakWarning(code) \
    do {\
        _Pragma("clang diagnostic push") \
        _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
            code; \
        _Pragma("clang diagnostic pop") \
    } while(0)

#import <Bugly/Bugly.h>
#define kBuglyAppId @"3d9e35bb45"

#import "WXApi.h"
#define kWeChatAppId @"wxc02cb46b7e5b5a07"

#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#define kTencentAppId @"101387776"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
//#import <FBSDKLoginKit/FBSDKLoginKit.h>
//#import <FBAudienceNetwork/FBAudienceNetwork.h>
#define kFacebookAppId @"370164013190391"
#define kFacebookPlacementIdForLaunch @"370164013190391_607022572837866"
#define kFacebookPlacementIdForSupport @"370164013190391_607022572837866"
#define kFacebookPlacementIdForCallEnd @"370164013190391_642310229309100"

#define kAdMobPlacementIdForLaunch @"ca-app-pub-2808883919351804/5417027970"
#define kAdMobPlacementIdForSupport @"ca-app-pub-2808883919351804/3800693978"

#define kJuphoonReportDomain @"JuphoonReportDomain"
#define kErrorInfoDescriptionKey @"ErrorInfoDescriptionKey"
