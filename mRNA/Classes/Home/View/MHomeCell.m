//
//  MHomeCell.m
//  mRNA
//
//  Created by zhangys on 2017/6/22.
//  Copyright © 2017年 上海永同资产管理有限公司. All rights reserved.
//

#import "MHomeCell.h"

@implementation MHomeCell

- (void)layoutSubviews{
    [super layoutSubviews];
    [self addSubview:self.bgImage];
    [self.bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self);
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.bottom.equalTo(self).offset(-5);
        make.width.offset(30 * autoSizeScaleY);
    }];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.backgroundColor = RandomColor;
        _titleLabel.font = FONT18;
    }
    return _titleLabel;
}

- (UIImageView *)bgImage{
    if (!_bgImage) {
        _bgImage = [UIImageView new];
        _bgImage.layer.cornerRadius = 8;
        _bgImage.layer.masksToBounds = YES;
    }
    return _bgImage;
}

@end
