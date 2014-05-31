//  Copyright (c) 2014 Marqeta, Inc. All rights reserved.

#import <UIKit/UIKit.h>

//---------------------------------------------
/* The possible states of the textfield */
//---------------------------------------------
typedef NS_ENUM(NSUInteger, MQTextFieldState) {
	MQTextFieldStateUnknown = 0,
	MQTextFieldStateInvalid,
	MQTextFieldStateValid,
	MQTextFieldStateActive,
	MQTextFieldStateInactive,
};

//---------------------------------------------
/* The possible styles of the textfield */
//---------------------------------------------
typedef NS_ENUM(NSUInteger, MQTextFieldStyle) {
	MQTextFieldStyleFlatNoValidation,
	MQTextFieldStyleFlatValidationWithStroke,
	MQTextFieldStyleFlatValidationWithoutStroke,
	MQTextFieldStyleRoundedNoValidation,
	MQTextFieldStyleRoundedValidationWithStroke,
	MQTextFieldStyleRoundedValidationWithoutStroke // Default
};


@interface MQTextField : UITextField

@property (nonatomic, readwrite) CGFloat padding;
@property (nonatomic, readwrite) CGFloat imageViewWidthAndHeight;
@property (nonatomic, readonly, strong) UIImageView *imageView;
@property (nonatomic, readwrite, strong) UIColor *activeShadowColor;
@property (nonatomic, readwrite, strong) UIColor *invalidShadowColor;
@property (nonatomic, readwrite, strong) UIColor *validShadowColor;
@property (nonatomic, readwrite) CGFloat shadowOpacity;
@property (nonatomic, readwrite) CGFloat shadowRadius;
@property (nonatomic) MQTextFieldState textFieldState;
@property (nonatomic) MQTextFieldStyle textFieldStyle;

- (id)initWithDelegate:(id<UITextFieldDelegate>)delegate
autocapitalizationType:(UITextAutocapitalizationType)autocapitalizationType
	autocorrectionType:(UITextAutocorrectionType)autocorrectionType
		  keyboardType:(UIKeyboardType)keyboardType
		   placeholder:(NSString *)placeholder
		 returnKeyType:(UIReturnKeyType)returnKeyType
				   tag:(NSInteger)tag;

- (id)initWithDelegate:(id<UITextFieldDelegate>)delegate
		textFieldStyle:(MQTextFieldStyle)textFieldStyle
autocapitalizationType:(UITextAutocapitalizationType)autocapitalizationType
	autocorrectionType:(UITextAutocorrectionType)autocorrectionType
	   clearButtonMode:(UITextFieldViewMode)clearButtonMode
		  keyboardType:(UIKeyboardType)keyboardType
		   placeholder:(NSString *)placeholder
		 returnKeyType:(UIReturnKeyType)returnKeyType
				   tag:(NSInteger)tag;

@end