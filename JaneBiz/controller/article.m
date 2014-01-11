//
//  article.m
//  example
//
//  Created by kkgo on 13-12-21.
//  Copyright (c) 2013年 geek-zoo studio. All rights reserved.
//

#import "article.h"

@implementation IMAGE
@synthesize id = _id;
@synthesize url = _url;
@synthesize index = _index;
- (BOOL)validate
{
	if ( nil == self.id || NO == [self.id isKindOfClass:[NSNumber class]] )
	{
		return NO;
	}
  
	return YES;
}

@end

@implementation USER

@synthesize loc_id = _loc_id;
@synthesize name = _name;
@synthesize created = _created;
@synthesize is_banned = _is_banned;
@synthesize is_suicide = _is_suicide;
@synthesize loc_name = _loc_name;
@synthesize avatar = _avatar;
@synthesize signature = _signature;
@synthesize uid = _uid;
@synthesize alt = _alt;
@synthesize desc = _desc;
@synthesize type = _type;
@synthesize id = _id;
@synthesize large_avatar = _large_avatar;

- (BOOL)validate
{
	if ( nil == self.id || NO == [self.id isKindOfClass:[NSNumber class]] )
	{
		return NO;
	}
  
	return YES;
}

@end

@implementation ARTICLE
@synthesize id = _id;
@synthesize update_time = _update_time;
@synthesize publish_time = _publish_time;
@synthesize recs_count = _recs_count;
@synthesize images = _images;
@synthesize alt = _alt;
@synthesize can_reply = _can_reply;
@synthesize title = _title;
@synthesize privacy = _privacy;
@synthesize summary = _summary;
@synthesize content = _content;
@synthesize comments_count = _comments_count;
@synthesize liked_count = _liked_count;
@synthesize user = _user;
@synthesize total = _total;

CONVERT_PROPERTY_CLASS( images, IMAGE );


- (BOOL)validate
{
	if ( nil == self.id || NO == [self.id isKindOfClass:[NSNumber class]] )
	{
		return NO;
	}
  
	return YES;
}


@end



@implementation AUTHOR
@synthesize name = _name;
@synthesize is_banned = _is_banned;
@synthesize is_suicide = _is_suicide;
@synthesize avatar = _avatar;
@synthesize uid = _uid;
@synthesize alt = _alt;
@synthesize type = _type;
@synthesize id = _id;
@synthesize large_avatar = _large_avatar;
- (BOOL)validate
{
	if ( nil == self.id || NO == [self.id isKindOfClass:[NSNumber class]] )
	{
		return NO;
	}
  
	return YES;
}

@end


@implementation COMMENTS
@synthesize content = _content;
@synthesize created = _created;
@synthesize id = _id;
@synthesize author = _author;

- (BOOL)validate
{
	if ( nil == self.id || NO == [self.id isKindOfClass:[NSNumber class]] )
	{
		return NO;
	}
  
	return YES;
}

@end


@implementation ARTICLEINFO
@synthesize id = _id;
@synthesize update_time = _update_time;
@synthesize publish_time = _publish_time;
@synthesize recs_count = _recs_count;
@synthesize images = _images;
@synthesize alt = _alt;
@synthesize can_reply = _can_reply;
@synthesize title = _title;
@synthesize privacy = _privacy;
@synthesize summary = _summary;
@synthesize content = _content;
@synthesize comments_count = _comments_count;
@synthesize liked_count = _liked_count;
@synthesize author  = _author;
@synthesize photos = _photos;

CONVERT_PROPERTY_CLASS( images, IMAGE );
CONVERT_PROPERTY_CLASS( author, AUTHOR );


- (BOOL)validate
{
	if ( nil == self.id || NO == [self.id isKindOfClass:[NSNumber class]] )
	{
		return NO;
	}
  
	return YES;
}

@end


#pragma mark -
#pragma mark - GET /users/:id


@implementation REQ_USERS_ID

- (BOOL)validate
{
	return YES;
}

@end


@implementation API_USERS_ID

@synthesize id = _id;
@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_USERS_ID alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}


- (void)routine
{
	if ( self.sending )
	{
    //https://api.douban.com/v2/user/2792480
		NSString * requestURI = @"https://api.douban.com/v2/user/:id";
		requestURI = [requestURI stringByReplacingOccurrencesOfString:@":id" withString:self.id];
    
		self.HTTP_GET( requestURI );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;
    
		if ( result && [result isKindOfClass:[USER class]] )
		{
			self.resp = (USER *)result;
		}
		else if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [USER objectFromDictionary:(NSDictionary *)result];
		}
    
		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end


#pragma mark - GET /article/:id

@implementation REQ_ARTICLES_ID

- (BOOL)validate
{
	return YES;
}

@end


@implementation API_ARTICLES_ID

@synthesize id = _id;
@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_ARTICLES_ID alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		NSString * requestURI = @"https://api.douban.com/v2/note/:id";
		requestURI = [requestURI stringByReplacingOccurrencesOfString:@":id" withString:self.id];
    
		self.HTTP_GET( requestURI );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;
    
		if ( result && [result isKindOfClass:[ARTICLE class]] )
		{
			self.resp = (ARTICLE *)result;
		}
		else if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [ARTICLE objectFromDictionary:(NSDictionary *)result];
		}
    
		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end


#pragma mark -
#pragma mark - GET /articleinfo/:id


@implementation REQ_ARTICLEINFO_ID

- (BOOL)validate
{
	return YES;
}

@end

@implementation RESP_ARTICLEINFO_ID
@synthesize articleInfo = _articleInfo;
- (BOOL)validate
{
  
	return YES;
}

@end

@implementation API_ARTICLEINFO_ID

@synthesize id = _id;
@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_ARTICLEINFO_ID alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}


- (void)routine
{
	if ( self.sending )
	{
    //https://api.douban.com/v2/user/2792480
		NSString * requestURI = @"https://api.douban.com/v2/note/:id";
		requestURI = [requestURI stringByReplacingOccurrencesOfString:@":id" withString:[self.id stringValue]];
    
		self.HTTP_GET( requestURI );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;
    
		if ( result && [result isKindOfClass:[ARTICLEINFO class]] )
		{
			self.resp.articleInfo = (ARTICLEINFO *)result;
		}
    
		else if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_ARTICLEINFO_ID new];
      self.resp.articleInfo = [ARTICLEINFO objectFromDictionary:(NSDictionary *)result];
		}
    
		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end



#pragma mark -

#pragma mark - GET /articles/:list

@implementation REQ_ARTICLES_LIST

@synthesize start = _start;
@synthesize count = _count;

-(id)init{
  self = [super init];
  if(self){
    _start = @(0);
    _count = @(0);
  }
  return self;
}

- (BOOL)validate
{
  
	return YES;
}

@end

@implementation RESP_ARTICLES_LIST
@synthesize start = _start;
@synthesize count = _count;
@synthesize user = _user;
@synthesize notes = _notes;
@synthesize total = _total;

CONVERT_PROPERTY_CLASS( notes, ARTICLE );

- (BOOL)validate
{
  
	return YES;
}

@end

@implementation API_ARTICLES_LIST

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_ARTICLES_LIST alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}
    
    NSString * requestURI = @"https://api.douban.com/v2/note/user_created/2792480";

		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;
    
		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_ARTICLES_LIST objectFromDictionary:(NSDictionary *)result];
		}
    
		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end


#pragma mark -

#pragma mark - GET /comments/:list

@implementation REQ_COMMENTS_LIST


-(id)init{
  self = [super init];
  if(self){
  }
  return self;
}

- (BOOL)validate
{
  
	return YES;
}

@end

@implementation RESP_COMMENTS_LIST
@synthesize start = _start;
@synthesize count = _count;
@synthesize comments = _comments;
@synthesize total = _total;

CONVERT_PROPERTY_CLASS( comments, COMMENTS );

- (BOOL)validate
{
  
	return YES;
}

@end


@implementation API_COMMENTS_LIST
@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_COMMENTS_LIST alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}
    
    NSString * requestURI = @"https://api.douban.com/v2/note/:id/comments";
    requestURI = [requestURI stringByReplacingOccurrencesOfString:@":id" withString:[self.id stringValue]];

		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;
    
		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_COMMENTS_LIST objectFromDictionary:(NSDictionary *)result];
		}
    
		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end




