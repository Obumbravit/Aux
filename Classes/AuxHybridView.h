#import "AuxView.h"

// marquee
@interface UILabel (Aux)
- (void)setMarqueeEnabled:(BOOL)arg1;
- (void)setMarqueeRunning:(BOOL)arg1;
- (void)_setLineBreakMode:(long long)arg1;
@end

@interface AuxHybridView : AuxView
// song title
@property (assign, nonatomic) UILabel * mediaLabel;
// preferences
@property (assign, nonatomic) BOOL marqueeEnabled;
@end
