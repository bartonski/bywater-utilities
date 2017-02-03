The environment variable `$EMPLOYER_PATH` should be exported by your shell startup.

The file .bywater is meant to be sourced at shell startup,

The environment variable `$EMPLOYER_PATH` should be set to the install directory.
Assuming that the install directory is `$HOME/Employer/`, the following lines may
be added to `.bashrc`, or a file sourced by `.bashrc`:

    export EMPLOYER="bywater"
    export EMPLOYER_PATH="$HOME/Employer/${EMPLOYER}"
    export EMPLOYER_RC="${EMPLOYER_PATH}/.${EMPLOYER}"

    ## If annon is down, uncomment the following line to enable 'assh' and 'sassh' functions.
    #export BYWATER_GATEWAY='echor.bywatersolutions.com'

    employerrc() {
        $EDITOR $EMPLOYER_RC
        source $EMPLOYER_RC
    }


    if [ ! -d ${EMPLOYER_PATH} ]
    then
        mkdir -p ${EMPLOYER_PATH}
    fi

    if [ -f $EMPLOYER_RC ]
    then
        source $EMPLOYER_RC
    fi

