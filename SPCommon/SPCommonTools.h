//
//  CommonTools.h
//  xietongwork
//
//  Created by Frcc on 15/9/3.
//  Copyright (c) 2015年 shipu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPCommonTools : NSObject

+ (NSString*)nummonthtoStr:(int)month;

+ (NSInteger)formatDateForString:(NSString *)valueTime andType:(NSInteger)dateType;

+ (NSString*)ByteConversionGBMBKB:(float)KSize;

+ (NSString*)stringByURLEncodingStringParameter:(NSString*)resultStr;

+ (NSString *)stringTableDataListJsonStringOther:(NSString *)other
                                         tableid:(NSString *)tableid
                                            page:(NSInteger)page
                                       condition:(NSString *)condition
                                         pageTag:(NSString *)pageTag
                                         orderby:(NSString *)orderby
                                       viewfield:(NSString *)viewfield
                                      orderfield:(NSString *)orderfield
                                     searchValue:(NSString *)searchValue
                                         ispower:(NSInteger)ispower
                                        Transfer:(NSString *)Transfer;
+ (BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2;
+ (NSString*)formatForDate:(NSDate*)date;
+ (NSDate*)formatForStr:(NSString*)dateStr;
+ (NSDate*)getDateForLastDay:(NSDate*)date;
+ (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate;
+ (NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month;//month -n为上n个月，+n为下n个月;
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
+ (NSString*)removenr:(NSString*)content;
+ (NSString*)base64:(NSString*)str;
+(NSString *)md5: (NSString *) str;
+(NSString *)filterHTML:(NSString *)html;

+ (NSString *)getHeadFormatter:(NSString *)formaterstr;

+ (BOOL)isDaXieStr:(NSString *)str;

@end
