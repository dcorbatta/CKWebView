//
//  FirstViewController.m
//  WebViewTest
//
//  Created by Daniel Nestor Corbatta Barreto on 14/11/13.
//  Copyright (c) 2013 Daniel Nestor Corbatta Barreto. All rights reserved.
//

@interface UIWebBrowserView : UIWebView

@end

#import "FirstViewController.h"

@implementation UIView (FindFirstResponder)
- (UIView *)findFirstResponder
{
    if (self.isFirstResponder) {
        return self;
    }
    
    for (UIView *subView in self.subviews) {
        UIView *firstResponder = [subView findFirstResponder];
        
        if (firstResponder != nil) {
            return firstResponder;
        }
    }
    
    return nil;
}
@end

@interface FirstViewController ()<UITextViewDelegate>{
    BOOL webViewFR;
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextView *temporalTextView;
@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    PMCustomKeyboard *customKeyboard = [[PMCustomKeyboard alloc] init];
    [customKeyboard setTextView:self.textView];
    
    [self.webView loadHTMLString:@"<html><body><input id=\"inputText\" type=\"text\" ></input></body></html>" baseURL:nil];
    
    PMCustomKeyboard *customKeyboard2 = [[PMCustomKeyboard alloc] init];
    [customKeyboard2 setTextView:self.temporalTextView];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];

    self.temporalTextView.delegate = self;
    
}
- (void)keyboardWillShow:(NSNotification *)notification {
    UIView * v = [self.webView findFirstResponder];
    
    if([v isKindOfClass:[UIWebBrowserView class]]){
        webViewFR = YES;
        NSString* script = [NSString stringWithFormat:@"document.activeElement.value;"];
        
        self.temporalTextView.text = [self.webView stringByEvaluatingJavaScriptFromString:script];
        [self.temporalTextView becomeFirstResponder];
    }
    
}

- (void)textViewDidChange:(UITextView *)textView{
    NSString* script = [NSString stringWithFormat:@"document.activeElement.value = '%@';", textView.text];
    
    [self.webView stringByEvaluatingJavaScriptFromString:script];
    
}
- (void) textViewDidEndEditing:(UITextView *)textView{
    textView.text = @"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
