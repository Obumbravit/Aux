#import "AuxExpandedFloatingView.h"

@implementation AuxExpandedFloatingView

- (id)init
{
  self = [super init];
  self.frame = CGRectMake(0, 0, 225, 40);

  self.backgroundBlur.frame = self.frame;

  self.mediaImageView.frame = CGRectMake(10.625, 7.5, 25, 25);

  self.mediaLabel.frame = CGRectMake(40.625, 7.5, 95, 25);
  self.mediaLabel.textAlignment = NSTextAlignmentCenter;

  self.timestampLabel = [[UILabel alloc] init];
  self.timestampLabel.frame = CGRectMake(140.625, 7.5, 36.25, 25); //36.25
  self.timestampLabel.backgroundColor = [UIColor clearColor];
  self.timestampLabel.text = @"00:00";
  self.timestampLabel.font = [UIFont systemFontOfSize:13];
  self.timestampLabel.textAlignment = NSTextAlignmentCenter;
  self.timestampLabel.userInteractionEnabled = NO;
  self.timestampLabel.numberOfLines = 1;

  self.volumeLabel = [[UILabel alloc] init];
  self.volumeLabel.frame = CGRectMake(181.875, 7.5, 32.5, 25); //32.5
  self.volumeLabel.backgroundColor = [UIColor clearColor];
  self.volumeLabel.font = [UIFont systemFontOfSize:13];
  self.volumeLabel.textAlignment = NSTextAlignmentCenter;
  self.volumeLabel.userInteractionEnabled = NO;
  self.volumeLabel.numberOfLines = 1;

  [self addSubview:self.timestampLabel];
  [self addSubview:self.volumeLabel];
}

- (void)updateForVolumePercentage:(int)volumePercentage
{
  self.volumeLabel.text = [NSString stringWithFormat:@"%i%%", volumePercentage];
}

@end

%hook SBVolumeControl

- (void)_updateEffectiveVolume:(float)arg1
{
  %orig;
  if (AuxExpanded) auxVolumeLabel.text = [NSString stringWithFormat:@"%i%%", (int)(arg1 * 100)];
}

%end
