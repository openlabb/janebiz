//
//  ArticleDetailBoard.m
//  example
//
//  Created by kkgo on 13-12-21.
//  Copyright (c) 2013年 geek-zoo studio. All rights reserved.
//

#import "ArticleDetailBoard_iPhone.h"

#pragma mark -

@implementation ArticleDetailBoardHeader_iPhone

SUPPORT_RESOURCE_LOADING( YES )
SUPPORT_AUTOMATIC_LAYOUT( YES )

- (void)dataDidChanged
{
	ARTICLEINFO * articleInfo = self.data;
	if ( articleInfo )
	{
   AUTHOR *author =  (AUTHOR *)articleInfo.author[0];
		//$(@"#avatar").DATA( author.avatar );
		$(@"#title").DATA( articleInfo.title );
		$(@"#name").DATA( author.name );
		$(@"#time").DATA( [[articleInfo.update_time asNSDate] stringWithDateFormat:@"MM-dd HH:mm:ss yyyy"] );
		BeeUIWebView *webView = (BeeUIWebView *)$(@"#content").view;
    for (id subview in webView.subviews){
      if ([[subview class] isSubclassOfClass: [UIScrollView class]])
        ((UIScrollView *)subview).bounces = NO;
    }
    NSString* htmlHeader=[NSString stringWithFormat:@"<html><head>\
                          <style type=\"text/css\">\
                          * {\
                                             margin: 0;\
                                            padding: 5;\
                                             border: none;\
                                            outline: none;\
                          font-size:17px;\
                          word-wrap: break-word;\
                          -webkit-text-size-adjust: none;\
                          -webkit-tap-highlight-color: #7DB5EC;\
                          }\
                          article, aside, canvas, figure, figure img, figcaption, hgroup, footer, header, nav, section, audio, video {\
                                            display: block;\
                                           position: relative;\
                          }\
                          p{ text-indent:20px;}\
                          table {\
                            border-collapse: collapse;\
                            border-spacing: 0;\
                          }\
                          img {\
                          color: transparent;\
                            font-size: 0;\
                          max-width: 80%%;\
                                              width:289px;\
                                             height:189px;\
                          vertical-align: middle;\
                          margin-left:px 0;\
                                            display:block;\
                                             margin: 10px auto;\
                            vertical-align: middle;\
                            -ms-interpolation-mode: bicubic;\
                          }\
                          a {\
                          color: #105CB6;\
                          }\
                          html {\
                          background: transparent;\
                          }\
                          body {\
                          font: normal 16px/1.5 \"Helvetica Neue\", Arial, sans-serif;\
                            font-family:\"STHeitiSC-Light\";\
                            word-wrap: break-wor;\
                          color: #333;\
                            text-shadow: 0 1px 0 #fff;\
                            text-align: left;\
                            background-color:#ffffff;\
                          color:#1f1f1f;\
                          }\
                          </style>\
                          </head><body>"];
    NSString* htmlFooter = @"</body></html>";
    NSString* htmlString=[[NSString alloc] initWithFormat:@"%@%@%@",htmlHeader,articleInfo.content,htmlFooter];
    [webView setHtml:htmlString];
    //[webView loadHTMLString:articleInfo.content baseURL:nil];
    //$(@"#content").DATA(articleInfo.content);
    
		$(@"#comment-num").DATA( articleInfo.recs_count );
		$(@"#like-num").DATA( articleInfo.liked_count );
	}
}
@end

@implementation ArticleDetailBoardComment_iPhone

SUPPORT_RESOURCE_LOADING(YES)
SUPPORT_AUTOMATIC_LAYOUT(YES)

- (void)dataDidChanged{
  COMMENTS * comment = self.data;
  if (comment) {
      //AUTHOR *author = (AUTHOR *)comment.author[0];
      $(@"avatar").DATA( comment.author.avatar );
	    $(@"name").DATA( comment.author.name );
	   	$(@"text").DATA( comment.content );
	  	$(@"time").DATA( [[comment.created asNSDate] stringWithDateFormat:@"MM-dd HH:mm:ss yyyy"] );
  }
}

@end

@implementation ArticleDetailBoard_iPhone{
  BeeUIScrollView * _scroll;
  CommentListModel *_comments;
  ArticleInfoModel *_articleInfo;
}

@synthesize articleInfo = _articleInfo;
@synthesize comments = _comments;

SUPPORT_AUTOMATIC_LAYOUT(YES);
SUPPORT_RESOURCE_LOADING(YES);

-(void)load{
  self.articleInfo = [ArticleInfoModel modelWithObserver:self];
  self.comments = [CommentListModel modelWithObserver:self];
}

-(void)unload{
  [self.articleInfo cancelMessages];
  self.articleInfo = nil;
  
  [self.comments cancelMessages];
  self.comments = nil;
}

#pragma mark -

ON_SIGNAL2( BeeUIBoard, signal ){
  [super handleUISignal:signal];
  if ([signal is:BeeUIBoard.CREATE_VIEWS]) {
    self.view.backgroundColor = SHORT_RGB(0x333);
  
    [self showNavigationBarAnimated:NO];
    [self showBarButton:BeeUINavigationBar.LEFT image:[UIImage imageNamed:@"navigation-back.png"]];
    [self setTitleString:@"每天读一点理财小知识"];
  
    _scroll = [BeeUIScrollView new];
    _scroll.dataSource = self;
    _scroll.vertical = YES;
    _scroll.lineCount = 1;
    [_scroll setBaseInsets:UIEdgeInsetsMake(0, 0, 44, 0)];
    [_scroll showHeaderLoader:YES animated:NO];
    [self.view addSubview:_scroll];
  }
  else if([signal is:BeeUIBoard.DELETE_VIEWS]){
    SAFE_RELEASE_SUBVIEW(_scroll);
  }else if([signal is:BeeUIBoard.LAYOUT_VIEWS]){
    _scroll.frame = self.bounds;
  }else if([signal is:BeeUIBoard.WILL_APPEAR]){
    [_scroll reloadData];
    [self.articleInfo firstPage];
    [self.comments firstPage];
  }
}

ON_SIGNAL3(BeeUINavigationBar, LEFT_TOUCHED, signal){
  [self.stack popBoardAnimated:YES];
}

ON_SIGNAL2(BeeUIScrollView, signal){
  [super handleUISignal:signal];
  if ([signal is:BeeUIScrollView.HEADER_REFRESH]) {
    [self.articleInfo firstPage];
    [self.comments firstPage];
  }
  else if ([signal is:BeeUIScrollView.REACH_BOTTOM]){
   // [self.comments nextPage];
  }
}

ON_SIGNAL3(ArticleDetailBoardHeader_iPhone, content, signal){
  if ([signal is:BeeUIWebView.DID_LOAD_FINISH]) {
     }
}

#pragma mark -

-(void)API_ARTICLEINFO_ID:(API_ARTICLEINFO_ID *)api{
  if (api.sending) {
    if (NO==self.articleInfo.loaded) {
      [self presentLoadingTips:@"Loading..."];
    }
  }	else
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

- (void)API_COMMENTS_LIST:(API_COMMENTS_LIST *)api
{
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
	return 1 + self.comments.commentsArray.count;
}

- (UIView *)scrollView:(BeeUIScrollView *)scrollView viewForIndex:(NSInteger)index scale:(CGFloat)scale
{
	if ( 0 == index )
	{
		ArticleDetailBoardHeader_iPhone * cell = [scrollView dequeueWithContentClass:[ArticleDetailBoardHeader_iPhone class]];
		cell.data = self.articleInfo.articleInfo;
		return cell;
	}
	else
	{
		ArticleDetailBoardComment_iPhone * cell = [scrollView dequeueWithContentClass:[ArticleDetailBoardComment_iPhone class]];
		cell.data = [self.comments.commentsArray safeObjectAtIndex:index - 1];
		return cell;
	}
}

- (CGSize)scrollView:(BeeUIScrollView *)scrollView sizeForIndex:(NSInteger)index
{
	if ( 0 == index )
	{
		return [ArticleDetailBoardHeader_iPhone estimateUISizeByWidth:scrollView.width forData:self.articleInfo.articleInfo];
	}
	else
	{
		return [ArticleDetailBoardComment_iPhone estimateUISizeByWidth:scrollView.width
                                                            forData:[self.comments.commentsArray safeObjectAtIndex:index - 1]];
	}
}


@end
