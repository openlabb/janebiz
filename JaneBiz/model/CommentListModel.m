//
//  CommentListModel.m
//  example
//
//  Created by kkgo on 14-1-4.
//  Copyright (c) 2014年 geek-zoo studio. All rights reserved.
//

#import "CommentListModel.h"
#undef	PER_PAGE
#define PER_PAGE	(2)
#define COMMENTS_CACHEKEY @"comments"

@implementation CommentListModel

@synthesize commentsArray = _commentsArray;

- (void)load
{
	[super load];
	
	self.commentsArray = [NSMutableArray array];
	
	[self loadCache];
}

- (void)unload
{
	[self saveCache];
	
	self.commentsArray = nil;
	
	[super unload];
}

#pragma mark -

- (void)loadCache
{
	[self.commentsArray removeAllObjects];
  //里面有解析
	[self.commentsArray addObjectsFromArray:[COMMENTS readObjectForKey:COMMENTS_CACHEKEY]];
}

- (void)saveCache
{
	[COMMENTS saveObject:self.commentsArray forKey:COMMENTS_CACHEKEY];
}

- (void)clearCache
{
	[self.commentsArray removeAllObjects];
	
	[COMMENTS removeObjectForKey:COMMENTS_CACHEKEY];
  
}

#pragma mark -
- (void)firstPage
{
	[API_COMMENTS_LIST cancel];
	API_COMMENTS_LIST * api = [API_COMMENTS_LIST apiWithResponder:self];
	api.id = self.noteid;
	[api send];
}

#pragma mark -

- (void)API_COMMENTS_LIST:(API_COMMENTS_LIST *)api
{
	if ( api.succeed )
	{
		if ( nil == api.resp.comments )
		{
			api.failed = YES;
			return;
		}
    
    [self.commentsArray removeAllObjects];

		
		[self.commentsArray addObjectsFromArray:api.resp.comments];
		self.loaded = YES;
		
		[self saveCache];
	}
}

@end
