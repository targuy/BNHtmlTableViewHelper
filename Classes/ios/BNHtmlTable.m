//
//  BNHtmlTable.m
//  Benz
//
//  Created by benoit on 23/12/2013.
//  Copyright (c) 2013 benoit. All rights reserved.
//

#import "BNHtmlTable.h"

@interface BNHtmlTable()
@property (strong,nonatomic) NSMutableDictionary *table;
@end

@implementation BNHtmlTable

-(id) initWithDictionary:(NSMutableDictionary *) dicOftables {
    self=[super init];
    if(self)
    {
        _table=dicOftables;
    }
    return (self);
}

+(BNHtmlTable *) createWithDictionary:(NSMutableDictionary *) dicOftables {
    if(dicOftables) {
        BNHtmlTable *moi=[[BNHtmlTable alloc] initWithDictionary:dicOftables];
        return moi;
    }
    else return nil;
}

-(NSInteger) numberOfSections {
    int nbSection=0;
    NSMutableArray *section=[_table objectForKey:@"Sections"];
    if(section)
        nbSection=section.count;
    return nbSection;
}

-(NSInteger) numberOfRowsInSection:(NSInteger) section {
    return [[[[_table objectForKey:@"Sections"] objectAtIndex:section] objectForKey:@"Rows" ] integerValue];
}
    // Private Method to convert section/row in absolute row
-(NSInteger) tableIndexForIndexPath:(NSIndexPath *) indexPath {
    int index=indexPath.row;
    for (int sectionCount=0;sectionCount!=(indexPath.section); sectionCount++) {
        index= index + [_table[@"Sections"][sectionCount][@"Rows"]intValue];
    }
    return index;
}

-(NSDictionary *) rowAtIndexPath:(NSIndexPath *) indexPath {
    NSMutableDictionary *temp=[[NSMutableDictionary alloc]init];
    
    int row=[self tableIndexForIndexPath:indexPath];
    id i;
    for ( i in [_table allKeys]) {
        NSArray *arrayForCurrentKey=[_table objectForKey:i];
        if(arrayForCurrentKey && ![arrayForCurrentKey isEqual:[_table objectForKey:@"Sections"]]) {
            [temp setObject:[arrayForCurrentKey objectAtIndex:row] forKey:i];
        }
    }
    return temp;
}

-(NSString *) titleHeaderInSection:(NSInteger) section {
    return [[[_table objectForKey:@"Sections"] objectAtIndex:section ] objectForKey:@"Title"];
}
@end
