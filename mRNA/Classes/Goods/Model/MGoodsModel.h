//
//  MGoodsModel.h
//  mRNA
//
//  Created by zhangys on 2017/6/27.
//  Copyright © 2017年 上海永同资产管理有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGoodsModel : NSObject

@property (nonatomic, assign) NSInteger goodsID;
@property (nonatomic, copy)   NSString * cover_image_url;
@property (nonatomic, assign) NSInteger created_at;
@property (nonatomic, copy)   NSString * describe;
@property (nonatomic, assign) NSInteger editor_id;
@property (nonatomic, assign) NSInteger favorites_count;
@property (nonatomic, strong) NSArray * image_urls;
@property (nonatomic, assign) BOOL is_favorite;
@property (nonatomic, copy)   NSString * name;
@property (nonatomic, copy)   NSString * price;
@property (nonatomic, assign) NSInteger purchase_id;
@property (nonatomic, assign) NSInteger purchase_status;
@property (nonatomic, assign) NSInteger purchase_type;
@property (nonatomic, copy)   NSString * purchase_url;
@property (nonatomic, assign) NSInteger updated_at;
@property (nonatomic, copy)   NSString * url;

@end
