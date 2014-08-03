# Entering Good Support Tickets, Revisited

Two years ago, Thatcher Rea posted [Entering Good Support Tickets](http://bywatersolutions.com/2012/04/09/entering-good-support-tickets/). I felt that there was more to be said on the topic. 

Technical support is one of the primary services that we provide at Bywater Solutions. Our goal is to provide answers to your technical issues as quickly as possible, and to provide the best quality service possible -- solving the problem the first time, rather than having to revisit issues multiple times.

In order to do this, we need to get the best possible descriptions of technical problems up front.

Note: I've used the Bywater Solutions [Demo Staff Client](http://intranet.bywatersolutions.com) for examples below. Username = *bywater* Password = *bywater*.

## The Subject line of your email counts -- make is short and sweet

The first thing that we see when a support ticket arrives is the subject line. A well written subject may be the difference between a ticket that gets solved in five minutes and one that takes hours or more to resolve. The subject should be memorable and should point us in the right direction.

## Text is better than pictures
Screen shots have their place -- some times they can tell a story that is difficult to put into words -- however it is impossible to copy and paste text from a screenshot. Screenshots should be used for illustration and clarification, but the body of the description *must* contain text.

## Always copy and paste -- don't retype.
There are certain pieces of information within a trouble ticket that are useless if they are not typed correctly: biblionumbers, barcodes, item numbers, URLs will all fail if mis-typed. Error messages on screen should also be copied if at all possible.

## Including URLs: The secret weapon of Koha support.
Because Koha is a web based application, the URL will, at the very least, tell us which web address is causing the error. In fact, the URL can contain a good deal more information than that. For instance, the URL <http://intranet.bywatersolutions.com/cgi-bin/koha/members/moremember.pl?borrowernumber=165> contains two parts: <http://intranet.bywatersolutions.com/cgi-bin/koha/members/moremember.pl> is the address of the page that handles patron information, and [?borrowernumber=165](http://intranet.bywatersolutions.com/cgi-bin/koha/members/moremember.pl?borrowernumber=165) specifies patron number '165' on that page. Copying and pasting the full URL of a page that is causing problems can supply a lot of information in a trouble ticket. This is escpecially helpful when a page is displaying an error message of some kind.

## Information to include in a support ticket:

### Where does the problem occur?
* In the OPAC?
* In the Staff Client?
    * What part?
        * Circulation?
        * Search?
        * Holds?
* Paste the URL into the ticket.

### Is there an error message? 
Paste the *text* into the ticket.

### *Always* include an example patron, item or title. Names are good, ID numbers are better:
#### Patron:
* Good: First Name, Last Name
* Better: Cardnumber
* Best: Borrowernumber / Patron URL

#### Item:
* Good: Title
* Better: Barcode
* Best: Itemnumber / Item URL

#### Title (I.e. biblio record)
* Good: Title
* Best: Biblionumber / Biblio URL

### How often does this problem occur?  
* Are there issues every time you try? 
* If the problem is intermittent, How often Does it occur on  average: Once per hour? Once per day?

### Describe, step by step, how to replicate the problem.
* Be as detailed as possible. 

### What Web browser are you using?
* Brand: Microsoft Internet Explorer, Mozilla Firefox, Google Chrome
* Version: Go to the help menu, choose 'about' and paste the version number into the ticket.

### Is the issue browser specific (e.g. does the issue occur in Chrome but not Firefox, or vise versa)?

### Are ther logs available?
* There are several system preferences which enable loggging. Make sure that logging is enabled for whichever system you are having issues with.
* When the problem re-occurs, Go to Tools > Log Viewer. 
* Put item number in the 'Object' text box
* Narrow the date range. 
* Click 'submit' to search the logs. 
* Paste the results into the trouble ticket.

### Have you cleared the browser cache?

Certain javascript heavy pages, such as circulation, can save information for re-use. Under certain circumstances, this information can get out of date, causing unpredictable behaviour. Try clearing the browser cache.

* firefox:  <https://support.mozilla.org/en-US/kb/how-clear-firefox-cache#w\_clear-the-cache>
* chrome:  <https://support.google.com/chrome/answer/95582?hl=en>

### Can you capture the problem in a screencast? See <http://bywatersolutions.com/2011/12/14/screencasts-for-koha-bugticket-reporting/>

## Examples:

### Subject:

#### Bad: 
* It's broken
* Error Message
* It won't print

#### Better:
* Error Message in catalog search for 'Harry Potter'
* Problem printing quick slip on checkout.

#### Best:
* staff client mainpage.pl catalog search for 'Harry Potter' causes '404 Page Not Found'
* Circulation: title does not print on quick slip, checking out barcode E12073366

### Description:

#### Bad:
* When I was checking out an item, the slip messed up.

#### Better:
* When I was checking out 'Harry Potter', the title did not print on the quick slip
    * This would be a reasonable subject line, but lacks detail.

#### Best:
* Steps to re-create the problem:
    1. Start at Home > Circulation > Checkouts (http://intranet.bywatersolutions.com/cgi-bin/koha/circ/circulation.pl)
    2. Enter Card Number for patron 'Pikov Andropov', card number 443 in search bar with 'Check Out' enabled.
    3. Scan Barcode 'E12107351' (title: Practical open source software for libraries /)
    4. Check 'Cancel hold' check box then clicked 'Yes, Check Out (Y)'
    5. Click 'Print' button, selected 'Print Quick Slip'
    6. At this point, I expect to see all of the information about 'Practical open source software for libraries' printed on the slip -- the barcode and due date do print, but the title does not.
* I took a picture with my cell phone of the slip as it printed -- I'm pointing to the place where the title should appear. The jpeg is attached to this email.

Future blog posts will detail information to include for specific types of problems.

