#import "ListCell.h"
@implementation ListCell
{
    UILabel *titleLabel;
    UILabel *addressLabel;
    UILabel *leixingLabel;
    UILabel *distanceLabel;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configCell];
    }
    return self;
}
- (void) configCell {
    self.contentView.backgroundColor = KUIColorFontColor_LV;
    leixingLabel = [[UILabel alloc]init];
    leixingLabel.textColor = [UIColor whiteColor];
    leixingLabel.font = kUIFont14;
    [self.contentView addSubview:leixingLabel];
    [leixingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10*kWidthRate);
        make.top.equalTo(self.contentView).offset(8*kHeightRate);
    }];
    titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:16*kWidthRate];
    titleLabel.numberOfLines = 2;
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10*kWidthRate);
        make.right.equalTo(self->leixingLabel.mas_left).offset(3*kWidthRate);
        make.top.equalTo(self.contentView).offset(8*kHeightRate);
    }];
    addressLabel = [[UILabel alloc]init];
    addressLabel.textColor = [UIColor whiteColor];
    addressLabel.font = kUIFont14;
    addressLabel.numberOfLines = 2;
    [self.contentView addSubview:addressLabel];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10*kWidthRate);
        make.top.equalTo(self->titleLabel.mas_bottom).offset(15*kHeightRate);
        make.right.equalTo(self.contentView).offset(-10*kWidthRate);
    }];
    distanceLabel = [[UILabel alloc]init];
    distanceLabel.textColor = [UIColor whiteColor];
    distanceLabel.font = kUIFont14;
    [self.contentView addSubview:distanceLabel];
    [distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10*kWidthRate);
        make.bottom.equalTo(self.contentView).offset(-13*kHeightRate);
    }];
    UILabel *lineLabel = [[UILabel alloc]init];
    lineLabel.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:lineLabel];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_offset(5);
    }];
}
- (void) setData:(NSDictionary *)dic {
    titleLabel.text = dic[@"name"];
    addressLabel.text = dic[@"address"];
    NSDictionary *infoDic = dic[@"detail_info"];
    leixingLabel.text = infoDic[@"tag"];
    distanceLabel.text = [NSString stringWithFormat:@"%@ m",infoDic[@"distance"]];
}
@end
