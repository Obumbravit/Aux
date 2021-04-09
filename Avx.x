//Aux by Obumbravit

@import UIKit;
#import "Avx.h"
#import "Prefs.h"
#import "MediaRemote.h"

%group AuxMain

%hook _UIStatusBar

- (CGRect)frame
{
    CGRect orig = %orig;
    CGFloat SbHeight = orig.size.height;
    if (SbHeight >= 44) Ay = 60;
    else if (SbHeight <= 20) Ay = 40;
    return %orig;
}

%end

%hook SpringBoard

- (void)applicationDidFinishLaunching:(id)arg1
{
    %orig;
    //window
    auxWindow = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    auxWindow.windowLevel = UIWindowLevelAlert; //2050;
    auxWindow.hidden = false;
    //[auxWindow makeKeyAndVisible];
    auxWindow.userInteractionEnabled = false;

    //music filler icon
    SBIconController *iconController = [NSClassFromString(@"SBIconController") sharedInstance];
    musicIcon = [iconController.model expectedIconForDisplayIdentifier:@"com.apple.Music"];
    struct SBIconImageInfo imageInfo;
    imageInfo.size  = CGSizeMake(60, 60);
    imageInfo.scale = [UIScreen mainScreen].scale;
    imageInfo.continuousCornerRadius = 12;
    musicIconImage = [musicIcon generateIconImageWithInfo:imageInfo];

    //music / layout updates
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateAux) name:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoDidChangeNotification object:nil];

    auxBlur = [NSClassFromString(@"MTMaterialView")materialViewWithRecipe:1 configuration:1];
    auxBlur.clipsToBounds = YES;
    auxBlur.userInteractionEnabled = NO;

    auxArtwork = [[UIImageView alloc] initWithImage:musicIconImage];
    auxArtwork.clipsToBounds = YES;
    auxArtwork.userInteractionEnabled = NO;

    auxLabel = [[UILabel alloc]init];
    if ([self _combinedListViewController].traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) auxLabel.textColor = [UIColor lightGrayColor];
    else auxLabel.textColor = [UIColor darkGrayColor];
    auxLabel.backgroundColor = [UIColor clearColor];
    auxLabel.text = @"Now Playing";
    auxLabel.font = [UIFont systemFontOfSize:13];
    auxLabel.userInteractionEnabled = NO;

    // updates
    if (!AuxMini)
    {
        auxLabel.numberOfLines = 1;
    }

    if (AuxBar)
    {
        if ([UIScreen mainScreen].bounds.size.height >= 812)
        {
            //material blur
            auxBlur.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 44);
            auxBlur.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, -200);
            auxBlur.layer.cornerRadius = 0;

            //album art
            auxArtwork.frame = CGRectMake(30, 4.5, 35, 35);
            auxArtwork.layer.cornerRadius = 8.4;

            //song title
            auxLabel.frame = CGRectMake(UIScreen.mainScreen.bounds.size.width - 80, 4.5, 70, 35);
        }
        else
        {
            //material blur
            auxBlur.frame = CGRectMake(UIScreen.mainScreen.bounds.size.width / 3, 0, UIScreen.mainScreen.bounds.size.width / 3, 20);
            auxBlur.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, -200);
            auxBlur.layer.cornerRadius = 0;

            //album art
            auxArtwork.frame = CGRectMake(16, 2, 16, 16);
            auxArtwork.layer.cornerRadius = 3.84;

            //song title
            auxLabel.frame = CGRectMake(auxBlur.bounds.size.width - 86, 2, 70, 16);
        }
        if (RcBar)
        {
            CAShapeLayer *auxMask = [CAShapeLayer layer];
            auxMask.path = [UIBezierPath bezierPathWithRoundedRect:auxBlur.bounds byRoundingCorners: UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10.56, 10.56)].CGPath;
            auxBlur.layer.mask = auxMask;
        }
    }
    else if (AuxMini)
    {
        //material blur
        auxBlur.frame = CGRectMake(15, 40, 40, 40);
        if (AuxLocation == 1) [UIView animateWithDuration:2.0 animations:^{ auxBlur.center = CGPointMake(40, -200); }];
        else if (AuxLocation == 2) [UIView animateWithDuration:2.0 animations:^{ auxBlur.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, -200); }];
        else if (AuxLocation == 3) [UIView animateWithDuration:2.0 animations:^{ auxBlur.center = CGPointMake([UIScreen mainScreen].bounds.size.width - 40, -200); }];
        auxBlur.layer.cornerRadius = 16;

        //album art
        auxArtwork.frame = CGRectMake(7.5, 7.5, 25, 25);
        auxArtwork.layer.cornerRadius = 6;
    }
    else if (AuxExpanded)
    {
        //material blur
        auxBlur.frame = CGRectMake(15, 40, 225, 40);
        if (AuxLocation == 1) [UIView animateWithDuration:2.0 animations:^{ auxBlur.center = CGPointMake(132.5, -200); }];
        else if (AuxLocation == 2) [UIView animateWithDuration:2.0 animations:^{ auxBlur.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, -200); }];
        else if (AuxLocation == 3) [UIView animateWithDuration:2.0 animations:^{ auxBlur.center = CGPointMake([UIScreen mainScreen].bounds.size.width - 132.5, -200); }];
        auxBlur.layer.cornerRadius = 16;

        //headphone icon & battery % label
        //volume icon & volume % label

        //album art
        auxArtwork.frame = CGRectMake(10.625, 7.5, 25, 25);
        auxArtwork.layer.cornerRadius = 6;

        //song title
        auxLabel.frame = CGRectMake(40.625, 7.5, 95, 25);
        auxLabel.textAlignment = NSTextAlignmentCenter;

        //timestamp
        auxTimeLabel = [[UILabel alloc]init];
        auxTimeLabel.frame = CGRectMake(140.625, 7.5, 36.25, 25); //36.25
        if ([self _combinedListViewController].traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) auxTimeLabel.textColor = [UIColor lightGrayColor];
        else auxTimeLabel.textColor = [UIColor darkGrayColor];
        auxTimeLabel.backgroundColor = [UIColor clearColor];
        auxTimeLabel.text = @"00:00";
        auxTimeLabel.font = [UIFont systemFontOfSize:13];
        auxTimeLabel.textAlignment = NSTextAlignmentCenter;
        auxTimeLabel.userInteractionEnabled = NO;

        //volume
        auxVolumeLabel = [[UILabel alloc]init];
        auxVolumeLabel.frame = CGRectMake(181.875, 7.5, 32.5, 25); //32.5
        if ([self _combinedListViewController].traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) auxVolumeLabel.textColor = [UIColor lightGrayColor];
        else auxVolumeLabel.textColor = [UIColor darkGrayColor];
        auxVolumeLabel.backgroundColor = [UIColor clearColor];
        auxVolumeLabel.text = [NSString stringWithFormat:@"%i%%",(int)([[%c(SBVolumeControl) sharedInstance] _effectiveVolume] * 100)];
        auxVolumeLabel.font = [UIFont systemFontOfSize:13];
        auxVolumeLabel.textAlignment = NSTextAlignmentCenter;
        auxVolumeLabel.userInteractionEnabled = NO;
    }
    else //Aux Normal
    {
        //material blur
        auxBlur.frame = CGRectMake(15, 40, 150, 40);
        auxBlur.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 4 * AuxLocation, -200);
        auxBlur.layer.cornerRadius = 16;

        //album art
        auxArtwork.frame = CGRectMake(12.5, 7.5, 25, 25);
        auxArtwork.layer.cornerRadius = 6;

        //song title
        auxLabel.frame = CGRectMake(42.5, 7.5, 95, 25);
    }
    [auxWindow addSubview:auxBlur];
    [auxBlur addSubview:auxArtwork];
    if (!AuxMini) [auxBlur addSubview:auxLabel];
    if (MeSwitch)
    {
        [auxLabel setMarqueeEnabled:YES];
        [auxLabel setMarqueeRunning:YES];
        [auxLabel _setLineBreakMode:1];
    }
    if (AuxExpanded)
    {
        [auxBlur addSubview:auxTimeLabel];
        [auxBlur addSubview:auxVolumeLabel];
    }
}

%new
- (void)updateAux
{
    static bool isNotched;
    if (!isNotched)
    {
        if ([UIScreen mainScreen].bounds.size.height >= 812) isNotched = YES;
    }
    NSDateFormatter * durationFormatter = [[NSDateFormatter alloc] init];
    [durationFormatter setDateFormat:@"m:ss"];
    if (!HoPSwitch)
    {
        MRMediaRemoteGetNowPlayingInfo(dispatch_get_main_queue(), ^(CFDictionaryRef information)
        {
            NSDictionary *dict=(__bridge NSDictionary *)(information);
            NSString *trackTitle = [dict objectForKey:(__bridge NSString*)kMRMediaRemoteNowPlayingInfoTitle];
            if (!trackTitle)
            {
                auxLabel.text = @"Now Playing";
                auxArtwork.image = musicIconImage;
                if (AuxExpanded) auxTimeLabel.text = @"0:00";
                if (!AsSwitch)
                {
                    if (AuxBar) [UIView animateWithDuration:2.0 animations:^{ auxBlur.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, -200); }];
                    else
                    {
                        if (AuxMini)
                        {
                            if (AuxLocation == 1) [UIView animateWithDuration:2.0 animations:^{ auxBlur.center = CGPointMake(40, -200); }];
                            else if (AuxLocation == 2) [UIView animateWithDuration:2.0 animations:^{ auxBlur.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, -200); }];
                            else if (AuxLocation == 3) [UIView animateWithDuration:2.0 animations:^{ auxBlur.center = CGPointMake([UIScreen mainScreen].bounds.size.width - 40, -200); }];
                        }
                        else if (AuxExpanded)
                        {
                            if (AuxLocation == 1) [UIView animateWithDuration:2.0 animations:^{ auxBlur.center = CGPointMake(132.5, -200); }];
                            else if (AuxLocation == 2) [UIView animateWithDuration:2.0 animations:^{ auxBlur.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, -200); }];
                            else if (AuxLocation == 3) [UIView animateWithDuration:2.0 animations:^{ auxBlur.center = CGPointMake([UIScreen mainScreen].bounds.size.width - 132.5, -200); }];
                        }
                        else [UIView animateWithDuration:2.0 animations:^{ auxBlur.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 4 * AuxLocation, -200); }];
                    }
                    [NSTimer scheduledTimerWithTimeInterval:2.0 target:[NSBlockOperation blockOperationWithBlock:^{
                    [auxBlur removeFromSuperview];
                    }] selector:@selector(main) userInfo:nil repeats:NO];
                }
            }
            else
            {
                NSData * artworkData = [dict objectForKey:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoArtworkData];
                UIImage * nowPlayingArtwork = [UIImage imageWithData:artworkData];

                auxLabel.text = [dict objectForKey:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoTitle];
                auxArtwork.image = nowPlayingArtwork;
                if (AuxExpanded)
                {
                    NSDate * duration = [NSDate dateWithTimeIntervalSince1970:[[dict objectForKey:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoDuration] doubleValue]];
                    auxTimeLabel.text = [NSString stringWithFormat:@"%@", [durationFormatter stringFromDate:duration]];
                }
                if (!AsSwitch) [auxWindow addSubview:auxBlur];
                if (AuxBar)
                {
                    if (!isNotched) [UIView animateWithDuration:2.0 animations:^{ auxBlur.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, 10); }];
                    else [UIView animateWithDuration:2.0 animations:^{ auxBlur.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, 22); }];
                }
                else
                {
                    if (AuxMini)
                    {
                        if (AuxLocation == 1) [UIView animateWithDuration:2.0 animations:^{ auxBlur.center = CGPointMake(40, Ay); }];
                        else if (AuxLocation == 2) [UIView animateWithDuration:2.0 animations:^{ auxBlur.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, Ay); }];
                        else if (AuxLocation == 3) [UIView animateWithDuration:2.0 animations:^{ auxBlur.center = CGPointMake([UIScreen mainScreen].bounds.size.width - 40, Ay); }];
                    }
                    else if (AuxExpanded)
                    {
                        if (AuxLocation == 1) [UIView animateWithDuration:2.0 animations:^{ auxBlur.center = CGPointMake(132.5, Ay); }];
                        else if (AuxLocation == 2) [UIView animateWithDuration:2.0 animations:^{ auxBlur.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, Ay); }];
                        else if (AuxLocation == 3) [UIView animateWithDuration:2.0 animations:^{ auxBlur.center = CGPointMake([UIScreen mainScreen].bounds.size.width - 132.5, Ay); }];
                    }
                    else [UIView animateWithDuration:2.0 animations:^{ auxBlur.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 4 * AuxLocation, Ay); }];
                }
            }
        });
    }
    else
    {
        MRMediaRemoteGetNowPlayingInfo(dispatch_get_main_queue(), ^(CFDictionaryRef information)
        {
            MRMediaRemoteGetNowPlayingApplicationIsPlaying(dispatch_get_main_queue(), ^(Boolean isPlayingNow)
            {
                static bool isRemoved;
                if (isPlayingNow == NO)
                {
                    isRemoved = true;
                    auxLabel.text = @"Now Playing";
                    auxArtwork.image = musicIconImage;
                    if (AuxExpanded) auxTimeLabel.text = @"0:00";
                    if (!AsSwitch)
                    {
                        if (AuxBar) [UIView animateWithDuration:2.0 animations:^{ auxBlur.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, -200); }];
                        else
                        {
                            if (AuxMini)
                            {
                                if (AuxLocation == 1) [UIView animateWithDuration:2.0 animations:^{ auxBlur.center = CGPointMake(40, -200); }];
                                else if (AuxLocation == 2) [UIView animateWithDuration:2.0 animations:^{ auxBlur.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, -200); }];
                                else if (AuxLocation == 3) [UIView animateWithDuration:2.0 animations:^{ auxBlur.center = CGPointMake([UIScreen mainScreen].bounds.size.width - 40, -200); }];
                            }
                            else if (AuxExpanded)
                            {
                                if (AuxLocation == 1) [UIView animateWithDuration:2.0 animations:^{ auxBlur.center = CGPointMake(132.5, -200); }];
                                else if (AuxLocation == 2) [UIView animateWithDuration:2.0 animations:^{ auxBlur.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, -200); }];
                                else if (AuxLocation == 3) [UIView animateWithDuration:2.0 animations:^{ auxBlur.center = CGPointMake([UIScreen mainScreen].bounds.size.width - 132.5, -200); }];
                            }
                            else [UIView animateWithDuration:2.0 animations:^{ auxBlur.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 4 * AuxLocation, -200); }];
                        }
                        [NSTimer scheduledTimerWithTimeInterval:2.0 target:[NSBlockOperation blockOperationWithBlock:^{
                        if (isRemoved) [auxBlur removeFromSuperview];
                        }] selector:@selector(main) userInfo:nil repeats:NO];
                    }
                }
                else if (isPlayingNow == YES)
                {
                    MRMediaRemoteGetNowPlayingInfo(dispatch_get_main_queue(), ^(CFDictionaryRef information)
                    {
                        NSDictionary * dict=(__bridge NSDictionary *)(information);
                        // ~ if (!trackTitle)
                        if (![dict objectForKey:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoTitle]) return;
                        NSData * artworkData = [dict objectForKey:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoArtworkData];
                        UIImage * nowPlayingArtwork = [UIImage imageWithData:artworkData];

                        auxLabel.text = [dict objectForKey:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoTitle];
                        auxArtwork.image = nowPlayingArtwork;
                        if (AuxExpanded)
                        {
                            NSDate * duration = [NSDate dateWithTimeIntervalSince1970:[[dict objectForKey:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoDuration] doubleValue]];
                            auxTimeLabel.text = [NSString stringWithFormat:@"%@", [durationFormatter stringFromDate:duration]];
                        }
                        if (!AsSwitch)
                        {
                            [auxWindow addSubview:auxBlur];
                            isRemoved = false;
                        }
                        if (AuxBar)
                        {
                            if (!isNotched) [UIView animateWithDuration:2.0 animations:^{ auxBlur.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, 10); }];
                            else [UIView animateWithDuration:2.0 animations:^{ auxBlur.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, 22); }];
                        }
                        else
                        {
                            if (AuxMini)
                            {
                                if (AuxLocation == 1) [UIView animateWithDuration:2.0 animations:^{ auxBlur.center = CGPointMake(40, Ay); }];
                                else if (AuxLocation == 2) [UIView animateWithDuration:2.0 animations:^{ auxBlur.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, Ay); }];
                                else if (AuxLocation == 3) [UIView animateWithDuration:2.0 animations:^{ auxBlur.center = CGPointMake([UIScreen mainScreen].bounds.size.width - 40, Ay); }];
                            }
                            else if (AuxExpanded)
                            {
                                if (AuxLocation == 1) [UIView animateWithDuration:2.0 animations:^{ auxBlur.center = CGPointMake(132.5, Ay); }];
                                else if (AuxLocation == 2) [UIView animateWithDuration:2.0 animations:^{ auxBlur.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, Ay); }];
                                else if (AuxLocation == 3) [UIView animateWithDuration:2.0 animations:^{ auxBlur.center = CGPointMake([UIScreen mainScreen].bounds.size.width - 132.5, Ay); }];
                            }
                            else [UIView animateWithDuration:2.0 animations:^{ auxBlur.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 4 * AuxLocation, Ay); }];
                        }
                    });
                }
            });
        });
    }
}

%end

%hook SBHomeScreenViewController

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
{
    %orig;
    if (!AuxMini)
    {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) auxLabel.textColor = [UIColor lightGrayColor];
        else if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) auxLabel.textColor = [UIColor darkGrayColor];
    }
    if (AuxExpanded)
    {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark)
        {
            auxTimeLabel.textColor = [UIColor lightGrayColor];
            auxVolumeLabel.textColor = [UIColor lightGrayColor];
        }
        else if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight)
        {
            auxTimeLabel.textColor = [UIColor darkGrayColor];
            auxVolumeLabel.textColor = [UIColor darkGrayColor];
        }
    }
}

%end

%hook SBVolumeControl

- (void)_updateEffectiveVolume:(float)arg1
{
    %orig;
    if (AuxExpanded) auxVolumeLabel.text = [NSString stringWithFormat:@"%i%%", (int)(arg1 * 100)];
}

%end

%end

%group Dxy

%hook _UIStatusBarStringView
%property (nonatomic,assign) bool isPlaying;
%property (nonatomic,retain) NSString * playingString;
%property (nonatomic,retain) NSString * time;

- (void)didMoveToWindow
{
    %orig;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateAuxTiny) name:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoDidChangeNotification object:nil];
}

- (void)setText:(NSString *)arg1
{
    if (self.isPlaying) %orig(self.playingString);
    else
    {
        %orig;
        self.time = arg1;
    }
}

%new
- (void)updateAuxTiny
{
    if (self.fontStyle != 1) return;
    MRMediaRemoteGetNowPlayingInfo(dispatch_get_main_queue(), ^(CFDictionaryRef information)
    {
        NSDictionary * dict=(__bridge NSDictionary *)(information);
        NSString * isTitle = [dict objectForKey:(__bridge NSString*)kMRMediaRemoteNowPlayingInfoTitle];
        NSString * trackTitle = (dxyTitleEnabled) ? [dict objectForKey:(__bridge NSString*)kMRMediaRemoteNowPlayingInfoTitle] : @"DxyFiller";
        NSString * albumTitle = (dxyAlbumEnabled) ? [dict objectForKey:(__bridge NSString*)kMRMediaRemoteNowPlayingInfoAlbum] : @"DxyFiller";
        NSString * trackArtist = (dxyArtistEnabled) ? [dict objectForKey:(__bridge NSString*)kMRMediaRemoteNowPlayingInfoArtist] : @"DxyFiller";
        NSMutableArray * trackInfo = [[NSMutableArray arrayWithObjects:trackTitle,albumTitle,trackArtist,nil] init];
        [trackInfo removeObjectsInArray:@[@"DxyFiller"]];
        NSString * playingString = [trackInfo componentsJoinedByString:@" - "];
        if (isTitle)
        {
            self.isPlaying = true;
            self.playingString = playingString;
            [self setMarqueeEnabled:YES];
            [self setMarqueeRunning:YES];
            [self setText:playingString];
        }
        else
        {
            self.isPlaying = false;
            [self setMarqueeEnabled:NO];
            [self setMarqueeRunning:NO];
            [self setText:self.time];
        }
    });
}

%end

%end

%ctor
{
    notificationCallback(NULL, NULL, NULL, NULL, NULL);
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, notificationCallback, (CFStringRef)nsNotificationString, NULL, CFNotificationSuspensionBehaviorCoalesce);
    if (AuxSwitch && !dxyEnabled) %init(AuxMain);
    else if (AuxSwitch && dxyEnabled) %init(Dxy);
}
