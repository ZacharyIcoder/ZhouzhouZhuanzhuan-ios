#import "HomeCCell.h"
static CGFloat topGap = 10;
static CGFloat leftGap = 10;
static CGFloat bottomGap = 10;
static CGFloat rightGap = 10;
static CGFloat lineSpace = 10.f;
static CGFloat InteritemSpace = 10.f;
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
@implementation HomeCCell
    - (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configCell];
    }
    return self;
    }
    - (void) configCell {
        CGFloat iw = floorf((kWidth - leftGap - rightGap - InteritemSpace * 2) / 3);
        _imageview = [[UIImageView alloc]init];
        _imageview.image = [UIImage imageNamed:@"蛋糕店"];
        _imageview.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imageview];
        [_imageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(10);
            make.left.equalTo(self.contentView).offset(15);
            make.right.equalTo(self.contentView).offset(-15);
            make.height.mas_offset(iw - 30);
        }];
        int R = (arc4random() % 256) ;
        int G = (arc4random() % 256) ;
        int B = (arc4random() % 256) ;
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];
        _titleLabel.font = kUIFont16;
        _titleLabel.text = @"123";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.contentView);
            make.top.equalTo(self->_imageview.mas_bottom);
        }];
    }
    - (void)setImageview:(UIImageView *)imageview {
    }
    - (void)setTitleLabel:(UILabel *)titleLabel {
    }
@end
