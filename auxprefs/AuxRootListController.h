#import <Preferences/PSListController.h>
#import <Preferences/PSTableCell.h> 
#import "libappearancecell.h"

@interface AuxRootListController : PSListController
@end

@interface AuxHeader : PSTableCell
{
	UILabel * headTitle;
	UILabel * Title;
    UILabel * subTitle;
}
@end

@interface NSUserDefaults (auxprefs)
- (id)objectForKey:(NSString *)key inDomain:(NSString *)domain;
- (void)setObject:(id)value forKey:(NSString *)key inDomain:(NSString *)domain;
@end