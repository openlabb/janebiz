//
//  ArticleListModel.m
//  example
//
//  Created by kkgo on 13-12-21.
//  Copyright (c) 2013年 geek-zoo studio. All rights reserved.
//

#import "ArticleListModel.h"
#undef	PER_PAGE
#define PER_PAGE	(2)
#define ARTICLE_CACHEKEY @"article"


@implementation ArticleListModel

@synthesize articleArray = _articleArray;

- (void)load
{
	[super load];
	
	self.articleArray = [NSMutableArray array];
	
	[self loadCache];
}

- (void)unload
{
	[self saveCache];
	
	self.articleArray = nil;
	
	[super unload];
}

#pragma mark -

- (void)loadCache
{
	[self.articleArray removeAllObjects];
  //里面有解析
	[self.articleArray addObjectsFromArray:[ARTICLE readObjectForKey:ARTICLE_CACHEKEY]];
}

- (void)saveCache
{
	[ARTICLE saveObject:self.articleArray forKey:ARTICLE_CACHEKEY];
}

- (void)clearCache
{
	[self.articleArray removeAllObjects];
	
	[ARTICLE removeObjectForKey:ARTICLE_CACHEKEY];

}

#pragma mark -
- (void)firstPage
{
	[API_ARTICLES_LIST cancel];
	API_ARTICLES_LIST * api = [API_ARTICLES_LIST apiWithResponder:self];
	api.req.start = @0;
	api.req.count = @(PER_PAGE);
	[api send];
}

- (void)prevPage
{
	[self firstPage];
}

- (void)nextPage
{
	if ( 0 == self.articleArray.count )
		return;
	[API_ARTICLES_LIST cancel];
	API_ARTICLES_LIST * api = [API_ARTICLES_LIST apiWithResponder:self];
  api.req.start = @(self.articleArray.count);
	api.req.count = @(PER_PAGE);
	[api send];
}

#pragma mark -

- (void)API_ARTICLES_LIST:(API_ARTICLES_LIST *)api
{
	if ( api.succeed )
	{
		if ( nil == api.resp.notes )
		{
			api.failed = YES;
			return;
		}
    
		if ( [api.req.start isEqualToNumber:@0] )
		{
			[self.articleArray removeAllObjects];
		}
		
		[self.articleArray addObjectsFromArray:api.resp.notes];
		self.loaded = YES;
		
		[self saveCache];
	}
}

@end
