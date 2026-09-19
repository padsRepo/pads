extractFunctions (){ 
    [[ $# -eq 0 ]] && printf "Syntax: ${FUNCNAME} <pkgname>\n" && exit 2;
    # Run extractFunctions paddocs
    search=($(locateModules $1));
    # Sample of $search output into an array:
    # $HOME/dev/pads/source/paddocs/src/build.sh
    # $HOME/dev/pads/source/paddocs/src/generate.sh
    # $HOME/dev/pads/source/paddocs/src/make.sh
    # $HOME/dev/pads/source/paddocs/src/parse.sh
    printf "${search:0}\n";
    for f in $(declare -f > ${search:0});
    do
        echo $f;
        # Sample of the output to EVERY FILE, overwriting everything on each file:
        # declare -f CODE
        # declare -f CRITICAL
        # declare -f CTL+C
        # declare -f ERROR
        # declare -f FAIL
        # declare -f INFO
        # declare -f SUCCESS
        # declare -f WARNING
        # declare -f description
        # declare -f dryrun
        # declare -f extractBashMetadata
        # declare -f extractFunctions
        # declare -f extractSourceCode
        # declare -f extractTagBlock
        # declare -f extractTags
        # declare -f extractUsage
        # declare -f extractVars
        # declare -f locateBinary
        # declare -f locateDirectory
        # declare -f locateModules
        # declare -f manual
        # declare -f parsePython
        # declare -f status
        # declare -f traceback
        # declare -f usage
    done
}
