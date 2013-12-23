BNHtmlTableViewHelper
=====================

This library contains :
- a category to TFHpple to read in one shot a lot of data from a template and return it in NSMutableDictionnary.
- a Class that use that NSMutableDictionnary as initializer to help a UITableViewController to manage an HTML Table from a website as a datasource 


<b>Example of category usage :</b>

1) Define a template for your table simply with this litteral syntax.

- The template is an NSArray of NSDictionnaries.
- Each NSArray item is a column you want to read, 
- each dictionnary contains the column name, 
- the XPath and 
- a Block to perform on the return of XPath request.

a) Choose every key name for column name you want to extract.
b) With an html inspector, extract the XPath element you need from the webpage.
c) Write or reuse the appropriate Block for what you want to do.

NSArray *template1=@[@{@"Key":@"fileName",   @"Xpath":@"//tbody/tr/td[8]/text()",    @"Block":[elementTexte copy]},
                         @{@"Key":@"fileSize",   @"Xpath":@"//tbody/tr/td[9]/text()",    @"Block":[elementTexte copy]},
                         @{@"Key":@"titre",      @"Xpath":@"//tbody/tr/td[5]",           @"Block":[elementAorText copy]},
                         @{@"Key":@"titreURL",   @"Xpath":@"//tbody/tr/td[5]",           @"Block":[elementAorTextURL copy]},
                         @{@"Key":@"lang",       @"Xpath":@"//tbody/tr/td[6]/img",       @"Block":[elementAlt copy]},
                         @{@"Key":@"par2",       @"Xpath":@"//tbody/tr/td[10]",          @"Block":[elementImageAlt copy]},
                         @{@"Key":@"nfo",        @"Xpath":@"//tbody/tr/td[10]",          @"Block":[elementAHref copy]},
                         @{@"Key":@"Sections",   @"Xpath":@"//tbody",                    @"Block":[headerWithDate copy]}
                         ];

2) Get the data

a) Get the page
NSString *url=@"http://www.example.com/api/?request=test";
NSURL *searchUrl=[NSURL URLWithString:url];
NSData *htmlData=[NSData dataWithContentsOfURL:searchUrl];

b) Parse it with hpple library
TFHpple *parser=[TFHpple hppleWithHTMLData:htmlData];

c) Call the new hpple method included to return a NSMutable Dictionnay that contains a NSArray (if several lines) for each key.
NSMutableDictionary *currentCatDict=[parser searchArrayWithXPathDictionaryQuery:activeTemplate];

<b>Example of BNHtmlTable usage :</b>

1) After the call to TFHpple category above, Create a BHtmlTable with the dictionnary :
BNHtmlTable *htmltable=[[BNHtmlTable alloc ]initWithDictionary:currentCatDict];

2) Use the BNHtmlTable in your delegate :

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
        // Return the number of sections.
    return [htmltable numberOfSections];
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        // Return the number of rows in the section.
    return [htmltable numberOfRowsInSection:section];
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
        // return section title
    return [htmltable titleHeaderInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCall *cell = (BNCell *)[tableView dequeueReusableCellWithIdentifier:@"myidentifier"];
  a) Simply call
    NSDictionary *hcell=[htmltable rowAtIndexPath:indexPath];
b) Do your setup with that NSDictionnary with litterals
    self.keynameOutlet.text=hcell[@"keyname"];


