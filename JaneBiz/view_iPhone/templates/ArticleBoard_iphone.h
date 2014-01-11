//
//  ArticleBoard_iphone.h
//  example
//
//  Created by kkgo on 13-12-17.
//  Copyright (c) 2013年 geek-zoo studio. All rights reserved.
//

#import "Bee.h"
#import "model.h"
#import "AppBoard_iPhone.h"
#import "ArticleDetailBoard_iPhone.h"
#import "ArticleListModel.h"
@interface ArticleBoard_iphone : BeeUIBoard
@property (nonatomic, retain) ArticleListModel *	articles;

@end

#pragma mark -

@interface ArticleBoardCell_iPhone : BeeUICell


@end

