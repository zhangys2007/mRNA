#import <Foundation/Foundation.h>

@interface NSArray (Extend)

+ (NSMutableArray *)parseClass:(NSString *)className;
+ (NSArray *)JSONArrayyFromJSONString:(NSString *)JSONString;

@end
