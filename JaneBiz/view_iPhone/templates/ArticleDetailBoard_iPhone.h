//
//  ArticleDetailBoard.h
//  example
//
//  Created by kkgo on 13-12-21.
//  Copyright (c) 2013年 geek-zoo studio. All rights reserved.
//

#import "Bee_UIBoard.h"
#import "Bee.h"
#import "model.h"
#import "article.h"
#import "CommentListModel.h"
#import "ArticleInfoModel.h"
#import "AppBoard_iPhone.h"

#pragma mark -
@interface ArticleDetailBoardHeader_iPhone : BeeUICell
@end



@interface ArticleDetailBoardComment_iPhone : BeeUICell

@end

@interface ArticleDetailBoard_iPhone : BeeUIBoard
@property (nonatomic, retain) ArticleInfoModel *	articleInfo;
@property (nonatomic, retain) CommentListModel *	comments;

@end
