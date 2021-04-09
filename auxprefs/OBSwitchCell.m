#include "OBSwitchCell.h"

@implementation OBSwitchCell

-(id)initWithStyle:(int)style reuseIdentifier:(id)identifier specifier:(id)specifier
{
	self = [super initWithStyle:style reuseIdentifier:identifier specifier:specifier];

	if (self)
	{
		[((UISwitch *)[self control]) setTintColor:[UIColor clearColor]];
		[((UISwitch *)[self control]) setOnTintColor:[UIColor clearColor]];
		[((UISwitch *)[self control]) setThumbTintColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]];
	}

	return self;
}

@end
