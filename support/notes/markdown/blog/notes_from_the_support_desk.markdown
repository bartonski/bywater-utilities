# Notes From the Support Desk

There were a couple of items that came up recently in support that I thought would be useful to share:

## Changes to DUEDGST and PREDUEDGST Messages in 3.16

Starting with 3.16, DUEDGST and PREDUEDGST notices can be branch specific. That means that any library who has a branch specific DUEDGST or PREDUEDGST notice that is present but broken is now using it. Previous to 3.16, only the 'All libraries' versions of these notices were used by the system.


## A Concrete Example of Why Including the URL in the Support Ticket Helps

I had a ticket that came in a bit ago with the description 'Search Information not being Transferred to z39.50 window from "Cataloging Search."'

This is a very good title for a support ticket: It tells me where the problem occurs ("Cataloging Search"), and what's going wrong ('Search Information not being Transferred to z39.50 window').

Had I been paying close attention, it would have taken me five minutes to replicate the problem, and five minutes later I would have had the answer, because Kyle Hall already had a fix written. Alas, I saw the phrase 'Cataloging Search', and confused it with 'Search the Catalog' on the Main screen of Koha... and what do you know, a) These are different and b) 'Search the Catalog' transfers its data into the Z39.50 search like clockwork... and that started an email conversation, which of course takes time.

### Lessons Learned

1. Being excruciatingly correct with terminology matters. There is a difference between 'Cataloging Search' and 'Search the Catalog'. If you happen to know that two things have names that are close, it never hurts to point out the distinction.

1. You can paste URLs into the ticket to avoid ambiguity: The phrase 'Search the catalog' appears on the Koha main page: http://intranet.bywatersolutions.com/ ,  whereas the phrase 'Cataloging search' is found on the cataloging page: http://intranet.bywatersolutions.com/cgi-bin/koha/cataloguing/addbooks.pl


