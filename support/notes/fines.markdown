# How to trouble-shoot fines:

## Are fines enabled?

Git sites
:    `crontab -ukoha -l | grep fines` should give something like this:

     15 6 * * *  $KOHA_CRON_PATH/fines.pl --out /tmp/fines

Package sites
:    `grep fines /etc/cron.daily/koha*` should show a call to fines.pl.

## Run fines.pl by hand

From fines.pl:

    This script calculates and charges overdue fines
    to patron accounts.  The Koha system preference 'finesMode' controls
    whether the fines are calculated and charged to the patron accounts ("Calculate and charge");
    calculated and emailed to the admin but not applied ("Calculate (but only for mailing to the admin)"); or not calculated ("Don't calculate").

    This script has the following parameters :
        -h --help: this message
        -l --log: log the output to a file (optional if the -o parameter is given)
        -o --out:  ouput directory for logs (defaults to env or /tmp if !exist)
        -v --verbose

### For git sites, run

    sudo su - koha
    $HOME/kohaclone/misc/cronjobs/fines.pl --verbose --log
   
Output will be written to a file whose naming convention is `koha_YYYY-MM-DD.log`. By default, the file will be in `tmp`. If the command above were run on July 31, 2014, the log file would be `/tmp/koha_2014-07-31.log`

### For package sites 

    grep fine /etc/cron.daily/koha-common
    sudo koha-shell INSTANCE

The output from the grep will probably look like this:

    koha-foreach --enabled /usr/share/koha/bin/cronjobs/fines.pl > /dev/null

Call fines.pl from the path determined by the grep, e.g.

    /usr/share/koha/bin/cronjobs/fines.pl  --verbose --log

 
## Known issues

* `fines.pl --out DIRECTORY_NAME` will fail if `DIRECTORY_NAME` does not exist.
    * This is especially bad for directories under `/tmp`, because the `/tmp` directory will be deleted and re-created on server reboot.
* `fines.pl` will crash if the branch cannot be determined for a given item. Depending on the values of the system preferences `HomeOrHoldingBranch` and 'CircControl', the borrower's home branch, the item's branch, the item's holdingbranch or some combination of these three may be usedt to determine which branch is used for fines. 
* `Not a unique accountlines record for item X borrower Y at /home/koha/kohaclone/C4/Overdues.pm line 526.` -- I'm not sure what this is... it's not fatal, but I don't know how it affects the given item/borrower.
* `fines.pl` has been known to hang for some yet undetermined reason.
