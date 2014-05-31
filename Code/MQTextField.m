//  Copyright (c) 2014 Marqeta, Inc. All rights reserved.

#import "MQTextField.h"
#import <QuartzCore/QuartzCore.h>

@interface MQTextField ()

@property (nonatomic, readwrite, strong) UIImageView *imageView;

@end

@implementation MQTextField

- (id)initWithDelegate:(id<UITextFieldDelegate>)delegate
autocapitalizationType:(UITextAutocapitalizationType)autocapitalizationType
	autocorrectionType:(UITextAutocorrectionType)autocorrectionType
		  keyboardType:(UIKeyboardType)keyboardType
		   placeholder:(NSString *)placeholder
		 returnKeyType:(UIReturnKeyType)returnKeyType
				   tag:(NSInteger)tag
{
	if (self = [super init]) {
		self.delegate = delegate;
		self.backgroundColor = [UIColor whiteColor];
		self.borderStyle = UITextBorderStyleNone;
		self.autocapitalizationType = autocapitalizationType;
		self.autocorrectionType = autocorrectionType;
		self.clearButtonMode = UITextFieldViewModeWhileEditing;
		self.keyboardType = keyboardType;
		self.placeholder = placeholder;
		self.returnKeyType = returnKeyType;
		self.tag = tag;

		_padding = 5.0f;
		_shadowOpacity = 0.8f;
		_shadowRadius = 2.0f;

		_textFieldStyle = MQTextFieldStyleRoundedValidationWithoutStroke;

		_imageViewWidthAndHeight = 24.0f;
		_imageView = [[UIImageView alloc] init];
		_imageView.contentMode = UIViewContentModeScaleAspectFit;
		[self addSubview:_imageView];
	}

	return self;
}

- (id)initWithDelegate:(id<UITextFieldDelegate>)delegate
		textFieldStyle:(MQTextFieldStyle)textFieldStyle
autocapitalizationType:(UITextAutocapitalizationType)autocapitalizationType
	autocorrectionType:(UITextAutocorrectionType)autocorrectionType
	   clearButtonMode:(UITextFieldViewMode)clearButtonMode
		  keyboardType:(UIKeyboardType)keyboardType
		   placeholder:(NSString *)placeholder
		 returnKeyType:(UIReturnKeyType)returnKeyType
				   tag:(NSInteger)tag
{
	if (self = [super init]) {
		self.delegate = delegate;
		self.autocapitalizationType = autocapitalizationType;
		self.autocorrectionType = autocorrectionType;
		self.clearButtonMode = clearButtonMode;
		self.keyboardType = keyboardType;
		self.placeholder = placeholder;
		self.returnKeyType = returnKeyType;
		self.tag = tag;

		_padding = 5.0f;
		_shadowOpacity = 0.8f;
		_shadowRadius = 2.0f;

		switch (textFieldStyle) {
			case MQTextFieldStyleFlatNoValidation:
			{
				self.backgroundColor = [UIColor whiteColor];
				self.borderStyle = UITextBorderStyleNone;
				break;
			}
			case MQTextFieldStyleFlatValidationWithoutStroke:
			{
				self.backgroundColor = [UIColor whiteColor];
				self.borderStyle = UITextBorderStyleNone;

				_imageViewWidthAndHeight = 24.0f;
				_imageView = [[UIImageView alloc] init];
				_imageView.contentMode = UIViewContentModeScaleAspectFit;
				[self addSubview:_imageView];
				break;
			}
			case MQTextFieldStyleFlatValidationWithStroke:
			{
				self.backgroundColor = [UIColor whiteColor];
				self.borderStyle = UITextBorderStyleNone;

				_imageViewWidthAndHeight = 24.0f;
				_imageView = [[UIImageView alloc] init];
				_imageView.contentMode = UIViewContentModeScaleAspectFit;
				[self addSubview:_imageView];
				break;
			}
			case MQTextFieldStyleRoundedNoValidation:
			{
				self.borderStyle = UITextBorderStyleRoundedRect;
				break;
			}
			case MQTextFieldStyleRoundedValidationWithoutStroke:
			{
				self.borderStyle = UITextBorderStyleRoundedRect;

				_imageViewWidthAndHeight = 24.0f;
				_imageView = [[UIImageView alloc] init];
				_imageView.contentMode = UIViewContentModeScaleAspectFit;
				[self addSubview:_imageView];
				break;
			}
			case MQTextFieldStyleRoundedValidationWithStroke:
			{
				self.borderStyle = UITextBorderStyleRoundedRect;

				_imageViewWidthAndHeight = 24.0f;
				_imageView = [[UIImageView alloc] init];
				_imageView.contentMode = UIViewContentModeScaleAspectFit;
				[self addSubview:_imageView];
				break;
			}
		}

		_textFieldStyle = textFieldStyle;
	}

	return self;
}

#pragma mark - Lazy loading methods
- (UIColor *)activeShadowColor
{
	if (!_activeShadowColor) {
		_activeShadowColor = [UIColor colorWithRed:0.0f
											 green:0.616f
											  blue:0.859f
											 alpha:1.0f];
	}
	return _activeShadowColor;
}

- (UIColor *)invalidShadowColor
{
	if (!_invalidShadowColor) {
		_invalidShadowColor = [UIColor colorWithRed:0.749f
											  green:0.149f
											   blue:0.0f
											  alpha:1.0f];
	}
	return _invalidShadowColor;
}

- (UIColor *)validShadowColor
{
	if (!_validShadowColor) {
		_validShadowColor = [UIColor colorWithRed:0.149f
											green:0.749f
											 blue:0.0f
											alpha:1.0f];
	}
	return _validShadowColor;
}

- (void)setTextFieldState:(MQTextFieldState)textFieldState
{
	_textFieldState = textFieldState;

	if (_imageView) {
		switch (textFieldState) {
			case MQTextFieldStateInvalid:
			{
				_imageView.image = [UIImage imageNamed:@"MQTextField.bundle/textfield_invalid_state"];
				break;
			}
			case MQTextFieldStateValid:
			{
				_imageView.image = [UIImage imageNamed:@"MQTextField.bundle/textfield_valid_state"];
				break;
			}
			case MQTextFieldStateActive:
			case MQTextFieldStateInactive:
			case MQTextFieldStateUnknown:
			{
				_imageView.image = nil;
				break;
			}
		}
		return;
	}

	BOOL masksToBounds = NO;
	UIColor *shadowColor;
	CGSize shadowOffset = CGSizeZero;
	UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
	CGFloat shadowOpacity = _shadowOpacity;
	CGFloat shadowRadius = _shadowRadius;

	switch (textFieldState) {
		case MQTextFieldStateInvalid:
		{
			shadowColor = _invalidShadowColor;
			break;
		}
		case MQTextFieldStateValid:
		{
			shadowColor = _validShadowColor;
			break;
		}
		case MQTextFieldStateActive:
		{
			shadowColor = _activeShadowColor;
			break;
		}
		case MQTextFieldStateInactive:
		case MQTextFieldStateUnknown:
		{
			shadowColor = nil;
			shadowOpacity = 0.0f;
			shadowRadius = 0.0f;
			masksToBounds = YES;
			break;
		}
	}

	self.layer.backgroundColor = shadowColor ? shadowColor.CGColor : nil;
	self.layer.shadowColor = shadowColor ? shadowColor.CGColor : nil;
	self.layer.shadowOffset = shadowOffset;
	self.layer.shadowOpacity = shadowOpacity;
	self.layer.shadowPath = shadowPath ? shadowPath.CGPath : nil;
	self.layer.shadowRadius = shadowRadius;
	self.layer.masksToBounds = masksToBounds;
}

#pragma mark - Text field delegate
- (CGRect)textRectForBounds:(CGRect)bounds
{
	[super textRectForBounds:bounds];

	return bounds = CGRectInset(bounds, (_padding * 2.0f), (_padding * 2.0f));
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
	[super placeholderRectForBounds:bounds];

	return [self textRectForBounds:bounds];
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
	[super editingRectForBounds:bounds];

	return [self textRectForBounds:bounds];
}

- (void)layoutSubviews
{
	[super layoutSubviews];

	if (!_imageView) {
		return;
	}

	CGRect bounds = self.bounds;

	_imageView.frame = CGRectMake(bounds.size.width - _imageViewWidthAndHeight - _padding,
								  ((bounds.size.height - _imageViewWidthAndHeight) / 2.0f),
								  _imageViewWidthAndHeight,
								  _imageViewWidthAndHeight);
}

@end