#import <Foundation/Foundation.h>

@interface NSString (Extend)

+ (NSString *)convertByteToString:(Byte *)byte;

+ (BOOL)validateMobile:(NSString *)mobile;
+ (BOOL)validateEmail:(NSString *)emai;
+ (BOOL)validateQQ:(NSString *)qq;

// 得到 mobile 格式 xxxxxxxxxxx
+ (NSString *)getFormMobileWith:(NSString *)mobile;

// 得到mobile的格式  xxx-xxxx-xxx
+ (NSString *)getMobileFromStr:(NSString *)str;
// 去除符号-
+ (NSString *)getMobileReplaceSymbol:(NSString *)str;
+ (NSString *)stringComponentWithHead:(NSString *)head WithTail:(NSString *)tail;
+ (NSString *)getFormatterTimeWithTime:(NSString *)originTime;// 时间格式->去掉秒
+ (NSString *)getStringFormatterTimeWithTime:(NSInteger)originTime;// 时间戳转换标准时间
//+ (NSString *)getStringFormatterTimeWithTimeTime:(NSInteger)originTime;// 时间戳转换标准时间S
+ (NSString *)encodeURIComponent:(NSString *)string;
+ (NSString *)decodeURIComponent:(NSString *)string;
- (NSString *)displayTime;
+ (NSString *)getProvinceStringWithProvince:(NSString *)province City:(NSString *)city Type:(NSString *)type;
+ (id)parseStringToObject:(NSString *)str WithClass:(Class)clas;
+ (NSString *)valueForParameter:(NSString *)parameterKey WithString:(NSString *)query;
- (BOOL)isEmpty;
- (NSString *)URLEncodedString;
//是否存在表情
+ (BOOL)exist_emoji:(NSString *)text;
//获取银行卡名
+ (NSString *)getBankNameWithBankCode:(NSString *)bankCode;

@end
