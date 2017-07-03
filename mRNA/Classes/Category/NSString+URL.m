#import "NSString+URL.h"

@implementation NSString (URL)

- (NSString *)URLStringWithStr:(NSString *)str{
    NSString *appendStr = [self stringByAppendingString:str];
    return appendStr;
}

+ (NSString *)needStr:(NSString *)needStr replaceStrArray:(NSArray<NSString *> *)strArr{
    for (NSString *str in strArr) {
        needStr = [needStr stringByReplacingOccurrencesOfString:str withString:@""];
    }
    return needStr;
}

+ (NSString *)needStr:(NSString *)needStr replaceStrArray:(NSArray<NSString *> *)replaceStrArr withStrArr:(NSArray<NSString *> *)strArr{
    
    for (int i = 0; i < strArr.count ; i++) {
        needStr = [needStr stringByReplacingOccurrencesOfString:replaceStrArr[i] withString:strArr[i]];
    }
    return needStr;
}

@end
