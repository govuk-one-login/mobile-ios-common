#import "Availability.h"

#if defined(__IPHONE_17_0)
#warning "UIViewController+UpcomingLifecycleMethods.h is redundant when compiling with the iOS 17 SDK"
#else

@import UIKit;

@interface UIViewController (UpcomingLifecycleMethods)

/// Called when the view is becoming visible at the beginning of the appearance transition,
/// after it has been added to the hierarchy and been laid out by its superview. This method
/// is very similar to -viewWillAppear: and is always called shortly afterwards (so changes
/// made in either callback will be visible to the user at the same time), but unlike
/// -viewWillAppear:, at the time when -viewIsAppearing: is called all of the following are
/// valid for the view controller and its own view:
///    - View controller and view's trait collection
///    - View's superview chain and window
///    - View's geometry (e.g. frame/bounds, safe area insets, layout margins)
/// Choose this method instead of -viewWillAppear: by default, as it is a direct replacement
/// that provides equivalent or superior behavior in nearly all cases.
///
/// - SeeAlso: https://developer.apple.com/documentation/uikit/uiviewcontroller/4195485-viewisappearing
- (void)viewIsAppearing:(BOOL)animated API_AVAILABLE(ios(13.0), tvos(13.0)) API_UNAVAILABLE(watchos);

@end

#endif
