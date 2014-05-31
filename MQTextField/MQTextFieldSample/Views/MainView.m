//  Copyright (c) 2014 Marqeta. All rights reserved.

#import "MainView.h"

#define BLUE_COLOR [UIColor colorWithRed:0.0f green:0.616f blue:0.859f alpha:0.5f]

@interface MainView ()

@property (nonatomic, readwrite, strong) MQTextField *firstNameTextField;
@property (nonatomic, readwrite, strong) MQTextField *lastNameTextField;
@property (nonatomic, readwrite, strong) MQTextField *emailAddressTextField;
@property (nonatomic, readwrite, strong) MQTextField *passwordTextField;
@property (nonatomic, readwrite, strong) MQTextField *phoneNumberTextField;
@property (nonatomic, readwrite, strong) UILabel *descriptionLabel;
@property (nonatomic, readwrite, strong) UIView *descriptionView;
@property (nonatomic, readwrite, strong) UIScrollView *scrollView;

@end

@implementation MainView

- (id)initWithDelegate:(id<UITextFieldDelegate>)delegate
{
	if (self = [super init]) {
		_padding = 5.0f;
		_descriptionViewHeight = 44.0f;
		_textFieldHeight = 44.0f;

		_scrollView = [[UIScrollView alloc] init];

		_descriptionView = [[UIView alloc] init];
		_descriptionView.backgroundColor = BLUE_COLOR;

		_descriptionLabel = [[UILabel alloc] init];
		_descriptionLabel.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
		_descriptionLabel.textAlignment = NSTextAlignmentCenter;
		_descriptionLabel.textColor = [UIColor whiteColor];

		[_descriptionView addSubview:_descriptionLabel];

		_firstNameTextField = [[MQTextField alloc] initWithDelegate:delegate
													 textFieldStyle:MQTextFieldStyleFlatValidationWithoutStroke
											 autocapitalizationType:UITextAutocapitalizationTypeWords
												 autocorrectionType:UITextAutocorrectionTypeDefault
													clearButtonMode:UITextFieldViewModeWhileEditing
													   keyboardType:UIKeyboardTypeAlphabet
														placeholder:@"Johnny"
													  returnKeyType:UIReturnKeyNext
																tag:MainViewFirstNameTextFieldTag];

		_lastNameTextField = [[MQTextField alloc] initWithDelegate:delegate
													textFieldStyle:MQTextFieldStyleFlatValidationWithoutStroke
											autocapitalizationType:UITextAutocapitalizationTypeWords
												autocorrectionType:UITextAutocorrectionTypeDefault
												   clearButtonMode:UITextFieldViewModeWhileEditing
													  keyboardType:UIKeyboardTypeAlphabet
													   placeholder:@"Appleseed"
													 returnKeyType:UIReturnKeyNext
															   tag:MainViewLastNameTextFieldTag];

		_emailAddressTextField = [[MQTextField alloc] initWithDelegate:delegate
														textFieldStyle:MQTextFieldStyleFlatValidationWithoutStroke
												autocapitalizationType:UITextAutocapitalizationTypeNone
													autocorrectionType:UITextAutocorrectionTypeNo
													   clearButtonMode:UITextFieldViewModeWhileEditing
														  keyboardType:UIKeyboardTypeEmailAddress
														   placeholder:@"johnny.appleseed@apple.com"
														 returnKeyType:UIReturnKeyNext
																   tag:MainViewEmailAddressTextFieldTag];

		_passwordTextField = [[MQTextField alloc] initWithDelegate:delegate
													textFieldStyle:MQTextFieldStyleFlatValidationWithoutStroke
											autocapitalizationType:UITextAutocapitalizationTypeNone
												autocorrectionType:UITextAutocorrectionTypeNo
												   clearButtonMode:UITextFieldViewModeWhileEditing
													  keyboardType:UIKeyboardTypeDefault
													   placeholder:@"Please enter a password"
													 returnKeyType:UIReturnKeyNext
															   tag:MainViewPasswordTextFieldTag];
		_passwordTextField.secureTextEntry = YES;

		_phoneNumberTextField = [[MQTextField alloc] initWithDelegate:delegate
													   textFieldStyle:MQTextFieldStyleFlatValidationWithoutStroke
											   autocapitalizationType:UITextAutocapitalizationTypeNone
												   autocorrectionType:UITextAutocorrectionTypeNo
													  clearButtonMode:UITextFieldViewModeWhileEditing
														 keyboardType:UIKeyboardTypePhonePad
														  placeholder:@"(800) 692-7753"
														returnKeyType:UIReturnKeyDone
																  tag:MainViewPhoneNumberTextFieldTag];

		[_scrollView addSubview:_firstNameTextField];
		[_scrollView addSubview:_lastNameTextField];
		[_scrollView addSubview:_emailAddressTextField];
		[_scrollView addSubview:_passwordTextField];
		[_scrollView addSubview:_phoneNumberTextField];
		[self addSubview:_scrollView];
		[self addSubview:_descriptionView];
	}
	return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];

	CGRect bounds = self.bounds;

	CGFloat xOrigin = bounds.origin.x;
	CGFloat yOrigin = bounds.origin.y;

	_descriptionView.frame = CGRectMake(xOrigin,
										yOrigin,
										bounds.size.width,
										_descriptionViewHeight);

	_descriptionLabel.frame = _descriptionView.bounds;

	yOrigin += _descriptionView.frame.size.height - (_padding * 2.0f);

	_scrollView.frame = CGRectMake(xOrigin,
								   yOrigin,
								   bounds.size.width,
								   bounds.size.height - _descriptionView.frame.size.height);

	_firstNameTextField.frame = CGRectMake(xOrigin,
										   yOrigin,
										   bounds.size.width,
										   _textFieldHeight);

	yOrigin += _firstNameTextField.frame.size.height + (_padding * 2.0f);

	_lastNameTextField.frame = CGRectMake(xOrigin,
										  yOrigin,
										  bounds.size.width,
										  _textFieldHeight);

	yOrigin += _lastNameTextField.frame.size.height + (_padding * 2.0f);

	_emailAddressTextField.frame = CGRectMake(xOrigin,
											  yOrigin,
											  bounds.size.width,
											  _textFieldHeight);

	yOrigin += _emailAddressTextField.frame.size.height + (_padding * 2.0f);

	_passwordTextField.frame = CGRectMake(xOrigin,
										  yOrigin,
										  bounds.size.width,
										  _textFieldHeight);

	yOrigin += _passwordTextField.frame.size.height + (_padding * 2.0f);

	_phoneNumberTextField.frame = CGRectMake(xOrigin,
											 yOrigin,
											 bounds.size.width,
											 _textFieldHeight);

	yOrigin += _phoneNumberTextField.frame.size.height + (_padding * 2.0f);

	_scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, yOrigin);
}

@end
