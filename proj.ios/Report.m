//
//  Report.m
//  demo
//
//  Created by cheng on 16/5/19.
//
//


#import "Report.h"
#import "UMMobClick/MobClick.h"
@implementation Report

+(void)eventLevel:(NSDictionary *) dic{
    NSLog(@"ssss");
    NSString *eventId = [dic objectForKey:@"eventId"];
    NSString *num = [dic objectForKey:@"counter"];
    NSLog(@"eventId=%@,num=%@",eventId,num);
    [MobClick event:eventId attributes:@{@"step":[NSString stringWithFormat:@"%@",num]}];
    
}
+(void)eventId:(NSDictionary *) dic{
    NSString *eventId = [dic objectForKey:@"eventId"];
    [MobClick event:eventId];
}

@end