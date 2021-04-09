#import "AuxFloatingView.h"

@interface AuxExpandedFloatingView : AuxFloatingView
// timestamp
@property (assign, nonatomic) UILabel * timestampLabel;
// volume
@property (assign, nonatomic) UILabel * volumeLabel;
- (void)updateForVolumePercentage:(int)volumePercentage;
@end
