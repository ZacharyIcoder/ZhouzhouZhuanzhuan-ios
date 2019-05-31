#import "DetailCell.h"
@implementation DetailCell
{
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
    _imageview = [[UIImageView alloc]initWithFrame:CGRectMake(8*kWidthRate, 8*kHeightRate, 36*kHeightRate, 36*kHeightRate)];
    [self.contentView addSubview:_imageview];
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = kUIFont14;
    _titleLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imageview.mas_right).offset(3*kWidthRate);
        make.centerY.equalTo(_imageview);
    }];
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.font = kUIFont12;
    _contentLabel.numberOfLines = 1;
    _contentLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_right).offset(3*kWidthRate);
        make.centerY.equalTo(_imageview);
    }];
    UILabel *in = [[UILabel alloc]init];
    in.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:in];
    [in mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.mas_offset(1);
    }];
}
@end
