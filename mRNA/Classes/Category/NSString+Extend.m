#import "NSString+Extend.h"
#define  TATOLLENGHT    23

@implementation NSString (Extend)

+ (NSString *)convertByteToString:(Byte *)byte{
    NSMutableString *result = [NSMutableString string];
    int len = strlen((char *)byte);
    for (int i = 0; i < len; i++) {
        [result appendFormat:@"%d", byte[i]];
    }
    return result;
}

//手机号码验证
+ (BOOL)validateMobile:(NSString *)mobile{
    NSString *phoneRegex = @"^(\\+86)?((13[0-9])|(14[0-9])|(15[0-9])|(17[0-9])|(18[0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

//邮箱
+ (BOOL)validateEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

// 纯数字
+ (BOOL)validateQQ:(NSString *)qq{
    NSString *qqRegex = @"[1-9]\\d{4,}";
    NSPredicate *qqTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", qqRegex];
    return [qqTest evaluateWithObject:qq];
}

// 时间格式->去掉秒
+ (NSString *)getFormatterTimeWithTime:(NSString *)originTime{
    NSRange range = [originTime rangeOfString:@":00" options:NSBackwardsSearch];
    if (range.location) {
        return [originTime substringToIndex:range.location];
    }
    return originTime;
}

+ (NSString *)getStringFormatterTimeWithTime:(NSInteger)originTime{
//    时间戳转时间的方法:
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:originTime / 1000];
    NSString * confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
}

//+ (NSString *)getStringFormatterTimeWithTimeTime:(NSInteger)originTime{
//    //    时间戳转时间的方法:
//    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
//    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
//    [formatter setTimeZone:timeZone];
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
//    [formatter setDateFormat:@"yyyy/MM/dd HH:ss"];
//    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:originTime / 1000];
//    NSString * confromTimespStr = [formatter stringFromDate:confromTimesp];
//    
//    return confromTimespStr;
//}

// 得到mobile的格式  xxx-xxxx-xxx
+ (NSString *)getFormMobileWith:(NSString *)mobile{
    if (![NSString validateMobile:mobile]) {
        return mobile;
    }
    if (!mobile || [mobile isEqual:@""])return @"";
    NSString *oneStr = [mobile substringWithRange:NSMakeRange(0, 3)];
    NSString *twoStr = [mobile substringWithRange:NSMakeRange(3, 4)];
    NSString *thereStr = [mobile substringWithRange:NSMakeRange(7, 4)];
    NSMutableString *result = [[NSMutableString alloc] init];
    [result appendFormat:@"%@-%@-%@",oneStr,twoStr,thereStr];
    oneStr = nil;
    twoStr = nil;
    thereStr = nil;
    return result;
}

// 得到 mobile 格式 xxxxxxxxxxx
+ (NSString *)getMobileFromStr:(NSString *)str{
    NSMutableString *result = [[NSMutableString alloc] init];
    
    NSString *prefixString = [str substringWithRange:NSMakeRange(0, 3)];
    if ([prefixString isEqualToString:@"+86"]) {
        NSString *oneStr = [str substringWithRange:NSMakeRange(0+3, 3)];
        NSString *twoStr = [str substringWithRange:NSMakeRange(3+3, 4)];
        NSString *thereStr = [str substringWithRange:NSMakeRange(7+3, 4)];
        [result appendFormat:@"%@%@%@",oneStr,twoStr,thereStr];
        oneStr = nil;
        twoStr = nil;
        thereStr = nil;

    } else {
        if (str.length < 11) {
            return str;
        }
        
        NSString *oneStr = [str substringWithRange:NSMakeRange(0, 3)];
        NSString *twoStr = [str substringWithRange:NSMakeRange(3, 4)];
        NSString *thereStr = [str substringWithRange:NSMakeRange(7, 4)];
        [result appendFormat:@"%@%@%@",oneStr,twoStr,thereStr];

        oneStr = nil;
        twoStr = nil;
        thereStr = nil;
    }
    
    return result;
}

//是否存在表情
+ (BOOL)exist_emoji:(NSString *)text{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSTextCheckingResult *firstMatch = [regex firstMatchInString:text options:0 range:NSMakeRange(0, [text length])];
    
    if (firstMatch) {
        NSRange resultRange = [firstMatch rangeAtIndex:0];
        NSString *result=[text substringWithRange:resultRange];
        NSLog(@"exist_emoji : %@",result);
        return YES;
    }
    return NO;
}


+ (NSString *)getMobileReplaceSymbol:(NSString *)str{
    str = [str stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return str;
}

+ (NSString *)stringComponentWithHead:(NSString *)head WithTail:(NSString *)tail{
    NSMutableString *result = [[NSMutableString alloc] init];
    [result appendFormat:@"%@",head];
    NSInteger leftLenght = TATOLLENGHT - result.length - tail.length;
    for (int i = 0; i < leftLenght; i++) {
        [result appendFormat:@"%@",@" "];
    }
    [result appendFormat:@"%@",tail];
    head = nil;
    tail = nil;
    return result;
}

+ (NSURL *)NSStringConvertNSURL:(NSString *)url{
    NSString *usrString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [NSURL URLWithString:usrString];
}

+ (NSString *)NSURLConvertNSString:(NSURL *)url{
    return [[url absoluteString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (NSString *)NSDataConvertNSString:(NSData *)data{
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (BOOL)isEmpty{
    return (self == nil ||
            ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqual:@""]));
}

+ (NSString *)encodeURIComponent:(NSString *)string{
    NSString *s = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return s;
}

+ (NSString *)decodeURIComponent:(NSString *)string{
    NSString *s = [string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return s;
}

- (NSString *)displayTime{
    NSArray *times = [self componentsSeparatedByString:@":"];
    NSString *hourString= times[0];
    if ([times[0] length] == 1) {
        hourString = [NSString stringWithFormat:@"0%@", times[0]];
    }
    NSString *timeToSet = [NSString stringWithFormat:@"%@:%@", hourString, times[1]];
    
    return timeToSet;
}

+ (NSString *)getProvinceStringWithProvince:(NSString *)province City:(NSString *)city Type:(NSString *)type{
    NSMutableString *string = [[NSMutableString alloc] init];
    if (province && city) {
        if ([province isEqualToString:city]) {
            [string appendString:province];
        }else{
            [string appendString:province];
            [string appendString:city];
        }
    }
    
    if (type) {
        if ([type containsString:@"中国"]) {
            type = [type stringByReplacingOccurrencesOfString:@"中国" withString:@""];
        }
        [string appendString:type];
    }
    
    if ([string isEqualToString:@""]) {
        [string appendString:@"未知"];
    }
    string = (NSMutableString *)[string stringByReplacingOccurrencesOfString:@" " withString:@""];
    string = (NSMutableString *)[string stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    return string;
}

//+ (id)parseStringToObject:(NSString *)str WithClass:(Class)clas{
//    //id obj = [[clas alloc] init];
//    //NSData *tempData = [str dataUsingEncoding:NSUTF8StringEncoding];
//    //NSString *returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
//    
//    NSDictionary *dict = [NSString parameters:str];
//    
//    id returnObj = [NSDictionary reverseFromDictionaryToObject:dict withClass:[clas class]];
//    
//    return returnObj;
//}

+ (NSDictionary *)parameters:(NSString *)query{
    NSMutableDictionary * parametersDictionary = [NSMutableDictionary dictionary];
    NSArray * queryComponents = [query componentsSeparatedByString:@"&"];
    for (NSString * queryComponent in queryComponents) {
        NSString * key = [queryComponent componentsSeparatedByString:@"="].firstObject;
        NSString * value = [queryComponent substringFromIndex:(key.length + 1)];
        [parametersDictionary setObject:value forKey:key];
    }
    return parametersDictionary;
}

+ (NSString *)valueForParameter:(NSString *)parameterKey WithString:(NSString *)query{
    NSString *str = [[NSString parameters:query] objectForKey:parameterKey];
    
    NSData *tempData = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSString *returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    
    return returnStr;
}

- (NSString *)URLEncodedString{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                              NULL,
                                                              kCFStringEncodingUTF8));
    return encodedString;
}

+ (NSString *)getBankNameWithBankCode:(NSString *)bankCode{
    if ([bankCode isEqualToString:@"ICBC"]){
        return @"工商银行 (储蓄卡)";
    }else if ([bankCode isEqualToString:@"ABC"]) {
        return @"农业银行 (储蓄卡)";
    }else if ([bankCode isEqualToString:@"CCB"]){
        return @"建设银行 (储蓄卡)";
    }else if ([bankCode isEqualToString:@"BOC"]){
        return @"中国银行 (储蓄卡)";
    }else if ([bankCode isEqualToString:@"CEB"]){
        return @"光大银行 (储蓄卡)";
    }else if ([bankCode isEqualToString:@"CMB"]){
        return @"招商银行 (储蓄卡)";
    }else if ([bankCode isEqualToString:@"CMBC"]){
        return @"民生银行 (储蓄卡)";
    }else if ([bankCode isEqualToString:@"BOCOM"]){
        return @"交通银行 (储蓄卡)";
    }else if ([bankCode isEqualToString:@"CIB"]){
        return @"兴业银行 (储蓄卡)";
    }else if ([bankCode isEqualToString:@"CITIC"]){
        return @"中信银行 (储蓄卡)";
    }else if ([bankCode isEqualToString:@"PINGAN"]){
        return @"平安银行 (储蓄卡)";
    }else if ([bankCode isEqualToString:@"BOS"]){
        return @"上海银行 (储蓄卡)";
    }else if ([bankCode isEqualToString:@"CBHB"]){
        return @"渤海银行 (储蓄卡)";
    }else if ([bankCode isEqualToString:@"PSBC"]){
        return @"中国邮政储蓄银行 (储蓄卡)";
    }else if ([bankCode isEqualToString:@"SPDB"]){
        return @"浦东发展银行 (储蓄卡)";
    }else if ([bankCode isEqualToString:@"SDB"]){
        return @"深圳发展银行 (储蓄卡)";
    }else if ([bankCode isEqualToString:@"BJRCB"]){
        return @"北京农村商业银行 (储蓄卡)";
    }else if ([bankCode isEqualToString:@"CMBC"]){
        return @"民生银行 (储蓄卡)";
    }
    return nil;
}

@end
