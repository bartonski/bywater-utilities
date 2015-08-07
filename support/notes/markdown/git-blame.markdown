# The Goodness That Is Git Blame

Git blame is a tool that allows you to find out who made a certain change in git.

I'm going to use the following section of bib1.att:

    353    # Lexile number
    354    att 9903    lex
    355    att 9904    arl
    356    att 9013    arp

I want to know what 'arl' and 'arp' stand for... I can see that they're
defined on lines 355 and 356, respectively. So I use 'git blame' to find
out which commits those lines belong to:

    git blame -L 355,356 etc/zebradb/biblios/etc/bib1.att

Git blame doesn't actually accuse anybody of anything, it is simply saying
'print out the commit number before each line of code'. Here's the output:

    2ca25a91 (amit gupta 2010-04-16 13:23:01 +0530 355) att 9904    arl
    a7fa02e0 (amit gupta 2010-04-16 13:18:31 +0530 356) att 9013    arp

The first line has the commit number `2ca25a91`. We can then run

    git log 2ca25a91

Which gives us

    Author: amit gupta <amit.gupta@osslabs.biz>
    Date:   Fri Apr 16 13:23:01 2010 +0530

        Allow zebra search for Accelerated Reading Level in field 526$c
        
        Signed-off-by: Galen Charlton <gmcharlt@gmail.com>

The other commit `a7fa02e0`

    git log a7fa02e0

gives us

    commit a7fa02e06f04be544ff9f6ff177ab9b1d05ae1f7
    Author: amit gupta <amit.gupta@osslabs.biz>
    Date:   Fri Apr 16 13:18:31 2010 +0530

        Allow zebra search for Accelerated Reading Point in field 526$d
        
        Signed-off-by: Galen Charlton <gmcharlt@gmail.com>

... so now I know that `arl` stands for `Accelerated Reading Level` and
`arp` stands for `Accelerated Reading Point`.
