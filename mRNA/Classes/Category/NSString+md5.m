#import "NSString+md5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (md5)

// RSA 
- (NSString*)md5StrXor{
    const char *myPassword = [self UTF8String];
    // 0 - 255
    unsigned char md5c[16];
    CC_MD5(myPassword, (CC_LONG)strlen(myPassword), md5c);
    // 任何一个0-255 之间的数 最多用2位16进制
    // 1111 1111  ff   1  01
    NSMutableString *md5Str = [NSMutableString  string];
    [md5Str appendFormat:@"%02x",md5c[0]];
    for(int i = 1; i < 16 ; i++){
        [md5Str appendFormat:@"%02x",md5c[i] ^ md5c[0]];
    }
    return md5Str;
}

@end











