// material view
@interface MTMaterialView : UIView
+ (id)materialViewWithRecipe:(long long)arg1 configuration:(long long)arg2;
@end

@interface AuxView : UIView
/*
styles
1: default floating
2: mini floating
3: expanded floating
4: bar
*/
// material blur
@property (assign, nonatomic) MTMaterialView * backgroundBlur;
// album art
@property (assign, nonatomic) UIImage * mediaImagePlaceholder;
@property (assign, nonatomic) UIImageView * mediaImageView;
// runtime
@property (assign, nonatomic) BOOL isPlaying;
// preferences
@property (assign, nonatomic) BOOL hideOnPause;
@property (assign, nonatomic) BOOL alwaysShow;
- (id)init;
- (void)updateForUserInterfaceStyle:(long long)userInterfaceStyle;
@end

// init
// update prefs
// configure
// update placeholder
// update interface style
