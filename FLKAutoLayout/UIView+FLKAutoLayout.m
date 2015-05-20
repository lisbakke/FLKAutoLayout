//
// Created by florian on 25.03.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "UIView+FLKAutoLayout.h"
#import "FLKAutoLayoutPredicateList.h"

NSString * const FLKNoConstraint = @"0@1001"; // maximum valid priority is 1000, constraints with a priority > 1000 will be ignored by FLKAutoLayout

typedef NSArray* (^viewChainingBlock)(UIView* view1, UIView* view2);


@implementation UIView (FLKAutoLayout)


#pragma mark Generic constraint methods for two views

- (NSArray*)flk_alignAttribute:(NSLayoutAttribute)attribute toView:(UIView*)view predicate:(NSString*)predicate {
    NSArray* views = view ? @[view] : nil;
    return [UIView flk_alignAttribute:attribute ofViews:@[self] toViews:views predicate:predicate];
}

- (NSArray*)flk_alignAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)toAttribute ofView:(UIView *)view predicate:(NSString*)predicate {
    NSArray* views = view ? @[view] : nil;
    return [UIView flk_alignAttribute:attribute ofViews:@[self] toAttribute:toAttribute ofViews:views predicate:predicate];
}


#pragma mark Constrain multiple edges of two views

- (NSArray*)flk_alignToView:(UIView*)view {
    return [self flk_alignTop:@"0" leading:@"0" bottom:@"0" trailing:@"0" toView:view];
}

- (NSArray*)flk_alignTop:(NSString *)top bottom:(NSString *)bottom toView:(UIView*)view {
	NSArray* topConstraints = [self flk_alignTopEdgeWithView:view predicate:top];
    NSArray* bottomConstraints = [self flk_alignBottomEdgeWithView:view predicate:bottom];
    return [topConstraints arrayByAddingObjectsFromArray:bottomConstraints];
}
- (NSArray*)flk_alignLeading:(NSString *)leading trailing:(NSString *)trailing toView:(UIView*)view {
	NSArray* leadingConstraints = [self flk_alignLeadingEdgeWithView:view predicate:leading];
    NSArray* trailingConstraints = [self flk_alignTrailingEdgeWithView:view predicate:trailing];
    return [leadingConstraints arrayByAddingObjectsFromArray:trailingConstraints];
}

- (NSArray*)flk_alignTop:(NSString *)top leading:(NSString *)leading bottom:(NSString *)bottom trailing:(NSString *)trailing toView:(UIView*)view {
    NSArray* topLeadingConstraints = [self flk_alignTop:top leading:leading toView:view];
    NSArray* bottomTrailingConstraints = [self flk_alignBottom:bottom trailing:trailing toView:view];
    return [topLeadingConstraints arrayByAddingObjectsFromArray:bottomTrailingConstraints];
}

- (NSArray*)flk_alignTop:(NSString *)top leading:(NSString *)leading toView:(UIView*)view {
    NSArray* topConstraints = [self flk_alignTopEdgeWithView:view predicate:top];
    NSArray* leadingConstraints = [self flk_alignLeadingEdgeWithView:view predicate:leading];
    return [topConstraints arrayByAddingObjectsFromArray:leadingConstraints];
}

- (NSArray*)flk_alignBottom:(NSString *)bottom trailing:(NSString *)trailing toView:(UIView*)view {
    NSArray* bottomConstraints = [self flk_alignBottomEdgeWithView:view predicate:bottom];
    NSArray* trailingConstraints = [self flk_alignTrailingEdgeWithView:view predicate:trailing];
    return [bottomConstraints arrayByAddingObjectsFromArray:trailingConstraints];
}


#pragma mark Constraining one edge of two views

- (NSArray*)flk_alignLeadingEdgeWithView:(UIView *)view predicate:(NSString*)predicate {
    return [self alignAttribute:NSLayoutAttributeLeading toView:view predicate:predicate];
}

- (NSArray*)flk_alignTrailingEdgeWithView:(UIView *)view predicate:(NSString*)predicate {
    return [self alignAttribute:NSLayoutAttributeTrailing toView:view predicate:predicate];
}

- (NSArray*)flk_alignTopEdgeWithView:(UIView *)view predicate:(NSString*)predicate {
    return [self alignAttribute:NSLayoutAttributeTop toView:view predicate:predicate];
}

- (NSArray*)flk_alignBottomEdgeWithView:(UIView *)view predicate:(NSString*)predicate {
    return [self alignAttribute:NSLayoutAttributeBottom toView:view predicate:predicate];
}

- (NSArray*)flk_alignBaselineWithView:(UIView *)view predicate:(NSString*)predicate {
    return [self alignAttribute:NSLayoutAttributeBaseline toView:view predicate:predicate];
}

- (NSArray*)flk_alignCenterXWithView:(UIView *)view predicate:(NSString*)predicate {
    return [self alignAttribute:NSLayoutAttributeCenterX toView:view predicate:predicate];
}

- (NSArray*)flk_alignCenterYWithView:(UIView *)view predicate:(NSString*)predicate {
    return [self alignAttribute:NSLayoutAttributeCenterY toView:view predicate:predicate];
}

- (NSArray*)flk_alignCenterWithView:(UIView*)view {
    NSArray* centerXConstraints = [self flk_alignCenterXWithView:view predicate:nil];
    NSArray* centerYConstraints = [self flk_alignCenterYWithView:view predicate:nil];
    return [centerXConstraints arrayByAddingObjectsFromArray:centerYConstraints];
}


#pragma mark Constrain width & height of a view

- (NSArray*)flk_constrainWidth:(NSString *)widthPredicate height:(NSString*)heightPredicate {
    NSArray* widthConstraints = [self flk_constrainWidth:widthPredicate];
    NSArray* heightConstraints = [self flk_constrainHeight:heightPredicate];
    return [widthConstraints arrayByAddingObjectsFromArray:heightConstraints];
}

- (NSArray*)flk_constrainWidth:(NSString*)widthPredicate {
    return [self alignAttribute:NSLayoutAttributeWidth toView:nil predicate:widthPredicate];
}

- (NSArray*)flk_constrainHeight:(NSString*)heightPredicate {
    return [self alignAttribute:NSLayoutAttributeHeight toView:nil predicate:heightPredicate];
}

- (NSArray*)flk_constrainWidthToView:(UIView *)view predicate:(NSString*)predicate {
    return [self alignAttribute:NSLayoutAttributeWidth toView:view predicate:predicate];
}

- (NSArray*)flk_constrainHeightToView:(UIView *)view predicate:(NSString*)predicate {
    return [self alignAttribute:NSLayoutAttributeHeight toView:view predicate:predicate];
}

- (NSArray*)flk_constrainAspectRatio:(NSString*)predicate {
    return [self flk_alignAttribute:NSLayoutAttributeWidth toAttribute:NSLayoutAttributeHeight ofView:self predicate:predicate];
}


#pragma mark Spacing out two views

- (NSArray*)flk_constrainLeadingSpaceToView:(UIView *)view predicate:(NSString*)predicate {
    return [self flk_alignAttribute:NSLayoutAttributeLeading toAttribute:NSLayoutAttributeTrailing ofView:view predicate:predicate];
}

-(NSArray *)flk_constrainTrailingSpaceToView:(UIView *)view predicate:(NSString *)predicate {
    return [self flk_alignAttribute:NSLayoutAttributeTrailing toAttribute:NSLayoutAttributeLeading ofView:view predicate:predicate];
}

- (NSArray*)flk_constrainTopSpaceToView:(UIView *)view predicate:(NSString*)predicate {
    return [self flk_alignAttribute:NSLayoutAttributeTop toAttribute:NSLayoutAttributeBottom ofView:view predicate:predicate];
}

- (NSArray*)flk_constrainBottomSpaceToView:(UIView *)view predicate:(NSString*)predicate {
    return [self flk_alignAttribute:NSLayoutAttributeBottom toAttribute:NSLayoutAttributeTop ofView:view predicate:predicate];
}





#pragma mark Generic constraint methods for multiple views

+ (NSArray*)flk_alignAttribute:(NSLayoutAttribute)attribute ofViews:(NSArray *)ofViews toViews:(NSArray *)toViews predicate:(NSString*)predicate {
    return [self flk_alignAttribute:attribute ofViews:ofViews toAttribute:attribute ofViews:toViews predicate:predicate];
}

+ (NSArray*)flk_alignAttribute:(NSLayoutAttribute)attribute ofViews:(NSArray *)views toAttribute:(NSLayoutAttribute)toAttribute ofViews:(NSArray *)toViews predicate:(NSString*)predicate {
    NSAssert(views.count == toViews.count || !toViews, @"Aligning attributes of multiple views to multiple views requires both view arrays to be the same length");
    FLKAutoLayoutPredicateList* predicateList = [FLKAutoLayoutPredicateList flk_predicateListFromString:predicate];
    NSMutableArray* constraints = [NSMutableArray array];
    for (NSUInteger i = 0; i < views.count; i++) {
        NSArray* pairConstraints = [predicateList flk_iteratePredicatesUsingBlock:^NSLayoutConstraint *(FLKAutoLayoutPredicate predicateElement) {
          return [views[i] flk_applyPredicate:predicateElement toView:toViews[i] fromAttribute:attribute toAttribute:toAttribute];
        }];
        [constraints addObjectsFromArray:pairConstraints];
    }
    return constraints;
}


#pragma mark Aligning one edge of multiple views

+ (NSArray*)flk_alignLeadingEdgesOfViews:(NSArray*)views {
    return [self chainViews:views usingBlock:^NSArray*(UIView* view1, UIView* view2) {
        return [view2 flk_alignLeadingEdgeWithView:view1 predicate:nil];
    }];
}

+ (NSArray*)flk_alignTrailingEdgesOfViews:(NSArray*)views {
    return [self chainViews:views usingBlock:^NSArray*(UIView* view1, UIView* view2) {
        return [view2 flk_alignTrailingEdgeWithView:view1 predicate:nil];
    }];
}

+ (NSArray*)flk_alignTopEdgesOfViews:(NSArray*)views {
    return [self chainViews:views usingBlock:^NSArray*(UIView* view1, UIView* view2) {
        return [view2 flk_alignTopEdgeWithView:view1 predicate:nil];
    }];
}

+ (NSArray*)flk_alignBottomEdgesOfViews:(NSArray*)views {
    return [self chainViews:views usingBlock:^NSArray*(UIView* view1, UIView* view2) {
        return [view2 flk_alignBottomEdgeWithView:view1 predicate:nil];
    }];
}

+ (NSArray*)flk_alignLeadingAndTrailingEdgesOfViews:(NSArray*)views {
    NSArray* leadingConstraints = [self flk_alignLeadingEdgesOfViews:views];
    NSArray* trailingConstraints = [self flk_alignTrailingEdgesOfViews:views];
    return [leadingConstraints arrayByAddingObjectsFromArray:trailingConstraints];
}

+ (NSArray*)flk_alignTopAndBottomEdgesOfViews:(NSArray*)views {
    NSArray* topConstraints = [self flk_alignTopEdgesOfViews:views];
    NSArray* bottomConstraints = [self flk_alignBottomEdgesOfViews:views];
    return [topConstraints arrayByAddingObjectsFromArray:bottomConstraints];
}


#pragma mark Constraining widths & heights of multiple views

+ (NSArray*)flk_equalWidthForViews:(NSArray*)views {
    return [self chainViews:views usingBlock:^NSArray*(UIView* view1, UIView* view2) {
        return [view2 flk_constrainWidthToView:view1 predicate:nil];
    }];
}

+ (NSArray*)flk_equalHeightForViews:(NSArray*)views {
    return [self chainViews:views usingBlock:^NSArray*(UIView* view1, UIView* view2) {
        return [view2 flk_constrainHeightToView:view1 predicate:nil];
    }];
}


#pragma mark Space out multiple views

+ (NSArray*)flk_spaceOutViewsHorizontally:(NSArray *)views predicate:(NSString*)predicate{
    return [self chainViews:views usingBlock:^NSArray*(UIView* view1, UIView* view2) {
        return [view2 flk_constrainLeadingSpaceToView:view1 predicate:predicate];
    }];
}

+ (NSArray*)flk_spaceOutViewsVertically:(NSArray *)views predicate:(NSString*)predicate {
    return [self chainViews:views usingBlock:^NSArray*(UIView* view1, UIView* view2) {
        return [view2 flk_constrainTopSpaceToView:view1 predicate:predicate];
    }];
}

+ (NSArray*)flk_distributeCenterXOfViews:(NSArray *)views inView:(UIView*)inView {
    return [self distributeAttribute:NSLayoutAttributeCenterX OfViews:views inView:inView];
}

+ (NSArray*)flk_distributeCenterYOfViews:(NSArray *)views inView:(UIView*)inView {
    return [self distributeAttribute:NSLayoutAttributeCenterY OfViews:views inView:inView];
}

+ (NSArray*)distributeAttribute:(NSLayoutAttribute)attribute OfViews:(NSArray*)views inView:(UIView*)inView {
    NSAssert(views.count > 1, @"Distribute views requires at least two views");
    CGFloat interval = 2.0f / (views.count - 1);
    CGFloat multiplier = 0;
    NSMutableArray* constraints = [NSMutableArray array];
    for (UIView* view in views) {
        FLKAutoLayoutPredicate predicate = FLKAutoLayoutPredicateMake(NSLayoutRelationEqual, multiplier, 0, 0);
        NSLayoutConstraint* constraint = [view flk_applyPredicate:predicate toView:inView attribute:attribute];
        if (constraint) {
            [constraints addObject:constraint];
        }
        multiplier += interval;
    }
    return constraints;
}



#pragma mark Internal helpers

+ (NSArray*)chainViews:(NSArray*)views usingBlock:(viewChainingBlock)block {
    NSAssert(views.count > 1, @"Operations on multiple views require at least 2 views");
    NSMutableArray* constraints = [NSMutableArray array];
    for (NSUInteger i = 1; i < views.count; i++) {
        [constraints addObjectsFromArray:block(views[i-1], views[i])];
    }
    return constraints;
}

@end
