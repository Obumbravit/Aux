#import "AuxBarView.h"

@implementation AuxBarView

- (id)init
{
  self = [super init];
  self.notched = ([UIApplication sharedApplication].windows[0].safeAreaInsets.bottom) ? YES : NO;
  self.frame = (self.notched) ? CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44) : CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width / 3, 20);

  self.backgroundBlur.frame = self.frame;
  self.backgroundBlur.layer.cornerRadius = 0;

  if (self.notched)
  {
    self.mediaImageView.frame = CGRectMake(30, 4.5, 35, 35);
    self.mediaImageView.layer.cornerRadius = 8.4;

    self.mediaLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 80, 4.5, 70, 35);
  }
  else
  {
    self.mediaImageView.frame = CGRectMake(16, 2, 16, 16);
    self.mediaImageView.layer.cornerRadius = 3.84;

    self.mediaLabel.frame = CGRectMake(self.backgroundBlur.bounds.size.width - 86, 2, 70, 16);
  }

  self.roundedBarCornersMask = [CAShapeLayer layer];
  self.roundedBarCornersMask.path = [UIBezierPath bezierPathWithRoundedRect:auxBlur.bounds byRoundingCorners: UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10.56, 10.56)].CGPath;
  if (self.roundedBarCorners) self.backgroundBlur.layer.mask = self.roundedBarCornersMask;
  else self.backgroundBlur.layer.mask = nil;
}

@end
