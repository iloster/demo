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

+(void)event:(NSDictionary *) dic{
    NSLog(@"ssss");
    NSString *eventId = [dic objectForKey:@"eventId"];
    NSString *level = [dic objectForKey:@"level"];
    NSString *num = [dic objectForKey:@"counter"];
    NSLog(@"eventId=%@,level=%@,num=%@",eventId,level,num);
    [MobClick event:@"level" attributes:@{@"level":[NSString stringWithFormat:@"%@",level],@"step":[NSString stringWithFormat:@"%@",num]}];
    
}

@end