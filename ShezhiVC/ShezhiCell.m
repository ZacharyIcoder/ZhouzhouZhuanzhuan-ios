#import "ShezhiCell.h"
@implementation ShezhiCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configCell];
    }
    return self;
}
- (void) configCell {
    self.contentView.backgroundColor = KUIColorFontColor_LV;
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = kUIFont18;
    _titleLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15*kWidthRate);
        make.centerY.equalTo(self.contentView);
    }];
    _imageview = [[UIImageView alloc]initWithFrame:CGRectMake(KUIScreenWidth - 55*kWidthRate, 8*kHeightRate, 36*kHeightRate, 36*kHeightRate)];
    [self.contentView addSubview:_imageview];
    UILabel *in = [[UILabel alloc]init];
    in.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:in];
    [in mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.mas_offset(1);
    }];
}
@end
