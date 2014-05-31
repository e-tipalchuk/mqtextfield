//  Copyright (c) 2014 Marqeta. All rights reserved.

#import "MainViewController.h"
#import "MainView.h"

#define EMAIL_REGEX @"^([0-9a-zA-Z]([-\\.\\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\\w]*[0-9a-zA-Z]\\.)+[a-zA-Z]{2,4})$"

#define FIRST_NAME_INVALID @"A first name is required!"
#define LAST_NAME_INVALID @"A last name is required!"
#define EMAIL_INVALID @"Doesn't look like a valid email address.\nExample: yourname@marqeta.com"
#define PASSWORD_INVALID @"Password must be at least 6 characters!"
#define PHONE_INVALID @"Doesn't look like a valid phone number\nExample: (877) 962-7738."

@interface MainViewController () <UIScrollViewDelegate, UITextFieldDelegate>

@property (nonatomic, readwrite, strong) MainView *mainView;

@end

@implementation MainViewController

- (void)loadView
{
	_mainView = [[MainView alloc] initWithDelegate:self];
	[self setView:_mainView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	self.title = @"MQTextField";
	self.edgesForExtendedLayout = UIRectEdgeNone;

	// Allow a tap outside of the text fields to hide keyboard.
	UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
																						   action:@selector(hideKeyboard)];

	[self.navigationController.view addGestureRecognizer:tapGestureRecognizer];

	// Notifications for keyboard methods.
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardDidShow:)
												 name:UIKeyboardDidShowNotification
											   object:nil];

	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardDidHide:)
												 name:UIKeyboardDidHideNotification
											   object:nil];
}

#pragma mark - Text field delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if ([textField respondsToSelector:@selector(setTextFieldState:)]) {
		[(MQTextField *)textField setTextFieldState:MQTextFieldStateActive];
	}
	return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	switch (textField.tag) {
		case MainViewEmailAddressTextFieldTag:
			return [self validateEmailAddressWithTextField:textField inRange:range replacementString:string];
			break;
		case MainViewPhoneNumberTextFieldTag:
			return [self validatePhoneNumberWithTextField:textField inRange:range replacementString:string];
			break;
		default:
			return YES;
			break;
	}
	return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
	if ([textField respondsToSelector:@selector(setTextFieldState:)]) {
		[(MQTextField *)textField setTextFieldState:MQTextFieldStateInactive];
	}
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	if (textField.tag == MainViewPhoneNumberTextFieldTag) {
		[textField resignFirstResponder];
	}
	return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	[self validateTextField:textField];
}

#pragma mark - Keyboard delegate
- (void)keyboardDidShow:(NSNotification *)notification
{
	UIScrollView *scrollView = self.mainView.scrollView;

	// Get view bounds of keyboard.
	CGRect keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
	keyboardRect = [self.view convertRect:keyboardRect toView:nil];

	// Change scrollView content insets to incorporate keyboard's height.
	UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0f, 0.0f, keyboardRect.size.height, 0.0f);
	[scrollView setContentInset:contentInsets];

	// Scroll view to center on text field's origin.
	CGRect textFieldRect = self.view.frame;
	textFieldRect.size.height -= keyboardRect.size.height;
	CGPoint textFieldOrigin = CGPointZero;
	textFieldOrigin.y -= scrollView.contentOffset.y;
	textFieldOrigin = [self.view convertPoint:textFieldOrigin toView:self.view.superview];

	if (!CGRectContainsPoint(textFieldRect, textFieldOrigin)) {
		[scrollView scrollRectToVisible:CGRectZero animated:YES];
	}
}

- (void)keyboardDidHide:(NSNotification *)notification
{
	UIScrollView *scrollView = self.mainView.scrollView;

	// Reset the scrollView content insets to original bounds.
	[scrollView setContentInset:UIEdgeInsetsZero];
	[scrollView setContentOffset:CGPointZero animated:YES];
	[scrollView.superview layoutSubviews];
}

#pragma mark - Validation methods
- (void)validateTextField:(UITextField *)textField
{
	UILabel *descriptionLabel = self.mainView.descriptionLabel;
	if ([textField respondsToSelector:@selector(setTextFieldState:)]) {
		MQTextField *validatedTextField = (MQTextField *)textField;
		switch (validatedTextField.tag) {
			case MainViewFirstNameTextFieldTag:
			{
				if (textField.text.length) {
					if ([descriptionLabel.text isEqualToString:FIRST_NAME_INVALID]) {
						descriptionLabel.text = nil;
					}
					[validatedTextField setTextFieldState:MQTextFieldStateValid];
				} else {
					descriptionLabel.text = FIRST_NAME_INVALID;
					[validatedTextField setTextFieldState:MQTextFieldStateInvalid];
				}
				break;
			}
			case MainViewLastNameTextFieldTag:
			{
				if (textField.text.length) {
					if ([descriptionLabel.text isEqualToString:LAST_NAME_INVALID]) {
						descriptionLabel.text = nil;
					}
					[validatedTextField setTextFieldState:MQTextFieldStateValid];
				} else {
					descriptionLabel.text = LAST_NAME_INVALID;
					[validatedTextField setTextFieldState:MQTextFieldStateInvalid];
				}
				break;
			}
			case MainViewEmailAddressTextFieldTag:
			{
				NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", EMAIL_REGEX];
				BOOL validEmail = [emailTest evaluateWithObject:validatedTextField.text];
				if (validEmail) {
					if ([descriptionLabel.text isEqualToString:EMAIL_INVALID]) {
						descriptionLabel.text = nil;
					}
					[validatedTextField setTextFieldState:MQTextFieldStateValid];
				} else {
					descriptionLabel.text = EMAIL_INVALID;
					[validatedTextField setTextFieldState:MQTextFieldStateInvalid];
				}
				break;
			}
			case MainViewPasswordTextFieldTag:
			{
				if (textField.text.length >= 6) {
					if ([descriptionLabel.text isEqualToString:PASSWORD_INVALID]) {
						descriptionLabel.text = nil;
					}
					[validatedTextField setTextFieldState:MQTextFieldStateValid];
				} else {
					descriptionLabel.text = PASSWORD_INVALID;
					[validatedTextField setTextFieldState:MQTextFieldStateInvalid];
				}
				break;
			}
			case MainViewPhoneNumberTextFieldTag:
			{
				NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"()- "];
				NSString *numberStr = [textField.text stringByTrimmingCharactersInSet:characterSet];
				BOOL validPhoneNumber = numberStr.length == 10;
				if (validPhoneNumber) {
					if ([descriptionLabel.text isEqualToString:PHONE_INVALID]) {
						descriptionLabel.text = nil;
					}
					[validatedTextField setTextFieldState:MQTextFieldStateValid];
				} else {
					descriptionLabel.text = PHONE_INVALID;
					[validatedTextField setTextFieldState:MQTextFieldStateInvalid];
				}
				break;
			}
			default:
				break;
		}
	}
}

- (BOOL)validateEmailAddressWithTextField:(UITextField *)textField inRange:(NSRange)range replacementString:(NSString *)string
{
	NSCharacterSet *characterSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
	if ([string rangeOfCharacterFromSet:characterSet].location != NSNotFound) {
		// Don't allow whitespace or line breaks.
		return NO;
	}

	return YES;
}

- (BOOL)validatePhoneNumberWithTextField:(UITextField *)textField inRange:(NSRange)range replacementString:(NSString *)string
{
	// Remove dashes from phone number.
	NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"()0123456789\b"];
	string = [string stringByReplacingOccurrencesOfString:@"-" withString:@""];
	if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
		// Don't allow non-decimal characters.
		return NO;
	}

	NSString *text = textField.text;
	text = [text stringByReplacingCharactersInRange:range withString:string];
	text = [text stringByReplacingOccurrencesOfString:@"(" withString:@""];
	text = [text stringByReplacingOccurrencesOfString:@")" withString:@""];
	text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
	text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];

	NSString *newString = @"";
	while (text.length > 0) {
		// First set of numbers.
		NSString *subString1 = [text substringToIndex:MIN(text.length, 3)];
		newString = [newString stringByAppendingString:subString1];
		if (subString1.length) {
			newString = [@"(" stringByAppendingString:newString];
		}
		// Handle backspace into first set of numbers.
		if (subString1.length == 3 && text.length > 3) {
			newString = [newString stringByAppendingString:@") "];
		}
		if (subString1.length < 4) {
			text = [text substringFromIndex:MIN(text.length, 3)];
		}
		// Second set of numbers.
		NSString *subString2 = [text substringToIndex:MIN(text.length, 3)];
		newString = [newString stringByAppendingString:subString2];
		if (subString2.length == 3) {
			newString = [newString stringByAppendingString:@"-"];
		}
		if (subString2.length < 5) {
			text = [text substringFromIndex:MIN(text.length, 3)];
		}
		// Third set of numbers.
		NSString *subString3 = [text substringToIndex:MIN(text.length, 4)];
		newString = [newString stringByAppendingString:subString3];
		if (subString3.length < 17) {
			text = [text substringFromIndex:MIN(text.length, 11)];
		}
	}

	newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
	if (newString.length > 14) {
		return NO;
	}

	[textField setText:newString];
	return NO;
}

#pragma mark - Action methods
- (void)hideKeyboard
{
	[self.mainView endEditing:YES];
}

@end
