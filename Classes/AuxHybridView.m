#import "AuxHybridView.h"

@implementation AuxHybridView

- (id)init
{
  self = [super init];

  self.mediaLabel = [[UILabel alloc] init];
  self.mediaLabel.backgroundColor = [UIColor clearColor];
  self.mediaLabel.text = @"Now Playing";
  self.mediaLabel.font = [UIFont systemFontOfSize:13];
  self.mediaLabel.userInteractionEnabled = NO;
  self.mediaLabel.numberOfLines = 1;

  [self addSubview:self.mediaLabel];
}

- (void)setMarqueeEnabled:(BOOL)arg1
{
  _marqueeEnabled = arg1;

  [self.mediaLabel setMarqueeEnabled:arg1];
  [self.mediaLabel setMarqueeRunning:arg1];
  [self.mediaLabel _setLineBreakMode:(arg1 == YES) ? 1 : NSLineBreakMode.byTruncatingTail];
}

@end
