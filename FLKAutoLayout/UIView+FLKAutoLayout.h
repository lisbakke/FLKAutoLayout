//
// Created by florian on 25.03.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <UIKit/UIKit.h>


FOUNDATION_EXTERN NSString * const FLKNoConstraint;

@interface UIView (FLKAutoLayout)

- (NSArray*)flk_alignAttribute:(NSLayoutAttribute)attribute toView:(UIView*)view predicate:(NSString*)predicate;
- (NSArray*)flk_alignAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)toAttribute ofView:(UIView *)view predicate:(NSString*)predicate;


- (NSArray*)flk_alignToView:(UIView*)view;
- (NSArray*)flk_alignTop:(NSString *)top leading:(NSString *)leading bottom:(NSString *)bottom trailing:(NSString *)trailing toView:(UIView*)view;
- (NSArray*)flk_alignTop:(NSString *)top leading:(NSString *)leading toView:(UIView*)view;
- (NSArray*)flk_alignBottom:(NSString *)bottom trailing:(NSString *)trailing toView:(UIView*)view;
- (NSArray*)flk_alignTop:(NSString *)top bottom:(NSString *)bottom toView:(UIView*)view;
- (NSArray*)flk_alignLeading:(NSString *)leading trailing:(NSString *)trailing toView:(UIView*)view;


- (NSArray*)flk_alignLeadingEdgeWithView:(UIView *)view predicate:(NSString*)predicate;
- (NSArray*)flk_alignTrailingEdgeWithView:(UIView *)view predicate:(NSString*)predicate;
- (NSArray*)flk_alignTopEdgeWithView:(UIView *)view predicate:(NSString*)predicate;
- (NSArray*)flk_alignBottomEdgeWithView:(UIView *)view predicate:(NSString*)predicate;

- (NSArray*)flk_alignBaselineWithView:(UIView *)view predicate:(NSString*)predicate;
- (NSArray*)flk_alignCenterXWithView:(UIView *)view predicate:(NSString*)predicate;
- (NSArray*)flk_alignCenterYWithView:(UIView *)view predicate:(NSString*)predicate;
- (NSArray*)flk_alignCenterWithView:(UIView*)view;


- (NSArray*)flk_constrainWidth:(NSString *)widthPredicate height:(NSString*)heightPredicate;
- (NSArray*)flk_constrainWidth:(NSString*)widthPredicate;
- (NSArray*)flk_constrainHeight:(NSString*)heightPredicate;

- (NSArray*)flk_constrainWidthToView:(UIView *)view predicate:(NSString*)predicate;
- (NSArray*)flk_constrainHeightToView:(UIView *)view predicate:(NSString*)predicate;

- (NSArray*)flk_constrainAspectRatio:(NSString*)predicate;

- (NSArray*)flk_constrainLeadingSpaceToView:(UIView *)view predicate:(NSString*)predicate;
- (NSArray *)flk_constrainTrailingSpaceToView:(UIView *)view predicate:(NSString *)predicate;
- (NSArray*)flk_constrainTopSpaceToView:(UIView *)view predicate:(NSString*)predicate;
- (NSArray*)flk_constrainBottomSpaceToView:(UIView *)view predicate:(NSString*)predicate;


+ (NSArray*)flk_alignAttribute:(NSLayoutAttribute)attribute ofViews:(NSArray *)ofViews toViews:(NSArray *)toViews predicate:(NSString*)predicate;
+ (NSArray*)flk_alignAttribute:(NSLayoutAttribute)attribute ofViews:(NSArray *)views toAttribute:(NSLayoutAttribute)toAttribute ofViews:(NSArray *)toViews predicate:(NSString*)predicate;


+ (NSArray*)flk_equalWidthForViews:(NSArray*)views;
+ (NSArray*)flk_equalHeightForViews:(NSArray*)views;


+ (NSArray*)flk_alignLeadingEdgesOfViews:(NSArray*)views;
+ (NSArray*)flk_alignTrailingEdgesOfViews:(NSArray*)views;
+ (NSArray*)flk_alignTopEdgesOfViews:(NSArray*)views;
+ (NSArray*)flk_alignBottomEdgesOfViews:(NSArray*)views;
+ (NSArray*)flk_alignLeadingAndTrailingEdgesOfViews:(NSArray*)views;
+ (NSArray*)flk_alignTopAndBottomEdgesOfViews:(NSArray*)views;


+ (NSArray*)flk_spaceOutViewsHorizontally:(NSArray *)views predicate:(NSString*)predicate;
+ (NSArray*)flk_spaceOutViewsVertically:(NSArray *)views predicate:(NSString*)predicate;

+ (NSArray*)flk_distributeCenterXOfViews:(NSArray *)views inView:(UIView*)view;
+ (NSArray*)flk_distributeCenterYOfViews:(NSArray *)views inView:(UIView*)inView;

+ (void)flk_spaceOutViewsHorizontally:(NSMutableArray *)array inView:(UIView *)view;
@end
