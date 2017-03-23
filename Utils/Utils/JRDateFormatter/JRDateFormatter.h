//
//  JRDateFormatter.h
//  RWAssistant
//
//  Created by 姚俊任 on 2016/12/10.
//  Copyright © 2016年 韩鹏帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JRDateFormatter : NSObject
+ (instancetype)dateFormatter;
- (NSString *)getDateStr:(NSString *)formatter date:(NSDate *)date;
- (NSTimeInterval)getDateStr:(NSString *)formatter  str:(NSString *)str;

- (NSDate *)getDate:(NSString *)formatter str:(NSString *)str;

/**
 时间戳转换

 @param formatter 时间格式
 @param timestamp 只接受NSString和NSNumber类型  JAVA类型的时间戳要 函数内部已经除以1000
 @return 时间字符串
 */
- (NSString *)getDateStr:(NSString *)formatter timestamp:(id)timestamp;
- (NSString *)getWeek:(NSDate *)date;
// 返回"今天","明天",如不符合返回nil
- (NSString *)getToday:(NSDate *)date;
// "初一",@"初二",@"初三"
- (NSString *)getChineseCalendar:(NSDate *)date;
@end
