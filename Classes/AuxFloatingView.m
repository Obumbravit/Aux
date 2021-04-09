#import "AuxFloatingView.h"

@implementation AuxFloatingView

- (id)init
{
  self = [super init];
  self.frame = CGRectMake(0, 0, 150, 40);

  self.backgroundBlur.frame = self.frame;
  self.backgroundBlur.layer.cornerRadius = 16;

  self.mediaImageView.frame = CGRectMake(12.5, 7.5, 25, 25);
  self.mediaImageView.layer.cornerRadius = 6;

  self.mediaLabel.frame = CGRectMake(42.5, 7.5, 95, 25);
}

@end
