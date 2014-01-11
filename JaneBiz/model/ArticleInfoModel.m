//
//  ArticleInfoModel.m
//  example
//
//  Created by kkgo on 13-12-21.
//  Copyright (c) 2013年 geek-zoo studio. All rights reserved.
//

#import "ArticleInfoModel.h"

@implementation ArticleInfoModel

@synthesize article_id = _article_id;
@synthesize articleInfo = _articleInfo;
- (void)load
{
	[super load];
}

- (void)unload
{
	self.article_id = nil;
	self.articleInfo = nil;
  
	[super unload];
}

#pragma mark -

- (void)loadCache
{
}

- (void)saveCache
{
}

- (void)clearCache
{
}

#pragma mark -

- (void)firstPage
{
	[API_ARTICLEINFO_ID cancel];
  
	API_ARTICLEINFO_ID * api = [API_ARTICLEINFO_ID apiWithResponder:self];
	api.id = self.article_id;
	[api send];
}

#pragma mark -

- (void)API_ARTICLEINFO_ID:(API_ARTICLEINFO_ID *)api
{
	if ( api.succeed )
	{
		if ( nil == api.resp )
		{
			api.failed = YES;
			return;
		}
		
		self.articleInfo = api.resp.articleInfo;
		self.loaded = YES;
		
		[self saveCache];
	}
}


@end
