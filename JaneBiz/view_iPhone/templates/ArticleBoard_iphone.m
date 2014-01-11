//
//  ArticleBoard_iphone.m
//  example
//
//  Created by kkgo on 13-12-17.
//  Copyright (c) 2013年 geek-zoo studio. All rights reserved.
//

#import "ArticleBoard_iphone.h"

@interface ArticleBoard_iphone ()

@end

@implementation ArticleBoard_iphone
{
	BeeUIScrollView *			_scroll;
  ArticleListModel *		_articles;
}

@synthesize articles = _articles;

SUPPORT_RESOURCE_LOADING( YES );

SUPPORT_AUTOMATIC_LAYOUT( YES );

- (void)load
{
	self.articles = [ArticleListModel modelWithObserver:self];
}

- (void)unload
{
	[self.articles cancelMessages];
  self.articles = nil;
}


- (ArticleListModel *)currentModel
{
	return self.articles;
}


#pragma mark -

ON_SIGNAL2( BeeUIBoard, signal )
{
	[super handleUISignal:signal];
	
	if ( [signal is:BeeUIBoard.CREATE_VIEWS] )
	{
		self.view.backgroundColor = SHORT_RGB( 0x333 );
    //显示导航条
		[self showNavigationBarAnimated:NO];
    //显示导航条左侧按钮
		[self showBarButton:BeeUINavigationBar.LEFT image:[UIImage imageNamed:@"menu-button.png"]];
    //设置标题为Dribble
		[self setTitleString:@"简七读财"];
    
		_scroll = [BeeUIScrollView new];
		_scroll.dataSource = self;
		_scroll.vertical = YES;
		_scroll.lineCount = 1;
    //这个Inset好像没什么作用呢
		[_scroll setBaseInsets:UIEdgeInsetsMake( 0, 0,44+44, 0 )];
		[_scroll showHeaderLoader:YES animated:NO];
		[self.view addSubview:_scroll];
		
	}
	else if ( [signal is:BeeUIBoard.DELETE_VIEWS] )
	{
		SAFE_RELEASE_SUBVIEW( _scroll );
	}
	else if ( [signal is:BeeUIBoard.LAYOUT_VIEWS] )
	{
		_scroll.frame = CGRectInset( self.bounds, 4.0f, 0.0f );
	}
	else if ( [signal is:BeeUIBoard.WILL_APPEAR] )
	{
		[_scroll reloadData];
    
		[[self currentModel] firstPage];
	}
}

//点击左侧，显示左侧菜单
ON_SIGNAL3( BeeUINavigationBar, LEFT_TOUCHED, signal )
{
	[[AppBoard_iPhone sharedInstance] showMenu];
}

//上拉刷新，下拉下一篇
ON_SIGNAL2( BeeUIScrollView, signal )
{
	[super handleUISignal:signal];
	
	if ( [signal is:BeeUIScrollView.HEADER_REFRESH] )
	{
		[[self currentModel] firstPage];
	}
	else if ( [signal is:BeeUIScrollView.REACH_BOTTOM])// ||[signal is:BeeUIScrollView.FOOTER_REFRESH])
	{
		[[self currentModel] nextPage];
	}
}

ON_SIGNAL3( ArticleBoardCell_iPhone, mask, signal )
{
	ARTICLE * article = signal.sourceCell.data;
	
  ArticleDetailBoard_iPhone *board = [ArticleDetailBoard_iPhone board];
  board.articleInfo.article_id = article.id;
  board.comments.noteid = article.id;
  //[board.articleInfo firstPage];

  //ARTICLEINFO *articleInfo = [ARTICLEINFO new];

  [self.stack pushBoard:board animated:YES];
}

#pragma mark -

- (void)API_ARTICLES_LIST:(API_ARTICLES_LIST *)api
{
	if ( api.sending )
	{
		if ( NO == [self currentModel].loaded )
		{
			[self presentLoadingTips:@"Loading..."];
		}
	}
	else
	{
		[self dismissTips];
	}
  
	[_scroll setHeaderLoading:api.sending];
  
	if ( api.succeed )
	{
		[_scroll reloadData];
	}
	else if ( api.failed )
	{
		[self presentFailureTips:@"Error occurred"];
	}
}

#pragma mark -

- (NSInteger)numberOfViewsInScrollView:(BeeUIScrollView *)scrollView
{
	return [self currentModel].articleArray.count;
}

- (UIView *)scrollView:(BeeUIScrollView *)scrollView viewForIndex:(NSInteger)index scale:(CGFloat)scale
{
	ArticleBoardCell_iPhone * cell = [scrollView dequeueWithContentClass:[ArticleBoardCell_iPhone class]];
	cell.data = [[self currentModel].articleArray safeObjectAtIndex:index];
	return cell;
}

- (CGSize)scrollView:(BeeUIScrollView *)scrollView sizeForIndex:(NSInteger)index
{
	return [ArticleBoardCell_iPhone estimateUISizeByWidth:scrollView.width
                                                 forData:[[self currentModel].articleArray safeObjectAtIndex:index]];
}

@end


#pragma mark -

@implementation ArticleBoardCell_iPhone

SUPPORT_AUTOMATIC_LAYOUT( YES );
SUPPORT_RESOURCE_LOADING( YES );

- (void)dataDidChanged
{
	ARTICLE * article = self.data;
	if ( article )
	{
    if (article.images.count>0) {
      $(@"#photo").DATA([article.images[0] url]);
    }else{
      $(@"#photo").DATA(@"http://img3.douban.com/view/note/large/public/p10695473.jpg");
    }

    $(@"#title").DATA(article.title);
    $(@"#summary").DATA(article.summary);
		$(@"#liked-num").DATA( article.liked_count );
		$(@"#comment-num").DATA( article.comments_count );
	}
}

@end

