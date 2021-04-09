#import "AuxHybridView.h"

@interface AuxBarView : AuxHybridView
// is notched
@property (assign, nonatomic) BOOL notched;
// bar mask
@property (assign, nonatomic) CAShapeLayer * roundedBarCornersMask;
// preferences
@property (assign, nonatomic) BOOL roundedBarCorners;
@end
