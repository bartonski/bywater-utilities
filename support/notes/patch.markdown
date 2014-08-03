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
