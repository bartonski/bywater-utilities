# The Magic of URL

In the spirit of Halloween, this will be a terrifying blog post with a treat at the end.

## The tame part

Allow me to invite you into an eldrich realm of wizardry and arcana. A place where some of Google's greatest secrets live, and a place of great power for Koha: the world of URL. 

URL stands for 'Uniform Resource Locator'. Colloquially, it is a 'web address', although technically URLs may point to resources other than web pages. Take, for example, our humble ( and by this point familiar, if you've been reading my blog posts ) Bywater Solutions' Koha demo site: <http://intranet.bywatersolutions.com/>.

Go ahead. Click on it. Log in ( username: *bywater*, password: *bywater* ). You may want to open it in another browser window, because the magic of URLs is best seen in action.

Once you've logged in, look at the address bar of your browser. It will probably read as `intranet.bywatersolutions.com`. If you were to copy and paste the contents of the address bar into a document, you would again see `http://intranet.bywatersolutions.com/` ... the `http://` part, and the trailing slash are hidden by the browser, but they are part of the URL. I will be including the `http://` part in the URLs in my examples to follow because it's part of the magic... pasting URL ( including the `http://` part ) into most applications ( word processors, email clients, spreadsheets, IRC clients etc. ) lets the program know that what you've just pasted is URL, it will then appear as a click-able link. 

Once logged in to the staff client, click the 'Search' link. This will bring you to the advanced search screen. If you look in the address bar, you will see that the URL has changed to

<http://intranet.bywatersolutions.com/cgi-bin/koha/catalogue/search.pl>

The part after `.com/` hos now changed to `cgi-bin/koha/catalogue/search.pl`. This is because Koha is not a single program. It is actually made of numerous small programs that work together. The programs are named for their functions: `search.pl` is the program that runs "advanced search".

If you search for "The Klutz book of magic", you will arrive at the following URL:

<http://intranet.bywatersolutions.com/cgi-bin/koha/catalogue/detail.pl?biblionumber=36264>

So ... we know that `detail.pl` is a program that's part of Koha ... in this case, it's the part that displays Biblio and Item detail... but what does `?biblionumber=36264` mean? ... Ok, well, it's kind of obvious that it displays the biblionumber for the title "The Klutz book of magic /", but that's not the magic part. The magic is that *anything* that comes after `?` in a URL gives the web page information to act on. The information comes in the form of "key-value pairs". The part on the left of the '=' sign, in this case `biblonumber`, is the key, the part on the right, `36264` , is the value... and the program `detail.pl` knows that when it sees the key `biblionumber` it should display all of the information that Koha knows about the book that has the specified biblionumber.

## The scary part

It turns out that `search.pl` does a number of weird and wonderful things with URLs ... if it finds a single bib record, it displays `detail.pl?biblonumber=...`, as shown above. If it finds multiple bib records, it points back to itself and displays a list of results. Try doing an advanced search for 'magic'... the URL is indeed magical:

http://intranet.bywatersolutions.com/cgi-bin/koha/catalogue/search.pl?idx=kw&q=magic&op=and&idx=kw&q=&op=and&idx=kw&q=&limit-yr=&limit=&limit=&limit=&limit=&limit=&limit=&multibranchlimit=&sort\_by=relevance

Notice that the URL again shows the name of the script (`search.pl`) followed by `?`. Again, there is a key-value pair -- `idx=kw` after this, comes `&` followed by *another* key-value pair: `q=magic` ... if there are multiple key-value pairs, they are separated by ampersands... so the full URL says essentially the following:

search

* by keyword ( `idx=qw` )
* query for "magic" ( `q=magic` )
* and ( `op=and` )
* by keyword ( `idx=kw` )
* query for "" ( `q=` )
* and ( `op=and` )
* by keyword ( `idx=kw` )
* query for "" ( `q=` )
* limit year "" ( `limit-yr=` )
* limit "" ( `limit=` )
* limit "" ( `limit=` )
* limit "" ( `limit=` )
* limit "" ( `limit=` )
* limit "" ( `limit=` )
* limit "" ( `limit=` )
* multi branch limit "" ( `multibranchlimit=` )
* sort\_by relevance ( `sort_by=relevance` )

If you look at the structure of the advanced search page, you will find that most of this is boilerplate based on the possible searches and search limits that you can specify on that page: three queries (two empty, because we only searched by 'magic'), an empty 'limit year', followed by six empty limits ( I think that these line up with the "Subtype limits"), An empty "multi branch limit" followed by the default sort\_by relevance.

I will leave it to you to poke around in the address bar to find interesting things that Koha does... the staff client 'search.pl' and its OPAC sister probably generate the most elaborate URLs, but there are others that do interesting things in the address bar.

## The treat at the end

"*So where's the treat? You said there would be a treat!*". I hear you cry... Yes, I did say that. It turns out that Firefox has a nifty little feature called [Quick search bookmarks](http://sugarrae.com/online-marketing/seo/creating-firefox-quick-search-bookmarks/), which allow you to create shortcuts in the address bar, including substitutions.

Let's say that you could click on the address bar and type `kohasearch magic`, and get the results of a keyword search for "magic"? Or let's say that you could type `biblionumber 12345` in in the address bar, and be taken directly to that biblio record in Koha? Or maybe `z39isbn 0932592708` to do a z39.50 search for "The Klutz book of magic"?

Quick search bookmarks can do all of these.

I'll show you how to set up `kohasearch`, the others follow the same pattern.

1. Go to *Advanced search*
1. Make a search (such as "magic", above), which will return multiple bib records. Click 'search'
1. Bookmark the results page
1. Click on the Firefox *Bookmarks* menu then click *Show all bookmarks*
1. Find and click on the bookmark that you just added (you can find it under *Recently Bookmarked*). You will see *Name*, *Location* and *Tags* at the bottom of the window, followed by a button with a down arrow, and the label *More*
1. Click on this button
1. You will now see *Name*, *Location*, *Tags*, *Keyword* and *Description*
1. Enter `kohasearch` in the *Keyword* text area
1. Change the location, replacing `magic` (or whatever you searched for) with `%s`
1. Close the *Bookmarks* window

That's it. Click in the address bar and type `kohasearch juggling` to do a keyword search for "juggling".

