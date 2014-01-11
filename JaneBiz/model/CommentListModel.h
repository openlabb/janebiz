//
//  CommentListModel.h
//  example
//
//  Created by kkgo on 14-1-4.
//  Copyright (c) 2014年 geek-zoo studio. All rights reserved.
//

#import "BaseModel.h"
#import "article.h"

@interface CommentListModel : SinglePageModel
@property (nonatomic, retain) NSMutableArray *	commentsArray;
@property (nonatomic, retain) NSNumber * noteid;
@end
