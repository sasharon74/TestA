//
//  ViewController.m
//  TestA
//
//  Created by Alex on 15.10.15.
//  Copyright © 2015 Alex. All rights reserved.
//

#import "MainViewController.h"
#import "ViewPage.h"
#import "AFHTTPRequestOperationManager.h"
#import "ContentController.h"
#import "ModelPage.h"

NSString *const urlGetPages = @"http://v12.50pages.ru/api/json/magazines/53232236e6673f100b00002c/10/0/";

@interface MainViewController ()

@property (nonatomic, strong) NSMutableArray *contentArray;

@end

@implementation MainViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.contentArray = [NSMutableArray array];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [activityIndicator setAlpha:1.0];
    [activityIndicator setCenter:self.view.center];
    [self.view addSubview:activityIndicator];
    [activityIndicator startAnimating];
    
    AFHTTPRequestOperationManager *requestOperationManager = [AFHTTPRequestOperationManager manager];
    [requestOperationManager GET:urlGetPages parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        if ([responseObject count] != 0)
        {
            NSMutableArray *arrayObject = [NSMutableArray array];
            for (NSDictionary *dict in responseObject)
            {
                ModelPage *page = [[ModelPage alloc]initWithDictionary:dict];
                [arrayObject addObject:page];
            }

            self.contentArray = arrayObject;
        
            [activityIndicator removeFromSuperview];
        
            self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
            self.pageViewController.dataSource = self;
        
            ContentController *firstContentController = [self viewControllerAtIndex:0];
            NSArray *contentControllers = @[firstContentController];
            [self.pageViewController setViewControllers:contentControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        
            self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            [self addChildViewController:self.pageViewController];
            [self.view addSubview:self.pageViewController.view];
            [self.pageViewController didMoveToParentViewController:self];
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        NSLog(@"Error: %@", error);
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Не удалось получить данные" message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
        [activityIndicator removeFromSuperview];
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark = Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = ((ContentController *) viewController).pageIndex;
    if ((index == 0) || (index == NSNotFound))
    {
        return nil;
    }
    index--;
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = ((ContentController *) viewController).pageIndex;
    if (index == NSNotFound)
    {
        return nil;
    }
    index++;
    
    if (index == [self.contentArray count])
    {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}

- (ContentController *)viewControllerAtIndex: (NSUInteger)index
{
    if (([self.contentArray count] == 0) || (index >= [self.contentArray count]))
    {
        return nil;
    }
    
    ContentController *contentController = [self.storyboard instantiateViewControllerWithIdentifier:@"ContentController"];
    
    ModelPage *dictionaryContent = [self.contentArray objectAtIndex:index];
    
    ViewPage *viewPage = [[ViewPage alloc]initWithFrame:self.view.frame withUrlImage:dictionaryContent.urlImage withTitle:dictionaryContent.title withDate:dictionaryContent.date withText:dictionaryContent.text];
    [contentController.view addSubview:viewPage];
    contentController.pageIndex = index;
    
    return contentController;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.contentArray count];
}

@end
