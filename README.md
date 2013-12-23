BNHtmlTableViewHelper
=====================
##Objectives
- To have a simple and concise way to extract a lot of data from html pages especially inside tables
- Help a UITableViewController to present them in a UITableView.

## This library contains :
- A category to TFHpple adding method *searchArrayWithXPathDictionaryQuery:* to read in one shot several datas (for example columns in a table) from a template (that could be selected in your code to support multiple templates in a site) and return it in NSMutableDictionnary.
- A Class *BNHtmlTable* that use that NSMutableDictionnary in his initializer to help a UITableViewController to manage an HTML Table from a website as a datasource 


##Example of searchArrayWithXPathDictionaryQuery: usage 

###1) Define a template to analyze, process and store your table in 1 line of this litteral syntax.

`@[     @{ @"Key": @"myVariable",@"Xpath": @"//tbody/tr/td/text()",@"Block":[myBlock copy] }      
];`

Particulary efficient with multiple variables, (see complete example below).

- The template is an NSArray of NSDictionnary.
- Each NSArray item is a data list for example a column you want to read, 
- Each NSDictionnary contains the column name with key @"Key", 
- the XPath with key @"Xpath" and 
- a Block to perform on the return of XPath request with the key @"Block".

#####a) Choose every key name for column or list you want to extract.
#####b) With an html inspector, extract the XPath element you need from the webpage.
#####c) Write or reuse the appropriate Block for what you want to do.
```
NSArray *template=@[
   @{@"Key":@"fileName",@"Xpath":@"//tbody/tr/td[8]/text()",@"Block":[elementTexte copy]},
   @{@"Key":@"fileSize",@"Xpath":@"//tbody/tr/td[9]/text()",@"Block":[elementTexte copy]},                                               
   @{@"Key":@"titre",   @"Xpath":@"//tbody/tr/td[5]",       @"Block":[elementAorText copy]},                                               
   @{@"Key":@"titreURL",@"Xpath":@"//tbody/tr/td[5]",       @"Block":[elementAorTextURL copy]},                                               
   @{@"Key":@"lang",    @"Xpath":@"//tbody/tr/td[6]/img",   @"Block":[elementAlt copy]},
   @{@"Key":@"par2",    @"Xpath":@"//tbody/tr/td[10]",      @"Block":[elementImageAlt copy]},
   @{@"Key":@"nfo",     @"Xpath":@"//tbody/tr/td[10]",      @"Block":[elementAHref copy]},
   @{@"Key":@"Sections",@"Xpath":@"//tbody",                @"Block":[headerWithDate copy]} 
                  ];
```
**The @"Sections" key is special, it must have been construct in the format described below by your block.**

###2) Get the data

#####a) Get the page
```
NSString *url=@"http://www.example.com/api/?request=test";
NSURL *searchUrl=[NSURL URLWithString:url];
NSData *htmlData=[NSData dataWithContentsOfURL:searchUrl];
```
#####b) Parse it with hpple library
```
TFHpple *parser=[TFHpple hppleWithHTMLData:htmlData];
```
#####c) Call the new hpple method included to return a NSMutable Dictionnay that contains a NSArray (if several lines) for each key.
```
NSMutableDictionary *currentCatDict=[parser searchArrayWithXPathDictionaryQuery:template];
```
##Example of Blocks :
```
typedef NSString *(^element)(TFHppleElement *);

element elementAHref = ^(TFHppleElement *el) {
        NSString *aString=[[el firstChildWithTagName:@"a"] objectForKey:@"href"];
        if (!aString) {
            aString=@"empty";
        }
        return aString;
    };
element elementTexte = ^(TFHppleElement *el) {
     	NSString *aString=[el content];
        if (!aString) {
            aString=@"empty";
        }
        return aString;
    };


```

##Example of BNHtmlTable usage :

####1) After the call to TFHpple category above, Create a BHtmlTable with the dictionnary :
```
BNHtmlTable *htmltable=[[BNHtmlTable alloc ]initWithDictionary:currentCatDict];
```
####2) Use the BNHtmlTable in your delegate :
##### a) Section management

The Object with @"Section" key must be a NSMutableArray containing a NSDictionnary per section with the following keys @"Title" that is a NSString and @"Rows" that is an int.

```
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
        // Return the number of sections.
    return [htmltable numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        // Return the number of rows in the section.
    return [htmltable numberOfRowsInSection:section];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
        // return section title
    return [htmltable titleHeaderInSection:section];
}
```
##### b) Cell setup with the NSDictionnary using litterals
```
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myidentifier"];
NSDictionary *hcell=[htmltable rowAtIndexPath:indexPath];
// Set the controls for example using outlet from IB
self.keynameOutlet.text=hcell[@"keyname"];
```


