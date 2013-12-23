//
//  BNHtmlTable.h
//  Benz
//
//  Created by benoit on 23/12/2013.
//  Copyright (c) 2013 benoit. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNHtmlTable;
/**
 Class that handle a dihanahanahanaaaR
 @param <#parameter#>
 @returns <#retval#>
 @exception <#throws#>
 */
@interface BNHtmlTable : NSObject

-(NSInteger) numberOfSections;
-(NSInteger) numberOfRowsInSection:(NSInteger) section;
-(NSDictionary *) rowAtIndexPath:(NSIndexPath *) indexPAth;
-(NSString *) titleHeaderInSection:(NSInteger) section;
+(BNHtmlTable *) createWithDictionary:(NSMutableDictionary *) dicOfTable;
-(id)initWithDictionary:(NSMutableDictionary *)dicOfTable;

@end