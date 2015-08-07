## Download patch

    patch_serial=4; wget -O bug_10827.${patch_serial}.patch http://bugs.koha-community.org/bugzilla3/attachment.cgi?id=25946

I'm plannning on writting a shell funciton that will take a list of patch URLs and download each, generating a different file name for each.

## Applying the patch

    git am foo.patch

In fact, the attachment ids tend to be serial, so you can do something like this:

    getpatch() {
        local bugnum=$1
        local description="$(sed 's/ /-/g' <<< $2)"
        local attachment=$3
        local bwspatches="$HOME/bwspatches"
        local kohaclone="$HOME/kohaclone"
        local patchfile="bug_${bugnum}.${description}.${attachment}.patch"
        echo "Changing directory to '$bwspatches'"
        cd "$bwspatches"
        wget -O "$patchfile" "http://bugs.koha-community.org/bugzilla3/attachment.cgi?id=${attachment}" || break
        echo "Changing directory to '$kohaclone'"
        cd $kohaclone
        echo "run the following command:"
        echo "git am '$bwspatches/$patchfile'"
    }

Then get the patches like this:

    # Ticket number 11563
    for attach in {26570..26573}
    do
        getpatch 11563 "Class noEnterSubmit no longer functioning" $attach
    done


## Creating a patch

    git add <filename>
    git commit 
    git log 
    copy the commit number 
    git format-patch -1 <commit>

or 

    git format-patch HEAD^ -I <commit>

## Backing out a failed merge

    git am --abort

## Squashing Patches

Rebase -- give yourself a couple of patches leeway -- better to choose too many than too few.

    git rebase -i HEAD~7

This will bring up an editor with the following commits:

    pick d7bc710 BYWATER CUSTOM - Renew via SIP2 fails, fixed in master
    pick 632b157 Bug 13636 - Search results item status incorrect for holds
    pick c449f28 Grand commit of zebra indexes
    pick f316b65 change index names to use dashes rather than underscores
    pick 116d875 Adding index for Marc 691
    pick 57954d0 Removing index for 852 h
    pick dcf17f7 Add zebra index for Awards at 586 a

squash'em

    pick d7bc710 BYWATER CUSTOM - Renew via SIP2 fails, fixed in master
    pick 632b157 Bug 13636 - Search results item status incorrect for holds
    pick c449f28 Grand commit of zebra indexes
    s f316b65 change index names to use dashes rather than underscores
    s 116d875 Adding index for Marc 691
    s 57954d0 Removing index for 852 h
    s dcf17f7 Add zebra index for Awards at 586 a

Any commit marked 's' will be squashed into the commit above. In this case, the 4 latest commits are squashed into `c449f28 Grand commit of zebra indexes`

Once sqashed, run

    git format-patch HEAD~1
