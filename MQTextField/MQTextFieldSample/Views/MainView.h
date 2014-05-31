//  Copyright (c) 2014 Marqeta. All rights reserved.

#import <UIKit/UIKit.h>
#import "MQTextField.h"

typedef NS_ENUM(NSUInteger, MainViewTextFieldTags) {
	MainViewFirstNameTextFieldTag = 7000,
	MainViewLastNameTextFieldTag,
	MainViewEmailAddressTextFieldTag,
	MainViewPasswordTextFieldTag,
	MainViewPhoneNumberTextFieldTag
};

@interface MainView : UIView

@property (nonatomic, readwrite) CGFloat padding;
@property (nonatomic, readwrite) CGFloat descriptionViewHeight;
@property (nonatomic, readwrite) CGFloat textFieldHeight;

@property (nonatomic, readonly, strong) MQTextField *firstNameTextField;
@property (nonatomic, readonly, strong) MQTextField *lastNameTextField;
@property (nonatomic, readonly, strong) MQTextField *emailAddressTextField;
@property (nonatomic, readonly, strong) MQTextField *passwordTextField;
@property (nonatomic, readonly, strong) MQTextField *phoneNumberTextField;
@property (nonatomic, readonly, strong) UILabel *descriptionLabel;
@property (nonatomic, readonly, strong) UIView *descriptionView;
@property (nonatomic, readonly, strong) UIScrollView *scrollView;

- (instancetype)initWithDelegate:(id<UITextFieldDelegate>)delegate;

@end
