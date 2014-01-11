//
//  article.h
//  example
//
//  Created by kkgo on 13-12-21.
//  Copyright (c) 2013年 geek-zoo studio. All rights reserved.
//
#import "Bee.h"

#pragma mark - models

/*
 "user":
 {"loc_id":"108296",
 "name":"简七君",
 "created":"2008-08-07 21:03:59",
 "is_banned":false,
 "is_suicide":false,
 "loc_name":"上海",
 "avatar":"http:\/\/img3.douban.com\/icon\/u2792480-123.jpg",
 "signature":"微信号-简七读财",
 "uid":"jane77tang",
 "alt":"http:\/\/www.douban.com\/people\/jane77tang\/",
 "desc":" ",
 "type":"user",
 "id":"2792480",
 "large_avatar":"http:\/\/img3.douban.com\/icon\/up2792480-123.jpg"}
 }
 */

@interface IMAGE : BeeActiveObject
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSNumber * index;
@end

@interface USER : BeeActiveObject
@property (nonatomic, retain) NSNumber *		loc_id;
@property (nonatomic, retain) NSString *		name;
@property (nonatomic, retain) NSString *		created;
@property (nonatomic, retain) NSString *		is_banned;
@property (nonatomic, retain) NSString *		is_suicide;
@property (nonatomic, retain) NSString *		loc_name;
@property (nonatomic, retain) NSString *		avatar;
@property (nonatomic, retain) NSString *		signature;
@property (nonatomic, retain) NSString *		uid;
@property (nonatomic, retain) NSString *		alt;
@property (nonatomic, retain) NSString *		desc;
@property (nonatomic, retain) NSString *		type;
@property (nonatomic, retain) NSNumber *		id;
@property (nonatomic, retain) NSString *		large_avatar;
@end

/*
 {
 "count":1,
 "start":0,
 "notes":
     [
           {
                "update_time":"2013-12-20 14:57:03",
                "publish_time":"2013-12-19 17:12:19",
                "photos":{
                     "10573056":"http:\/\/img5.douban.com\/view\/note\/large\/public\/p10573056.jpg",
                     "10573060":"http:\/\/img3.douban.com\/view\/note\/large\/public\/p10573060.jpg"
                          },
                "recs_count":3,
                "images":[
                          {
                               "url":"http:\/\/img5.douban.com\/view\/note\/large\/public\/p10573056.jpg",
                               "index":1,
                               "id":"10573056"
                          },
                          {
                               "url":"http:\/\/img3.douban.com\/view\/note\/large\/public\/p10573060.jpg",
                               "index":2,"id":"10573060"
                          }
                          ],
                "alt":"http:\/\/www.douban.com\/note\/322060674\/",
                "id":"322060674",
                "can_reply":true,
                "title":"【破茧成蝶】中专生的逆袭（6）：自学搞定英语老大难",
                "privacy":"public",
                "summary":"【简七导读】 大家还记得蝴蝶薇安分享的创业日记吗？可知道蝴蝶是怎么一步步走过来...",
                "content":"",
                "comments_count":3,
                "liked_count":34
           }
      ],
 "total":126,
 "user":
    { "loc_id":"108296",
      "name":"简七君",
      "created":"2008-08-07 21:03:59",
      "is_banned":false,
      "is_suicide":false,
      "loc_name":"上海",
      "avatar":"http:\/\/img3.douban.com\/icon\/u2792480-123.jpg",
      "signature":"微信号-简七读财",
      "uid":"jane77tang",
      "alt":"http:\/\/www.douban.com\/people\/jane77tang\/",
      "desc":" ",
      "type":"user",
      "id":"2792480",
      "large_avatar":"http:\/\/img3.douban.com\/icon\/up2792480-123.jpg"
    }
}
 */



@interface ARTICLE : BeeActiveObject
@property (nonatomic, retain) NSNumber *		id;
@property (nonatomic, retain) NSString *		update_time;
@property (nonatomic, retain) NSString *		publish_time;
@property (nonatomic, retain) NSNumber *		recs_count;
@property (nonatomic, retain) NSArray *		images;
@property (nonatomic, retain) NSString *		alt;
@property (nonatomic, retain) NSString *		can_reply;
@property (nonatomic, retain) NSString *		title;
@property (nonatomic, retain) NSString *		privacy;
@property (nonatomic, retain) NSString *		summary;
@property (nonatomic, retain) NSString *		content;
@property (nonatomic, retain) NSNumber *		comments_count;
@property (nonatomic, retain) NSNumber *		liked_count;
@property (nonatomic, retain) USER *		user;
@property (nonatomic, retain) NSNumber *		total;
@end


@interface AUTHOR : BeeActiveObject

@property (nonatomic, retain) NSString *		name;
@property (nonatomic, retain) NSString *		is_banned;
@property (nonatomic, retain) NSString *		is_suicide;
@property (nonatomic, retain) NSString *		avatar;
@property (nonatomic, retain) NSString *		uid;
@property (nonatomic, retain) NSString *		alt;
@property (nonatomic, retain) NSString *		type;
@property (nonatomic, retain) NSNumber *		id;
@property (nonatomic, retain) NSString *		large_avatar;
@end

@interface COMMENTS : BeeActiveObject
@property (nonatomic, retain) NSString *		content;
@property (nonatomic, retain) NSString *		created;
@property (nonatomic, retain) NSNumber *		id;
@property (nonatomic, retain) AUTHOR *		author;
@end

@interface ARTICLEINFO : BeeActiveObject
@property (nonatomic, retain) NSString *		alt;
@property (nonatomic, retain) NSArray * author;
@property (nonatomic, retain) NSString *		can_reply;
@property (nonatomic, retain) NSNumber *		comments_count;
@property (nonatomic, retain) NSString *		content;
@property (nonatomic, retain) NSNumber *		id;
@property (nonatomic, retain) NSArray *		images;
@property (nonatomic, retain) NSNumber *		liked_count;
@property (nonatomic, retain) NSArray * photos;
@property (nonatomic, retain) NSString *		privacy;
@property (nonatomic, retain) NSString *		publish_time;
@property (nonatomic, retain) NSNumber *		recs_count;
@property (nonatomic, retain) NSString *		summary;
@property (nonatomic, retain) NSString *		title;
@property (nonatomic, retain) NSString *		update_time;

@end


#pragma mark - controller

#pragma mark - GET /users/:id

@interface REQ_USERS_ID : BeeActiveObject
@end


@interface API_USERS_ID : BeeRoutine
@property (nonatomic, retain) NSString *	id;
@property (nonatomic, retain) REQ_USERS_ID *	req;
@property (nonatomic, retain) USER *	resp;
@end




#pragma mark - GET /article/:id

@interface REQ_ARTICLES_ID : BeeActiveObject
@end


@interface API_ARTICLES_ID : BeeRoutine
@property (nonatomic, retain) NSString *	id;
@property (nonatomic, retain) REQ_ARTICLES_ID *	req;
@property (nonatomic, retain) ARTICLE *	resp;
@end


#pragma mark - GET /articleinfo/:id

@interface REQ_ARTICLEINFO_ID : BeeActiveObject
@property (nonatomic, retain) NSNumber *		start;
@property (nonatomic, retain) NSNumber *		count;
@end

@interface RESP_ARTICLEINFO_ID : BeeActiveObject
@property (nonatomic, retain) ARTICLEINFO  * articleInfo;
@end

@interface API_ARTICLEINFO_ID : BeeRoutine
@property (nonatomic, retain) NSNumber *		id;
@property (nonatomic, retain) REQ_ARTICLEINFO_ID *	req;
@property (nonatomic, retain) RESP_ARTICLEINFO_ID *	resp;
@end




#pragma mark - GET /articles/:list

@interface REQ_ARTICLES_LIST : BeeActiveObject
@property (nonatomic, retain) NSNumber *		start;
@property (nonatomic, retain) NSNumber *		count;
@end

@interface RESP_ARTICLES_LIST : BeeActiveObject
@property (nonatomic, retain) NSNumber *		count;
@property (nonatomic, retain) NSNumber *		start;
@property (nonatomic, retain) NSArray *		notes;
@property (nonatomic, retain) NSNumber *		total;
@property (nonatomic, retain) USER * user;
@end

@interface API_ARTICLES_LIST : BeeRoutine
@property (nonatomic, retain) REQ_ARTICLES_LIST *	req;
@property (nonatomic, retain) RESP_ARTICLES_LIST *	resp;
@end


#pragma mark - GET /comments/:list

@interface REQ_COMMENTS_LIST : BeeActiveObject
@end

@interface RESP_COMMENTS_LIST : BeeActiveObject
@property (nonatomic, retain) NSNumber *		count;
@property (nonatomic, retain) NSNumber *		start;
@property (nonatomic, retain) NSNumber *		total;
@property (nonatomic, retain) NSArray *		comments;
@end

@interface API_COMMENTS_LIST : BeeRoutine
@property (nonatomic, retain) NSNumber *	id;
@property (nonatomic, retain) REQ_COMMENTS_LIST *	req;
@property (nonatomic, retain) RESP_COMMENTS_LIST *	resp;
@end



