//Aux Main
@interface _UIStatusBar : UIView
@property (assign,nonatomic) CGRect frame;
@end
//material view
@interface MTMaterialView : UIView
+ (id)materialViewWithRecipe:(long long)arg1 configuration:(long long)arg2;
@end
//marquee
@interface UILabel (Aux)
- (void)setMarqueeEnabled:(BOOL)arg1;
- (void)setMarqueeRunning:(BOOL)arg1;
- (void)_setLineBreakMode:(long long)arg1;
@end
//app icons
@interface SBIconModel : NSObject
- (id)expectedIconForDisplayIdentifier:(id)arg1;
@end
@interface SBIconController : NSObject
@property(retain, nonatomic) SBIconModel * model;
+ (SBIconController *)sharedInstance;
@end
struct SBIconImageInfo
{
    CGSize size;
    CGFloat scale;
    CGFloat continuousCornerRadius;
};
@interface SBIcon : NSObject
- (id)generateIconImageWithInfo:(struct SBIconImageInfo)arg1;
@end
@interface SBHomeScreenViewController : UIViewController
@end
@interface SpringBoard : UIApplication
- (UIViewController *)_combinedListViewController;
- (void)updateAux;
@end
@interface SBVolumeControl
+ (id)sharedInstance;
- (float)_effectiveVolume;
@end

//sbh
static CGFloat Ay;
//window
static UIWindow * auxWindow;
//material blur
static MTMaterialView * auxBlur;
//album art
static SBIcon * musicIcon;
static UIImage * musicIconImage;
static UIImageView * auxArtwork;
//song title
static UILabel * auxLabel;
//timestamp
static UILabel * auxTimeLabel;
//volume
static UILabel * auxVolumeLabel;

//Aux Tiny
@interface _UIStatusBarStringView : UILabel
@property (assign,nonatomic) long long fontStyle;
@property (nonatomic,assign) bool isPlaying;
@property (nonatomic,retain) NSString * playingString;
@property (nonatomic,retain) NSString * time;
- (void)setText:(NSString *)arg1;
- (void)setMarqueeEnabled:(BOOL)arg1;
- (void)setMarqueeRunning:(BOOL)arg1;
@end
