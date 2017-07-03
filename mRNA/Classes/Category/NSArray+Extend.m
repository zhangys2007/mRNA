#import "NSArray+Extend.h"
#import <objc/message.h>

@implementation NSArray (Extend)

+ (NSMutableArray *)parseClass:(NSString *)className{
    NSMutableArray *array = [NSMutableArray array];
    unsigned int outCount, i;
    id objectClass = objc_getClass([className UTF8String]);
    objc_property_t *properties = class_copyPropertyList(objectClass, &outCount);
    if(properties){
        for (i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            NSString *key = [NSString stringWithUTF8String:property_getName(property)];
            [array addObject:key];
        }
        free(properties);
    }
    return array;
}

+ (NSArray *)JSONArrayyFromJSONString:(NSString *)JSONString{
    NSData *data = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *responseArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    return responseArray;
}

@end
