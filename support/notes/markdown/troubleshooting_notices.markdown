<style>
table
{
border-collapse:collapse;
}
table,th, td
{
border: 1px solid black;
}
</style>

# The Good, The Bad and The Ugly: Trouble-Shooting Notices and Slips in Koha

One of the phrases that you hear about open source software is that it has a 'scratch your own itch' development model. If you need a feature, you have the source code, and you can make changes as you see fit (or pay a developer to make the changes for you). If the community agrees that your changes are useful, they are added to the code base as a whole. By and large, this is a very powerful approach to development, and it ensures that the features that people really want are the ones that see the majority of the development effort. I firmly believe that Koha is far more robust as an open source project than it would have been as a closed source project. Koha has grown organically over time.

As with any organic system, there are places where function is driven by chaos, rather than any underlying design, and few places in Koha demonstrate this principle more than the 'Notices and Slips' system, which controls any information that is either printed by or sent as a message by Koha.

Just as before, I've used the Bywater Solutions [Demo Staff Client](http://intranet.bywatersolutions.com) for examples below. Username = *bywater* Password = *bywater*.

## The Good: Everything is configured on the 'Notices and Slips' tools page.

The one thing that Notices and slips has going for it is that they are all defined in one place. All print slips and notices are defined on the *Tools > Notices & Slips* page: <http://intranet.bywatersolutions.com/cgi-bin/koha/tools/letter.pl> ... If you have *anything* that is printed or sent by email, you know that it will be configured through a notice on this page.

## The Bad: Many implementations of Notices and Slips

There are 9 different source files in Koha that generate or manipulate notices. Among these, there are 5 different ways of handling repeated data (six, if you count notices that don't accept repeated data). Some notices are generated in cron jobs that are separate from the web application. The logic governing what data is available in the cron scripts isn't reflected in the user interface used to create the templates. Even though all of the notices are defined in _Tools > Notices and Slips_, different scripts behave in different way. There's no obvious way to tell why, for instance, the PREDUE\_DGST notice uses \<\<items.content\>\> to list items that are coming due, but you can use \<item\> \</item\> tags to print the same type of information in overdue notices. Some notices may be branch specific, while others may not, depending entirely on which source file implements the logic.

C4/Circulation.pm
=================
    my $letter =  C4::Letters::GetPreparedLetter (
        module => 'circulation',
        letter_code => $type,
        branchcode => $branch,
        tables => {
            $issues_table => $item->{itemnumber},
            'items'       => $item->{itemnumber},
            'biblio'      => $item->{biblionumber},
            'biblioitems' => $item->{biblionumber},
            'borrowers'   => $borrower,
            'branches'    => $branch,
        }
    ) or return;
    return C4::Letters::GetPreparedLetter (
        module => 'circulation',
        letter_code => 'TRANSFERSLIP',
        branchcode => $branch,
        tables => {
            'branches'    => $to_branch,
            'biblio'      => $item->{biblionumber},
            'items'       => $item,
        },
    );

C4/Members.pm
=============
    return  C4::Letters::GetPreparedLetter (
        module => 'circulation',
        letter_code => $letter_code,
        branchcode => $branch,
        tables => {
            'branches'    => $branch,
            'borrowers'   => $borrowernumber,
        },
        repeat => \%repeat,
    );

C4/Message.pm
=============
    my $letter =  C4::Letters::GetPreparedLetter (
        module => 'circulation',
        letter_code => 'CHECKOUT',
        branchcode => $branch,
        tables => {
            'biblio', $item->{biblionumber},
            'biblioitems', $item->{biblionumber},
        },
    );

C4/Reserves.pm
==============
        if ( my $letter =  C4::Letters::GetPreparedLetter (
            module => 'reserves',
            letter_code => 'HOLDPLACED',
            branchcode => $branch,
            tables => {
                'branches'  => $branch_details,
                'borrowers' => $borrower,
                'biblio'    => $biblionumber,
                'items'     => $checkitem,
            },
        ) ) {
        my $letter =  C4::Letters::GetPreparedLetter ( %letter_params ) or die "Could not find a letter called '$letter_params{'letter_code'}' in the 'reserves' module";

        C4::Letters::EnqueueLetter( {
            letter => $letter,
            borrowernumber => $borrowernumber,
            message_transport_type => 'print',
        } );
        my $letter =  C4::Letters::GetPreparedLetter ( %letter_params ) or die "Could not find a letter called '$letter_params{'letter_code'}' in the 'reserves' module";

        C4::Letters::EnqueueLetter(
            {   letter                 => $letter,
                borrowernumber         => $borrowernumber,
                message_transport_type => 'email',
                from_address           => $admin_email_address,
            }
        );
        my $letter =  C4::Letters::GetPreparedLetter ( %letter_params ) or die "Could not find a letter called '$letter_params{'letter_code'}' in the 'reserves' module";

        C4::Letters::EnqueueLetter(
            {   letter                 => $letter,
                borrowernumber         => $borrowernumber,
                message_transport_type => 'sms',
            }
        );
    return  C4::Letters::GetPreparedLetter (
        module => 'circulation',
        letter_code => 'RESERVESLIP',
        branchcode => $branch,
        tables => {
            'reserves'    => $reserve,
            'branches'    => $reserve->{branchcode},
            'borrowers'   => $reserve->{borrowernumber},
            'biblio'      => $reserve->{biblionumber},
            'items'       => $reserve->{itemnumber},
        },
    );

C4/Suggestions.pm
=================
            my $letter = C4::Letters::GetPreparedLetter(
                module      => 'suggestions',
                letter_code => $full_suggestion->{STATUS},
                branchcode  => $full_suggestion->{branchcode},
                tables      => {
                    'branches'    => $full_suggestion->{branchcode},
                    'borrowers'   => $full_suggestion->{suggestedby},
                    'suggestions' => $full_suggestion,
                    'biblio'      => $full_suggestion->{biblionumber},
                },
            )

misc/cronjobs/overdue\_notices.pl
================================
    return C4::Letters::GetPreparedLetter (
        module => 'circulation',
        letter_code => $params->{'letter_code'},
        branchcode => $params->{'branchcode'},
        tables => \%tables,
        substitute => $substitute,
        repeat => { item => \@item_tables },
    );

misc/cronjobs/thirdparty/TalkingTech\_itiva\_outbound.pl
======================================================
        my $letter = C4::Letters::GetPreparedLetter(
            module      => $module,
            letter_code => $code,
            tables      => {
                borrowers   => $issues->{'borrowernumber'},
                biblio      => $issues->{'biblionumber'},
                biblioitems => $issues->{'biblionumber'}
            },
        );

opac/opac-memberentry.pl
========================
            my $letter = C4::Letters::GetPreparedLetter(
                module      => 'members',
                letter_code => 'OPAC_REG_VERIFY',
                tables      => {
                    borrower_modifications =>
                      [ $verification_token, $verification_token ],
                },
            );


## The Ugly: 

The unfortunate consequence of the organic nature of Notices and Slips is that you have to keep track of it all. If you want your notices to look and behave correctly, you have to know what data is available in which notices, and whether or not the notices must be defined for all libraries, or may be branch specific.

### Formatting and available data, by letter code
+-------------------+--------------------------------+---------------------------------------------+------------------------+
| Letter Code       | Used In                        | Detail tag                                  | Accessible data        | 
+-------------------+--------------------------------+---------------------------------------------+------------------------+
| DUE               | advance\_notices.pl            | \<\<items.content\>\>                       | \<\<items.content\>\>  |
|                   |                                |                                             | Defaults to date,title,|
|                   |                                |                                             | author,barcode.        |
|                   |                                |                                             | Specified using <br /> |
|                   |                                |                                             | `--itemscontent` option|
|                   |                                |                                             | at the command line.   |
|                   |                                |                                             | Any column from        |
|                   |                                |                                             | biblios, items and     |
|                   |                                |                                             | issues tables may be   |
|                   |                                |                                             | used in items.content. |
|                   |                                |                                             | Other information:     |
|                   |                                |                                             | \<count\> : number of  |
|                   |                                |                                             | items due. <br />      |
|                   |                                |                                             | \<branch.*\> : rows    |
|                   |                                |                                             | from the branches table|
|                   |                                |                                             | pertaining             |
|                   |                                |                                             | to the branch sending  |
|                   |                                |                                             | the notice             |
+-------------------+--------------------------------+---------------------------------------------+------------------------+
| DUEDGST           | advance\_notices.pl            | \<\<items.content\>\>                       | Same as DUE            |
+-------------------+--------------------------------+---------------------------------------------+------------------------+
| PREDUE            | advance\_notices.pl            | \<\<items.content\>\>                       | Same as DUE            |
+-------------------+--------------------------------+---------------------------------------------+------------------------+
| PREDUEDGST        | advance\_notices.pl            | \<\<items.content\>\>                       | Same as DUE            |
+-------------------+--------------------------------+---------------------------------------------+------------------------+
| ODUE\*            | overdue\_notices.pl            | \<\<items.content\>\> or \<item\> \</item\> | \<\<items.content\>\>  |
|                   |                                |                                             | Works identically to   |
|                   |                                |                                             | \<\<items.content\>\>  |
|                   |                                |                                             | in advance\_notices.pl.|
|                   |                                |                                             | \<item\> and  \</item\>|
|                   |                                |                                             | tags will expand fields|
|                   |                                |                                             | from items table:      |
|                   |                                |                                             | \<item\> items.barcode |
|                   |                                |                                             | \</item\> will show the|
|                   |                                |                                             | overdue item's barcode |
|                   |                                |                                             | Multiple fields may be |
|                   |                                |                                             | expanded inside a      |
|                   |                                |                                             | single pair of tags.   |
+-------------------+--------------------------------+---------------------------------------------+------------------------+
| CHECKOUT          | C4/Circulation.pm              | N/A                                         | Yes                    |
+-------------------+--------------------------------+---------------------------------------------+------------------------+
| RENEWAL           | C4/Circulation.pm              | N/A                                         | Yes                    |
+-------------------+--------------------------------+---------------------------------------------+------------------------+
| TRANSFERSLIP      | C4/Circulation.pm              | N/A                                         | Yes                    |
+-------------------+--------------------------------+---------------------------------------------+------------------------+
| ISSUESLIP         | C4/Members.pm                  | \<checkedout\> \</checkedout\> <br />       | Yes                    |
|                   |                                | \<overdue\> \</overdue\>       <br />       |                        |
|                   |                                | \<news\> \</news\>             <br />       |                        |
+-------------------+--------------------------------+---------------------------------------------+------------------------+
| ISSUEQSLIP        | C4/Members.pm                  | \<checkedout\> \</checkedout\>              | Yes                    |
+-------------------+--------------------------------+---------------------------------------------+------------------------+
| HOLDPLACED        | C4/Reserves.pm                 | N/A                                         | Yes                    |
+-------------------+--------------------------------+---------------------------------------------+------------------------+
| RESERVESLIP       | C4/Reserves.pm                 | N/A                                         | Yes                    |
+-------------------+--------------------------------+---------------------------------------------+------------------------+
| ASKED             | C4/Suggestions.pm              | N/A                                         | Yes                    |
+-------------------+--------------------------------+---------------------------------------------+------------------------+
| CHECKED           | C4/Suggestions.pm              | N/A                                         | Yes                    |
+-------------------+--------------------------------+---------------------------------------------+------------------------+
| ACCEPTED          | C4/Suggestions.pm              | N/A                                         | Yes                    |
+-------------------+--------------------------------+---------------------------------------------+------------------------+
| REJECTED          | C4/Suggestions.pm              | N/A                                         | Yes                    |
+-------------------+--------------------------------+---------------------------------------------+------------------------+
| PREDUE\_PHONE     | TalkingTech\_itiva\_outbound   | N/A                                         | No                     |
+-------------------+--------------------------------+---------------------------------------------+------------------------+
| OVERDUE\_PHONE    | TalkingTech\_itiva\_outbound   | N/A                                         | No                     |
+-------------------+--------------------------------+---------------------------------------------+------------------------+
| HOLD\_PHONE       | TalkingTech\_itiva\_outbound   | N/A                                         | No                     |
+-------------------+--------------------------------+---------------------------------------------+------------------------+
| OPAC\_REG\_VERIFY | opac/opac-memberentry.pl       | N/A                                         | No                     |
+-------------------+--------------------------------+---------------------------------------------+------------------------+

### Can notice be branch speicific -- by letter code
+-------------------+------------------------+
| Letter Code       | Can be branch specific |
+===================+========================+
| DUE               | Yes                    |
+-------------------+------------------------+
| DUEDGST           | No                     |
+-------------------+------------------------+
| PREDUE            | Yes                    |
+-------------------+------------------------+
| PREDUEDGST        | No                     |
+-------------------+------------------------+
| ODUE\*            | Yes                    |
+-------------------+------------------------+
| CHECKOUT          | Yes                    |
+-------------------+------------------------+
| RENEWAL           | Yes                    |
+-------------------+------------------------+
| TRANSFERSLIP      | Yes                    |
+-------------------+------------------------+
| ISSUESLIP         | Yes                    |
+-------------------+------------------------+
| ISSUEQSLIP        | Yes                    |
+-------------------+------------------------+
| HOLDPLACED        | Yes                    |
+-------------------+------------------------+
| RESERVESLIP       | Yes                    |
+-------------------+------------------------+
| ASKED             | Yes                    |
+-------------------+------------------------+
| CHECKED           | Yes                    |
+-------------------+------------------------+
| ACCEPTED          | Yes                    |
+-------------------+------------------------+
| REJECTED          | Yes                    |
+-------------------+------------------------+
| PREDUE\_PHONE     | No                     |
+-------------------+------------------------+
| OVERDUE\_PHONE    | No                     |
+-------------------+------------------------+
| HOLD\_PHONE       | No                     |
+-------------------+------------------------+
| OPAC\_REG\_VERIFY | No                     |
+-------------------+------------------------+

## How do we make this better (A Fist Full of Dollars)

* [Notifications RFC](http://wiki.koha-community.org/wiki/Notifications_RFC)
* [Bug 6833 - Notifications Rewrite](http://bugs.koha-community.org/bugzilla3/show_bug.cgi?id=6833)
