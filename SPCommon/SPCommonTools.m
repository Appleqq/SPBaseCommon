//
//  CommonTools.m
//  xietongwork
//
//  Created by Frcc on 15/9/3.
//  Copyright (c) 2015年 shipu. All rights reserved.
//

#import "SPCommonTools.h"
#import "CommonCrypto/CommonDigest.h"

@implementation SPCommonTools

+ (NSString*)nummonthtoStr:(int)month{
    NSString *str=@"";
    switch (month) {
        case 1:
            str = [NSString stringWithFormat:@"一月"];
            break;
        case 2:
            str = [NSString stringWithFormat:@"二月"];
            break;
        case 3:
            str = [NSString stringWithFormat:@"三月"];
            break;
        case 4:
            str = [NSString stringWithFormat:@"四月"];
            break;
        case 5:
            str = [NSString stringWithFormat:@"五月"];
            break;
        case 6:
            str = [NSString stringWithFormat:@"六月"];
            break;
        case 7:
            str = [NSString stringWithFormat:@"七月"];
            break;
        case 8:
            str = [NSString stringWithFormat:@"八月"];
            break;
        case 9:
            str = [NSString stringWithFormat:@"九月"];
            break;
        case 10:
            str = [NSString stringWithFormat:@"十月"];
            break;
        case 11:
            str = [NSString stringWithFormat:@"十一月"];
            break;
        case 12:
            str = [NSString stringWithFormat:@"十二月"];
            break;
            
        default:
            break;
    }
    
    return str;
}

+(NSInteger)formatDateForString:(NSString *)valueTime andType:(NSInteger)dateType
{
    if (!valueTime) {
        return 0;
    }
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    if (valueTime.length>10) {
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    else{
        [format setDateFormat:@"yyyy-MM-dd"];
    }
    NSDate *date = [format dateFromString:valueTime];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    comps = [calendar components:unitFlags fromDate:date];
    
    if (dateType == 1) {
        return [comps day];
    }
    else if (dateType == 2){
        return [comps month];
    }
    else if (dateType == 3){
        return [comps year];
    }
    else{
        return 0;
    }
}

+ (NSString*)ByteConversionGBMBKB:(float)KSize{
    const float GB = 1024 * 1024 * 1024;//定义GB的计算常量
    const float MB = 1024 * 1024;//定义MB的计算常量
    const float KB = 1024;//定义KB的计算常量
    if (KSize / GB >= 1)//如果当前Byte的值大于等于1GB
        return [NSString stringWithFormat:@"%.1fG",KSize/(float)GB];
    else if (KSize / MB >= 1)//如果当前Byte的值大于等于1MB
        return [NSString stringWithFormat:@"%.1fM",KSize/(float)MB];
    else if (KSize / KB >= 1)//如果当前Byte的值大于等于1KB
        return [NSString stringWithFormat:@"%.1fK",KSize/(float)KB];
    else
        return [NSString stringWithFormat:@"%.1f字节",KSize];
}

+ (NSString*)stringByURLEncodingStringParameter:(NSString*)resultStr{
    // NSURL's stringByAddingPercentEscapesUsingEncoding: does not escape
    // some characters that should be escaped in URL parameters, like / and ?;
    // we'll use CFURL to force the encoding of those
    //
    // We'll explicitly leave spaces unescaped now, and replace them with +'s
    //
    // Reference: <a href="%5C%22http://www.ietf.org/rfc/rfc3986.txt%5C%22" target="\"_blank\"" onclick='\"return' checkurl(this)\"="" id="\"url_2\"">http://www.ietf.org/rfc/rfc3986.txt</a>
        
    CFStringRef originalString = (__bridge CFStringRef) resultStr;
    CFStringRef leaveUnescaped = CFSTR(" ");
    CFStringRef forceEscaped = CFSTR("!*'();:@&=+$,/?%#[]");
    
    CFStringRef escapedStr;
    escapedStr = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                         originalString,
                                                         leaveUnescaped,
                                                         forceEscaped,
                                                         kCFStringEncodingUTF8);
    
    if( escapedStr )
    {
        NSMutableString *mutableStr = [NSMutableString stringWithString:(__bridge NSString *)escapedStr];
        CFRelease(escapedStr);
        
        // replace spaces with plusses
        [mutableStr replaceOccurrencesOfString:@" "
                                    withString:@"%20"
                                       options:0
                                         range:NSMakeRange(0, [mutableStr length])];
        resultStr = mutableStr;
    }
    return resultStr;
}

/*
 other	不详，都是传空，好像没用
 tableid	表英文名，如u_table30
 page	页码（现在服务器设定每页1000条）
 condition	附加查询条件，先做base64编码，再做url编码
 pageTag	貌似没用
 orderby	排序方式
 viewfield	显示字段
 orderfield	排序字段
 searchValue	查询条件（跟viewfield对应）
 ispower	是否受权限控制
 Transfer	貌似没用
 */

+ (NSString *)stringTableDataListJsonStringOther:(NSString *)other tableid:(NSString *)tableid page:(NSInteger)page condition:(NSString *)condition pageTag:(NSString *)pageTag orderby:(NSString *)orderby viewfield:(NSString *)viewfield orderfield:(NSString *)orderfield searchValue:(NSString *)searchValue ispower:(NSInteger)ispower Transfer:(NSString *)Transfer {
    
    NSString *conditionStr = @"";
    if (![condition isEqualToString:@""]) {
        conditionStr = [SPCommonTools stringByURLEncodingStringParameter:[[condition dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0]];
    }
    NSString *jsonStr = [NSString stringWithFormat:@"{\"other\":\"%@\",\"tableid\":\"%@\",\"page\":\"%ld\",\"condition\":\"%@\",\"pageTag\":\"%@\",\"orderby\":\"%@\",\"viewfield\":\"%@\",\"orderfield\":\"%@\",\"searchValue\":\"%@\",\"ispower\":\"%ld\",\"Transfer\":\"%@\"}",other,tableid,page,conditionStr,pageTag,orderby,viewfield,orderfield,searchValue,ispower,Transfer];
    
    return jsonStr;
}

+ (BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    return [comp1 day] == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}

+(NSString*)formatForDate:(NSDate*)date
{
    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
    [dateformat setDateFormat:@"yyyy-MM-dd"];
    
    NSString *dateStr = [dateformat stringFromDate:date];
    return dateStr;
}

+(NSDate*)formatForStr:(NSString*)dateStr
{
    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
    if (dateStr.length > 10) {
        [dateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    else{
        [dateformat setDateFormat:@"yyyy-MM-dd"];
    }
    
    NSDate* date = [dateformat dateFromString:dateStr];
    return date;
}

+(NSDate*)getDateForLastDay:(NSDate*)date
{
    
    
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    
    NSRange daysRange =
    
    [currentCalendar
     
     rangeOfUnit:NSDayCalendarUnit
     
     inUnit:NSMonthCalendarUnit
     
     forDate:date];
    
    
    
    // daysRange.length will contain the number of the last day
    
    // of the month containing curDate
    
    NSMutableString *str = [NSMutableString stringWithFormat:@"%@",[SPCommonTools formatForDate:date]];
    [str replaceCharactersInRange:NSMakeRange(str.length-2, 2) withString:[NSString stringWithFormat:@"%lu",daysRange.length]];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyy-MM-dd"];
    NSDate *result = [dateFormat dateFromString:str];
    return result;
}

+ (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    return destinationDateNow;
}

+(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month

{
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    [comps setMonth:month];
    
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    
    return mDate;
    
}

+ (NSString*)dictionaryToJson:(NSDictionary *)dic{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    jsonString = [jsonString stringByReplacingOccurrencesOfString:@" " withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return jsonString;
    
}

+ (NSString*)removenr:(NSString*)content{
    
    // Strange New lines:
    //  Next Line, U+0085
    //  Form Feed, U+000C
    //  Line Separator, U+2028
    //  Paragraph Separator, U+2029
    
    // Scanner
    NSScanner *scanner = [[NSScanner alloc] initWithString:content];
    [scanner setCharactersToBeSkipped:nil];
    NSMutableString *result = [[NSMutableString alloc] init];
    NSString *temp;
    NSCharacterSet*newLineAndWhitespaceCharacters = [ NSCharacterSet newlineCharacterSet];
    // Scan
    while (![scanner isAtEnd]) {
        
        // Get non new line or whitespace characters
        temp = nil;
        [scanner scanUpToCharactersFromSet:newLineAndWhitespaceCharacters intoString:&temp];
        if (temp) [result appendString:temp];
        
        // Replace with a space
        if ([scanner scanCharactersFromSet:newLineAndWhitespaceCharacters intoString:NULL]) {
            if (result.length > 0 && ![scanner isAtEnd]) // Dont append space to beginning or end of result
                [result appendString:@" "];
        }
    }
    
    // Return
    NSString *retString = [NSString stringWithString:result];
    
    return retString;

}

+ (NSString *)base64:(NSString *)str{
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

+(NSString *) md5: (NSString *) str
{
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}
+(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    return html;
}
+ (NSString *)getHeadFormatter:(NSString *)formaterstr {

    NSString *string = [NSString stringWithFormat:@"%@:",formaterstr];
    return string;
}
+ (BOOL)isDaXieStr:(NSString *)str {
    if ([str hasPrefix:@"壹"]) {
        return YES;
    }
    if ( [str hasPrefix:@"贰"]) {
        return YES;
    }
    if ([str hasPrefix:@"叁"]) {
        return YES;
    }
    if ([str hasPrefix:@"肆"]) {
        return YES;
    }
    if ([str hasPrefix:@"伍"]) {
        return YES;
    }
    if ([str hasPrefix:@"陆"]) {
        return YES;
    }
    if ([str hasPrefix:@"柒"]) {
        return YES;
    }
    if ([str hasPrefix:@"捌"]) {
        return YES;
    }
    if ([str hasPrefix:@"玖"]) {
        return YES;
    }
    if ([str hasPrefix:@"￥"]) {
        return YES;
    }
    if ([str containsString:@"￥"]) {
        return YES;
    }
    if ([str hasPrefix:@"<b>\￥</b>"]) {
        return YES;
    }
    return NO;
}

+ (NSString *)documentFolderPath
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}

@end
