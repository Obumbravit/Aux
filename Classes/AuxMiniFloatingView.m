#import "AuxMiniFloatingView.h"

@implementation AuxMiniFloatingView

- (id)init
{
  self = [super init];
  self.frame = CGRectMake(0, 0, 40, 40);

  self.backgroundBlur.frame = self.frame;
  self.backgroundBlur.layer.cornerRadius = 16;

  self.mediaImageView.frame = CGRectMake(7.5, 7.5, 25, 25);
  self.mediaImageView.layer.cornerRadius = 6;
}

@end
