@protocol AuxFloat
// positions
@property (assign, nonatomic) NSArray * positions;
// movement
@property (nonatomic) UISwipeGestureRecognizer * swipeRecognizer;
// position
@property (assign, nonatomic) int floatingPosition;
// preferences
@property (assign, nonatomic) int floatingLocation;
@end
