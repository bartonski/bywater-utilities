Ticket: [20669](http://ticket.bywatersolutions.com/Ticket/Display.html?id=20669)

    The good news is that I've seen the first error (Usage: Date::Calc::DeltaDays...) since this ticket was closed, and I know how to fix it: The 'History Start D
    ate' is missing for the serials that have this error; populating that will fix the error. If you can't get to the screen that you need to be able to populate 
    that date, let me know; I can make changes to the database manually.

Ticket: [21190](http://ticket.bywatersolutions.com/Ticket/Display.html?id=21190)

    Date::Calc::Add_Delta_YM(): not a valid date at /var/lib/koha/aarome/kohaclone/C4/Serials.pm line 2651.
    13:03 <@barton> right ... so aarome is getting a warning "Date::Calc::Add_Delta_YM(): not a valid date at /var/lib/koha/aarome/kohaclone/C4/Serials.pm line ::
    13:03 <@barton> right ... so aarome is getting a warning "Date::Calc::Add_Delta_YM(): not a valid date at /var/lib/koha/aarome/kohaclone/C4/Serials.pm line 

Ticket: [21314](http://ticket.bywatersolutions.com/Ticket/Display.html?id=21314)

    Date::Calc::Add_Delta_YM(): not a valid date at /home/koha/kohaclone/C4/Serials.pm line 2626, <DATA> line 522.
    > Date::Calc::Add_Delta_YM(): not a valid date at
    > > Date::Calc::Add_Delta_YM(): not a valid date at
    > > > Date::Calc::Add_Delta_YM(): not a valid date at
    > > Date::Calc::Add_Delta_YM(): not a valid date at 

Ticket: [22008](http://ticket.bywatersolutions.com/Ticket/Display.html?id=22008)

    Usage: Date::Calc::Delta_Days(year1, month1, day1, year2, month2,
    > Usage: Date::Calc::Delta_Days(year1, month1, day1, year2, month2,
    > > Usage: Date::Calc::Delta_Days(year1, month1, day1, year2, month2,
    > > > Usage: Date::Calc::Delta_Days(year1, month1, day1, year2, month2,
    > > > > Usage: Date::Calc::Delta_Days(year1, month1, day1, year2, month2,


Ticket: [22278](http://ticket.bywatersolutions.com/Ticket/Display.html?id=22278)

    Date::Calc::Delta_Days(): not a valid date at /usr/share/koha/lib/C4/Serials.pm line 2492.

Errors:

* Serials.pm
    * 2406: `Usage: Date::Calc::Delta_Days(year1, month1, day1, year2, month2, day2) at /home/koha/kohaclone/C4/Serials.pm line 2406,  <DATA> line 522.`
    * 2406: `Usage: Date::Calc::Delta_Days(year1, month1, day1, year2, month2, day2) at /home/koha/kohaclone/C4/Serials.pm line 2406.`
    * 2492: `Date::Calc::Delta_Days(): not a valid date at /usr/share/koha/lib/C4/Serials.pm line 2492.`
    * 2626: `Date::Calc::Add_Delta_YM(): not a valid date at /home/koha/kohaclone/C4/Serials.pm line 2626, <DATA> line 522.`
    * 2651: `Date::Calc::Add_Delta_YM(): not a valid date at /var/lib/koha/aarome/kohaclone/C4/Serials.pm line 2651.`
* Circulation.pm
    * `Undefined subroutine &C4::Circulation::HasOverdues called at /usr/share/koha/lib/C4/Circulation.pm line 1925, <DATA> line 522.`
