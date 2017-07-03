#import "NSDictionary+Extend.h"
#import "NSArray+Extend.h"

@implementation NSDictionary (Extend)

// 将 对象转换为 json 格式的字符串
// warn object must dictionary ......
+ (NSString*) convertObjectToJson:(NSObject*) object{
    NSError *writeError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&writeError];
    if (writeError != nil) {
        NSLog(@"error : %@", writeError);
        return  [writeError description];
    }
    NSString *result = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return result;
}

// 解析对象时,讲对应 ID 转为 id
+ (NSMutableDictionary *)parseObjectExceptionid:(id)object{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSString *className = [[object class] description];
    [dictionary setValue:className forKey:@"className"];
    NSMutableArray *keys = [NSArray parseClass:className];
    for (NSString *key in keys) {
        id value = [object valueForKey:key];
        if ([key isEqualToString:@"ID"]) {
            [dictionary setValue:value forKey:@"id"];
        }else{
            [dictionary setValue:value forKey:key];
        }
    }
    return dictionary;
}

+ (id)reverseFromJsonToObject:(NSString *)jsonStr toClass:(Class)cla{
    NSDictionary *dictionary = [self JSONDictionaryFromJSONString:jsonStr];
    id resultObject = [[cla alloc] init];
    NSArray *keys = [dictionary allKeys];
    NSArray *properties = [NSArray parseClass:[cla description]];
    for(NSString *key in keys){
        if ([key isEqualToString:@"className"])continue;
        NSString *ID = nil;
        if (![properties containsObject:key]) {
            if ([key isEqual:@"id"]) { // server id == client ID
                ID = @"ID";
            }else{
                continue;
            }
        }
        @try {
            id value = [dictionary valueForKey:key];
            if (value) {
                [resultObject setValue:value forKey:ID?ID:key];
            }
        }
        @catch (NSException *exception) {
            NSLog(@"%@", exception);
        }
        @finally {
        }
    }
    return resultObject;
}

+ (NSMutableDictionary *)parseObject:(id)object{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSString *className = [[object class] description];
    [dictionary setValue:className forKey:@"className"];
    NSMutableArray *keys = [NSArray parseClass:className];
    for (NSString *key in keys) {
        id value = [object valueForKey:key];
        [dictionary setValue:value forKey:key];
    }
    return dictionary;
}

+ (id)reverseFromDictionaryToObject:(NSDictionary *)dictionary withClass:(Class)cla{
    id obj = [[cla alloc] init];
    NSArray *properties = [NSArray parseClass:[cla description]];
    if (!dictionary || [dictionary class] == [NSNull class]) {
        return nil;
    }
    NSArray *keys = [dictionary allKeys];
    for (NSString *key in keys) {
        if ([key isEqualToString:@"className"]) continue;
        if (![properties containsObject:key]) continue;
        id value = [dictionary valueForKey:key];
        if (value == [NSNull null] || value == nil) continue;
        [obj setValue:value forKey:key];
    }
    return obj;
}

+ (NSDictionary *)JSONDictionaryFromJSONString:(NSString *)JSONString{
    NSData *data = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    return responseDictionary;
}

@end
