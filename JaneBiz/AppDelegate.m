//
//  AppDelegate.m
//  JaneBiz
//
//  Created by kkgo on 14-1-9.
//  Copyright (c) 2014年 KKStudio. All rights reserved.
//

#import "AppDelegate.h"
#import "AppBoard_iPhone.h"

@implementation AppDelegate

-(void)load{
  bee.ui.config.ASR = YES;
	bee.ui.config.iOS7Mode = YES;
	bee.ui.config.highPerformance = YES;
	bee.ui.config.cacheAsyncLoad = YES;
	bee.ui.config.cacheAsyncSave = YES;
  
	[BeeUINavigationBar setTitleColor:[UIColor whiteColor]];
	[BeeUINavigationBar setBackgroundColor:[UIColor blackColor]];
	[BeeUINavigationBar setBackgroundTintColor:[[UIColor darkGrayColor] colorWithAlphaComponent:0.6f]];
  
	if ( IOS7_OR_LATER )
	{
		[BeeUINavigationBar setBackgroundImage:[UIImage imageNamed:@"navigation-bar-64.png"]];
	}
	else
	{
		[BeeUINavigationBar setBackgroundImage:[UIImage imageNamed:@"navigation-bar.png"]];
	}
  
	if ( [BeeSystemInfo isDevicePad] )
	{
		//self.window.rootViewController = [AppBoard_iPad sharedInstance];
	}
	else
	{
		self.window.rootViewController = [AppBoard_iPhone sharedInstance];
	}

  
}

-(void)unload{
  
}
@end
