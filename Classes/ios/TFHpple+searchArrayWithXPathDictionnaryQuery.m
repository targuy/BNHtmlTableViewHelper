    //
    //  TFHpple+searchArrayWithXPathDictionnaryQuery.m
    //  Benz
    //
    //  Created by benoit on 01/12/2013.
    //  Copyright (c) 2013 benoit. All rights reserved.
    //

#import "TFHpple+searchArrayWithXPathDictionnaryQuery.h"


@implementation TFHpple (searchArrayWithXPathDictionnaryQuery)

-(NSMutableDictionary *) searchArrayWithXPathDictionaryQuery:(NSArray *)tableDictionary {
    NSMutableDictionary *newTable=nil;
    if(tableDictionary && [tableDictionary count]>0) {
        id xpathRequest;
        NSMutableDictionary *tempDictionary=nil;
        for(xpathRequest in tableDictionary) {
            if([xpathRequest objectForKey:@"Xpath"]&&[xpathRequest objectForKey:@"Key"]) {
                NSMutableArray *keyArray=[[self searchWithXPathQuery:[xpathRequest objectForKey:@"Xpath"]] mutableCopy];
                id pointToRegister=nil;
                if(keyArray) { // XPath request can return nil
                    if ([xpathRequest objectForKey:@"Block"]) { // Check that Block exists, if not it let the Array untouched
                        if([keyArray count]>1) //Management of single return to avoid to have an array for nothing
                        {
                            [keyArray bk_performMap:[xpathRequest objectForKey:@"Block"]];
                            pointToRegister=keyArray; // Will insert a NSMutableArray
                        }
                        else {
                            id (^bl)(TFHppleElement *)=[xpathRequest objectForKey:@"Block"];
                            pointToRegister=bl(keyArray[0]); // Will insert a single Object
                        }
                    }
                    if(!tempDictionary) // Check if the NSMutableDictionnary exists and alloc init if it doesn't
                    {
                        tempDictionary=[[NSMutableDictionary alloc]init];
                    }
                    [tempDictionary setObject:pointToRegister forKey:[xpathRequest objectForKey:@"Key"]]; // Record result(s) (transformed) in the specified key
                }
            }
        }
        newTable=tempDictionary; // Set the return value to the working dict outside the loop
    }
    return newTable; // The result or nil if something was wrong.
}
@end

