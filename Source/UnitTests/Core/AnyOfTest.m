//
//  OCHamcrest - AnyOfTest.m
//  Copyright 2011 hamcrest.org. See LICENSE.txt
//
//  Created by: Jon Reid
//

    // Inherited
#import "AbstractMatcherTest.h"

    // OCHamcrest
#define HC_SHORTHAND
#import <OCHamcrest/HCAnyOf.h>
#import <OCHamcrest/HCAssertThat.h>
#import <OCHamcrest/HCIsEqual.h>
#import <OCHamcrest/HCIsNot.h>


@interface AnyOfTest : AbstractMatcherTest
@end

@implementation AnyOfTest

- (id<HCMatcher>) createMatcher
{
    return anyOf(equalTo(@"irrelevant"), nil);
}


- (void) testEvaluatesToTheTheLogicalDisjunctionOfTwoOtherMatchers
{
    assertThat(@"good", anyOf(equalTo(@"good"), equalTo(@"good"), nil));
    assertThat(@"good", anyOf(equalTo(@"bad"), equalTo(@"good"), nil));
    assertThat(@"good", anyOf(equalTo(@"good"), equalTo(@"bad"), nil));
    
    assertThat(@"good", isNot(anyOf(equalTo(@"bad"), equalTo(@"bad"), nil)));
}


- (void) testEvaluatesToTheTheLogicalDisjunctionOfManyOtherMatchers
{
    assertThat(@"good", anyOf(equalTo(@"bad"),
                              equalTo(@"good"),
                              equalTo(@"bad"),
                              equalTo(@"bad"),
                              equalTo(@"bad"),
                              nil));
    assertThat(@"good", isNot(anyOf(equalTo(@"bad"),
                                    equalTo(@"bad"),
                                    equalTo(@"bad"),
                                    equalTo(@"bad"),
                                    equalTo(@"bad"),
                                    nil)));
}


- (void) testHasAReadableDescription
{
    assertDescription(@"(\"good\" or \"bad\" or \"ugly\")",
                      anyOf(equalTo(@"good"), equalTo(@"bad"), equalTo(@"ugly"), nil));
}


- (void) testSuccessfulMatchDoesNotGenerateMismatchDescription
{
    assertNoMismatchDescription(anyOf(equalTo(@"good"), equalTo(@"good"), nil),
                                @"good");
}


- (void) testMismatchDescriptionDescribesFirstFailingMatch
{
    assertMismatchDescription(@"was \"ugly\"",
                              anyOf(equalTo(@"bad"), equalTo(@"good"), nil),
                              @"ugly");
}


- (void) testDescribeMismatch
{
    assertDescribeMismatch(@"was \"ugly\"",
                           anyOf(equalTo(@"bad"), equalTo(@"good"), nil),
                           @"ugly");
}


- (void) testMatcherCreationRequiresNonNilArgument
{    
    STAssertThrows(anyOf(nil), @"Should require non-nil list");
}

@end