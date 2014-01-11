//
//  ArticleInfoModel.h
//  example
//
//  Created by kkgo on 13-12-21.
//  Copyright (c) 2013年 geek-zoo studio. All rights reserved.
//

#import "BaseModel.h"
#import "article.h"
@interface ArticleInfoModel : SinglePageModel

@property (nonatomic, retain) NSNumber *		article_id;
@property (nonatomic, retain) ARTICLEINFO *			articleInfo;

@end
