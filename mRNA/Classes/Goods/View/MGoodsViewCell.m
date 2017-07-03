//
//  MGoodsViewCell.m
//  mRNA
//
//  Created by zhangys on 2017/6/26.
//  Copyright © 2017年 上海永同资产管理有限公司. All rights reserved.
//

#import "MGoodsViewCell.h"

@implementation MGoodsViewCell

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self addSubview:self.bgImageView];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-60);
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgImageView.mas_bottom);
        make.left.equalTo(self).offset(5);
        make.right.equalTo(self).offset(-5);
    }];
    
    [self addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self).offset(5);
        make.right.equalTo(self).offset(-5);
    }];
}

- (UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [UILabel new];
        _priceLabel.backgroundColor = RandomColor;
        _priceLabel.textColor = THEMEColor;
        _priceLabel.textAlignment = NSTextAlignmentRight;
        _priceLabel.font = FONT16;
    }
    return _priceLabel;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.backgroundColor = RandomColor;
        _titleLabel.numberOfLines = 2;
        _titleLabel.font = FONT18;
    }
    return _titleLabel;
}

- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [UIImageView new];
        _bgImageView.backgroundColor = RandomColor;
    }
    return _bgImageView;
}

@end
