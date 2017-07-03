#import <Foundation/Foundation.h>

@interface NSString (URL)

- (NSString *)URLStringWithStr:(NSString *)str;

+ (NSString *)needStr:(NSString *)needStr replaceStrArray:(NSArray<NSString *> *)strArr;

+ (NSString *)needStr:(NSString *)needStr replaceStrArray:(NSArray<NSString *> *)replaceStrArr withStrArr:(NSArray<NSString *> *)strArr;


@end
