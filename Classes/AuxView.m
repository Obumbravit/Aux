#include "AuxView.h"

@implementation AuxView

- (id)init
{
  self = [super init];

  self.backgroundBlur = [NSClassFromString(@"MTMaterialView")materialViewWithRecipe:1 configuration:1];
  self.backgroundBlur.clipsToBounds = YES;
  self.backgroundBlur.userInteractionEnabled = NO;

  self.mediaImageView = [[UIImageView alloc] initWithImage:nil];
  self.mediaImageView.clipsToBounds = YES;
  self.mediaImageView.userInteractionEnabled = NO;

  [self addSubview:self.backgroundBlur];
  [self addSubview:self.mediaImageView];
}

- (void)setMediaImagePlaceholder:(UIImage *)arg1
{
  _mediaImagePlaceholder = arg1;

  if (!self.isPlaying) self.mediaImageView.image = arg1;
}

- (void)updateForUserInterfaceStyle:(long long)userInterfaceStyle
{
  UIColor * userInterfaceStyleColor = (userInterfaceStyle == UIUserInterfaceStyleDark) ? [UIColor lightGrayColor] : [UIColor darkGrayColor];
  switch (self.style)
  {
    case 4:
      self.timestampLabel.textColor = userInterfaceStyleColor;
      self.volumeLabel.textColor = userInterfaceStyleColor;
    case 1:
    case 3:
      self.mediaLabel.textColor = userInterfaceStyleColor;
      break;
  }
}

@end
