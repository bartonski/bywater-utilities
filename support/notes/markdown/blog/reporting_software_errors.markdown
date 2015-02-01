# Reporting Software Errors

Software errors in Koha must be handled slightly differently than other trouble tickets submitted to support... in some ways, the errors are easier to deal with, because they typically give a pointer to the exact line in the program where the software failed, in other ways, they require more care and explanation because the error screen contains *no* context about what you as a user were doing when the error occurred.

A typical software error Looks something like this:

<div style="background-color:#eeeeee;">
<h1 style="color:rgb(0,0,0);font-family:'Times New Roman'">Software error:</h1>
<pre style="color:rgb(0,0,0)">Usage: Date::Calc::Delta_Days(year1, month1, day1, year2, month2, day2) at /home/koha/kohaclone/C4/Serials.pm line 2406.
</pre>
<p style="color:rgb(0,0,0);font-family:'Times New Roman';font-size:medium">For help, please send mail to the webmaster (<a href="mailto:staff@bywatersolutions.com">staff@bywatersolutions.com</a>), giving this error message and the time and date of the error.</p>
</div>

Unless your library has requested otherwise, the 'mailto' link will point to staff@bywatersolutions.com. This is useful in so far as it allows all librarians, even those who do not have direct access to our ticketing system, to send error messages to Bywater Solutions. The disadvantage of this is that many software error messages get sent to the staff email address rather than being entered as support tickets. If you want to open a support ticket for a software error, the ticket must be submitted by an authorized staff member. 

Please do the following when submitting a trouble ticket regarding software errors:

1. The subject line should include the words "Software error", the script name, and line number where the error occurred: If the text of the error message is `Can't call method "title" on an undefined value at /home/koha/kohaclone/cataloguing/addbiblio.pl line 835.`, the the subject of the ticket should be 'Software Error: addbiblio.pl line 835'
2. Paste the *text* of the error message into the ticket. This is one case where screen shots don't help. 
3. Use the back button to navigate to the page which triggered the error. Paste the URL of that page into the ticket
4. Describe the series of steps that lead up to the occurrence of the error. If at all possible, start from the Staff or OPAC home page, and note every URL and button click that leads to the software error. Noting the data which caused the error is especially important: If the error occurred in acquisitions, we need to know which vendor, basket, basket group, invoice and order were involved. If the software error happened in serials, we need to know which subscription, serial, and issue were involved. With holds or circulation, we need to know the patron, biblio, and item information. 
