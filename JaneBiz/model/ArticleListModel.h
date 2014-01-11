//
//  ArticleListModel.h
//  example
//
//  Created by kkgo on 13-12-21.
//  Copyright (c) 2013年 geek-zoo studio. All rights reserved.
//

#import "BaseModel.h"
#import "article.h"
@interface ArticleListModel : MultiPageModel
@property (nonatomic, retain) NSMutableArray *	articleArray;
@end
