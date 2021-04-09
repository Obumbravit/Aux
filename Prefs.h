@interface NSUserDefaults (auxprefs)
- (id)objectForKey:(NSString *)key inDomain:(NSString *)domain;
- (void)setObject:(id)value forKey:(NSString *)key inDomain:(NSString *)domain;
@end

static NSString * nsDomainString = @"com.obumbravit.aux";
static NSString * nsNotificationString = @"com.obumbravit.aux/preferences.changed";

static BOOL AuxSwitch;
static BOOL HoPSwitch;
static BOOL AsSwitch;
static BOOL MeSwitch;
static CGFloat AuxLocation;
static BOOL AuxMini;
static BOOL AuxExpanded;
static BOOL AuxBar;
static BOOL RcBar;
//
static BOOL dxyEnabled;
static BOOL dxyTitleEnabled;
static BOOL dxyAlbumEnabled;
static BOOL dxyArtistEnabled;

static void notificationCallback(CFNotificationCenterRef center, void * observer, CFStringRef name, const void * object, CFDictionaryRef userInfo)
{
    NSNumber * AuxSwitchh = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"AuxSwitch" inDomain:nsDomainString];
    AuxSwitch = (AuxSwitchh) ? [AuxSwitchh boolValue] : YES;
    CGFloat AuxStylee = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AuxStyle" inDomain:nsDomainString]floatValue];
    CGFloat AuxFloatss = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AuxFloats" inDomain:nsDomainString]floatValue];
    AuxMini = (AuxStylee == 0 && AuxFloatss == 1) ? 1 : 0;
    AuxExpanded = (AuxStylee == 0 && AuxFloatss == 2) ? 1 : 0;
    AuxBar = (AuxStylee == 1) ? 1 : 0;
    dxyEnabled = (AuxStylee == 2) ? 1 : 0;
    NSNumber * HoPSwitchh = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"HoPSwitch" inDomain:nsDomainString];
    HoPSwitch = (HoPSwitchh) ? [HoPSwitchh boolValue] : YES;
    NSNumber * AsSwitchh = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"AsSwitch" inDomain:nsDomainString];
    AsSwitch = (AsSwitchh) ? [AsSwitchh boolValue] : NO;
    NSNumber * MeSwitchh = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"MeSwitch" inDomain:nsDomainString];
    MeSwitch = (MeSwitchh) ? [MeSwitchh boolValue] : YES;
    CGFloat AuxLocationn = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AuxLocation" inDomain:nsDomainString]floatValue];
    AuxLocation = (AuxLocationn) ? AuxLocationn + 1.0f : 1.0f;
    NSNumber * RcBarr = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"RcBar" inDomain:nsDomainString];
    RcBar = (RcBarr) ? [RcBarr boolValue] : YES;
    //
    NSNumber * dxyTitleEnabledd = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"tinyTitleEnabled" inDomain:nsDomainString];
    dxyTitleEnabled = (dxyTitleEnabledd) ? [dxyTitleEnabledd boolValue] : YES;
    NSNumber * dxyAlbumEnabledd = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"tinyAlbumEnabled" inDomain:nsDomainString];
    dxyAlbumEnabled = (dxyAlbumEnabledd) ? [dxyAlbumEnabledd boolValue] : NO;
    NSNumber * dxyArtistEnabledd = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"tinyArtistEnabled" inDomain:nsDomainString];
    dxyArtistEnabled = (dxyArtistEnabledd) ? [dxyArtistEnabledd boolValue] : NO;
}