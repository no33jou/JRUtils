//
//  JRDateFormatter.m
//  RWAssistant
//
//  Created by 姚俊任 on 2016/12/10.
//  Copyright © 2016年 韩鹏帅. All rights reserved.
//

#import "JRDateFormatter.h"
#import <EventKit/EventKit.h>
@interface JRDateFormatter()
@property(nonatomic,strong)NSDateFormatter *formatter;
@property(nonatomic,strong)NSCalendar *chineseCalendar;
@property(nonatomic,strong)EKEventStore *store;
@property (strong, nonatomic) NSArray<NSString *> *lunarChars;
@end

@implementation JRDateFormatter
+ (instancetype)dateFormatter{
    static dispatch_once_t onceToken;
    static JRDateFormatter *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:nil]init];
    });
    return instance;
}
#pragma mark - public method
- (NSString *)getDateStr:(NSString *)formatter date:(NSDate *)date{
    [self.formatter setDateFormat:formatter];
    return [self.formatter stringFromDate:date];
}
- (NSTimeInterval)getDateStr:(NSString *)formatter  str:(NSString *)str{
    [self.formatter setDateFormat:formatter];
    return [[self.formatter dateFromString:str] timeIntervalSince1970];
}
- (NSDate *)getDate:(NSString *)formatter str:(NSString *)str{
    [self.formatter setDateFormat:formatter];
    return[self.formatter dateFromString:str];
}
- (NSString *)getDateStr:(NSString *)formatter timestamp:(id)timestamp{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue] / 1000.0];
    return [self getDateStr:formatter date:date];
}
- (NSString *)getToday:(NSDate *)date{
    if([[NSCalendar currentCalendar] isDateInToday:date]){
        return @"今天";
    }
    if ([[NSCalendar currentCalendar] isDateInYesterday:date]) {
        return @"明天";
    }
    if ([[NSCalendar currentCalendar] isDateInTomorrow:date]) {
        return @"昨天";
    }
    return nil;
}
- (NSString *)getWeek:(NSDate *)date{
    return [[NSCalendar currentCalendar] weekdaySymbols][[[NSCalendar currentCalendar] component:NSCalendarUnitWeekday fromDate:date]-1 ];
}
- (NSString *)getChineseCalendar:(NSDate *)date{
    NSInteger lunarDay = [self.chineseCalendar component:NSCalendarUnitDay fromDate:date];
    return self.lunarChars[lunarDay - 1];
}
//- (NSString *)get:(NSDate *)date{
//    __weak typeof(self) weakSelf = self;
//    [self.store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
//        if(granted) {
//            NSDate *startDate = date; // 开始日期
//            NSDate *endDate = date; // 截止日期
//            NSPredicate *fetchCalendarEvents = [self.store predicateForEventsWithStartDate:startDate endDate:endDate calendars:nil];
//            NSArray<EKEvent *> *eventList = [self.store eventsMatchingPredicate:fetchCalendarEvents];
//            NSArray<EKEvent *> *events = [eventList filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(EKEvent * _Nullable event, NSDictionary<NSString *,id> * _Nullable bindings) {
//                return event.calendar.subscribed;
//            }]];
//            weakSelf.events = events;
//        }];
//}
#pragma mark - set/get
- (NSDateFormatter *)formatter{
    if (_formatter == nil) {
        _formatter = [[NSDateFormatter alloc]init];
    }
    return _formatter;
}
- (NSCalendar *)chineseCalendar{
    if (_chineseCalendar == nil) {
        _chineseCalendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
    }
    return _chineseCalendar;
}
- (NSArray<NSString *> *)lunarChars{
    return @[@"初一",@"初二",@"初三",@"初四",@"初五",@"初六",@"初七",@"初八",@"初九",@"初十",@"十一",@"十二",@"十三",@"十四",@"十五",@"十六",@"十七",@"十八",@"十九",@"二十",@"二一",@"二二",@"二三",@"二四",@"二五",@"二六",@"二七",@"二八",@"二九",@"三十"];
}
@end
