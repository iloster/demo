//
//  WeiXin.m
//  cube
//
//  Created by cheng on 16/6/16.
//
//

#import "WeiXin.h"
#import "WXApi.h"
@implementation WeiXin

+(void)onShare:(NSDictionary *)attributes{
    NSLog(@"onShare");

    //创建发送对象实例
    SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
    sendReq.bText = NO;//不使用文本信息
    sendReq.scene = 1;//0 = 好友列表 1 = 朋友圈 2 = 收藏
    
    //创建分享内容对象
    WXMediaMessage *urlMessage = [WXMediaMessage message];
    NSString *desc = [attributes objectForKey:@"desc"];
    urlMessage.title = desc;//分享标题
    urlMessage.description = @"description";//分享描述
    [urlMessage setThumbImage:[UIImage imageNamed:@"Icon-40"]];//分享图片,使用SDK的setThumbImage方法可压缩图片大小
    
    //创建多媒体对象
    WXWebpageObject *webObj = [WXWebpageObject object];
    webObj.webpageUrl = @"https://itunes.apple.com/cn/app/id1118925938";//分享链接
    
    //完成发送对象实例
    urlMessage.mediaObject = webObj;
    sendReq.message = urlMessage;
    
    //发送分享信息
    [WXApi sendReq:sendReq];
}

@end