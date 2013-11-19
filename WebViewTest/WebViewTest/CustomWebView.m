//
//  CustomWebView.m
//  WebViewTest
//
//  Created by Daniel Nestor Corbatta Barreto on 14/11/13.
//  Copyright (c) 2013 Daniel Nestor Corbatta Barreto. All rights reserved.
//

#import "CustomWebView.h"

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

@interface CustomWebView()<UITextViewDelegate>

@end
@implementation CustomWebView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        
        self.textView.delegate = self;
    }
    return self;
}

- (void) awakeFromNib{
    [super awakeFromNib];
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    self.textView.delegate = self;
    self.textView.hidden = YES;
    [self addSubview:self.textView];
}
- (void)keyboardWillShow:(NSNotification *)notification {
    UIView * v = [self findFirstResponder];
    
    if(v){
        NSString* script = [NSString stringWithFormat:@"document.activeElement.value;"];
        self.textView.text = [self stringByEvaluatingJavaScriptFromString:script];
        [self.textView becomeFirstResponder];
    }
    
}

- (void)textViewDidChange:(UITextView *)textView{
    NSString* script = [NSString stringWithFormat:@"document.activeElement.value = '%@';", textView.text];
    
    [self stringByEvaluatingJavaScriptFromString:script];
}
- (void) textViewDidEndEditing:(UITextView *)textView{
    textView.text = @"";
}

@end
