#import <UIKit/UIKit.h>
#import <Preferences/PSControlTableCell.h> 
#import <spawn.h>
#import <notify.h>

#include "AuxRootListController.h"

@implementation AuxRootListController

- (void)setCellForRowAtIndexPath:(NSIndexPath *)indexPath enabled:(BOOL)enabled
{
    UITableViewCell *cell = [self tableView:self.table cellForRowAtIndexPath:indexPath];
    if (cell)
	{
        cell.userInteractionEnabled = enabled;
        cell.textLabel.enabled = enabled;
        cell.detailTextLabel.enabled = enabled;
        if ([cell isKindOfClass:[PSControlTableCell class]])
		{
            PSControlTableCell *controlCell = (PSControlTableCell *)cell;
            if (controlCell.control) controlCell.control.enabled = enabled;
        }
    }
}

- (void)getStyleValue:(PSSpecifier *)specifier
{
	NSString * nsDomainString = @"com.obumbravit.aux";
	CGFloat enabledCell = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AuxStyle" inDomain:nsDomainString]floatValue];
	BOOL enableCell = (enabledCell == 0) ? 1 : 0;
    [self setCellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:2] enabled:enableCell];
}

- (void)setStyleValue:(id)value specifier:(PSSpecifier *)specifier
{
	NSString * nsDomainString = @"com.obumbravit.aux";
	CGFloat enabledCell = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AuxStyle" inDomain:nsDomainString]floatValue];
	BOOL enableCell = (enabledCell == 0) ? 1 : 0;
    [self setCellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:2] enabled:enableCell];
}

- (NSArray *)specifiers
{
	if (!_specifiers) _specifiers = [self loadSpecifiersFromPlistName:@"Avx" target:self];
	return _specifiers;
}

- (void)loadView
{
    [super loadView];

    int _;
    notify_register_dispatch("com.obumbravit.aux/preferences.changed", &_, dispatch_get_main_queue(), ^(int _) {
		[self performSelector:@selector(reloadSpecifiers) withObject:nil afterDelay:0.3 ];
    });
}

- (id)init
{
  	self = [super init];
  	if (self) self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Apply" style:UIBarButtonItemStylePlain target:self action:@selector(apply)];
  	return self;
}

- (void)apply
{
	[self.view endEditing:YES];
	UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Aux"
    message:@"Settings Applied!\nYour Device Will Now Respring."
	preferredStyle:UIAlertControllerStyleAlert];

	UIAlertAction * defaultAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
    handler:^(UIAlertAction * action) {
		pid_t pid;
		if ([[NSFileManager defaultManager] fileExistsAtPath:@"/usr/bin/sbreload"])
		{
    		const char* args[] = {"sbreload", NULL};
    		posix_spawn(&pid, "/usr/bin/sbreload", NULL, NULL, (char* const*)args, NULL); 
		} 
		else
		{
    		const char* args[] = {"killall", "-9", "backboardd", NULL};
    		posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
		};
	}];

	[alert addAction:defaultAction];
	[self presentViewController:alert animated:YES completion:nil];
}

- (void)twitter
{
	NSURL *url;
	if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetbot:"]]) url = [NSURL URLWithString:@"tweetbot:///user_profile/Obumbravit"];
	else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitterrific:"]]) url = [NSURL URLWithString:@"twitterrific:///profile?screen_name=Obumbravit"];
	else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetings:"]]) url = [NSURL URLWithString:@"tweetings:///user?screen_name=Obumbravit"];
	else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter:"]]) url = [NSURL URLWithString:@"twitter://user?screen_name=Obumbravit"];
	else url = [NSURL URLWithString:@"https://mobile.twitter.com/Obumbravit"];
	[[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
}

- (void)kofi
{
	NSURL *url;
	if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"kofi:"]]) url = [NSURL URLWithString:@"https://ko-fi.com/obumbravit"];
	else url = [NSURL URLWithString:@"https://ko-fi.com/obumbravit"];
	[[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
}

@end

@implementation AuxHeader

- (id)initWithSpecifier:(PSSpecifier *)specifier
{
	self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell" specifier:specifier];
	if (self)
	{
		CGFloat width = 320;
		CGFloat height = 70;

		CGRect headTitleFrame = CGRectMake(4, -50, width, height);
		headTitle = [[UILabel alloc] initWithFrame:headTitleFrame];
		headTitle.numberOfLines = 1;
		headTitle.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
		headTitle.font = [UIFont fontWithName:@"Verdana" size:25.0f];
		headTitle.textColor = [UIColor grayColor];
		headTitle.text = @"Pass the";
		headTitle.backgroundColor = [UIColor clearColor];
		headTitle.textAlignment = NSTextAlignmentCenter;

		CGRect TitleFrame = CGRectMake(0, -25, width, height);
		Title = [[UILabel alloc] initWithFrame:TitleFrame];
		[Title layoutIfNeeded];
		Title.numberOfLines = 1;
		Title.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
		Title.font = [UIFont fontWithName:@"Verdana" size:75.0f];
		Title.textColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
		Title.text = @"Aux.";
		Title.textAlignment = NSTextAlignmentCenter;

		CGRect subTitleFrame = CGRectMake(0, 30, width, height);
		subTitle = [[UILabel alloc] initWithFrame:subTitleFrame];
		subTitle.numberOfLines = 1;
		subTitle.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
		subTitle.font = [UIFont fontWithName:@"Verdana" size:20.0f];
		subTitle.textColor = [UIColor grayColor];
		subTitle.text = @"~ 0$";
		subTitle.backgroundColor = [UIColor clearColor];
		subTitle.textAlignment = NSTextAlignmentCenter;

		[self addSubview:headTitle];
		[self addSubview:Title];
		[self addSubview:subTitle];
	}
	return self;
}

- (CGFloat)preferredHeightForWidth:(CGFloat)width
{
	return 125.f;
}

@end