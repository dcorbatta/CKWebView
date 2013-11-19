//
//  SecondViewController.m
//  WebViewTest
//
//  Created by Daniel Nestor Corbatta Barreto on 14/11/13.
//  Copyright (c) 2013 Daniel Nestor Corbatta Barreto. All rights reserved.
//

#import "SecondViewController.h"
#import "CustomWebView.h"
#import "PMCustomKeyboard.h"
@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet CustomWebView *webView;

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    PMCustomKeyboard *customKeyboard = [[PMCustomKeyboard alloc] init];
    [customKeyboard setTextView:self.webView.textView];
    
    [self.webView loadHTMLString:@"<html><body><input id=\"inputText\" type=\"text\" ></input></body></html>" baseURL:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
