#!/bin/bash

# print failure
# note: not super-fast, will always add a few mils to duration
function _bUnit_failprint()
{
    local ctxlength=2 # lines of surrounding context
    local line=$1
    local origin=${BASH_SOURCE[1]}
    local before=$((line > ctxlength ? line - ctxlength : 0));
    local after=$((line + ctxlength));
    local snip=$(nl -ba -s\: $origin | sed -n "${before},${after}p")
    local clear="\e[2K\r" # empties the line
    echo -e "$clear\n$origin:$line:\n\n$snip\n"
}

# to have return in caller instead of having it buried in printing function, we
# have to have alias
shopt -s expand_aliases
alias fail='{ _bUnit_failprint $LINENO; return 1; }'


function bUnit_runAllTests() 
{
    local failures=0
    # nice colors
    local go_red="\e[31m"
    local go_green="\e[32m"
    local go_reset="\e[39m"
    # result messages
    local passed="${go_green}PASSED${go_reset}"
    local failed="${go_red}FAILED${go_reset}"
    declare -A suites # map for suites (associates suite name with string with tests)

    # results and times
    declare -A testresults
    declare -A testtimes
    # read all test names into an array
    read -a testlist <<< $(compgen -A function | grep ^test_ | tr '\n' ' ')
    # do actual tests
    for i in "${testlist[@]}"; do
        # parse suite name and test name from test function and store to suites map
        local mysuite=$(awk -F_ '{print $2}' <<< $i)
        local mytest=$(awk -F_ '{print $3}' <<< $i)
        suites[$mysuite]="${suites[$mysuite]} $mytest"

        # run suite setup if any
        type setup_$mysuite >/dev/null 2>&1
        [ $? -eq 0 ] && setup_$mysuite

        # testing...
        echo -n "$i..."
        local result
        local tic=$(date +%s%N)
        $i
        local result=$?
        local duration=$((($(date +%s%N)-$tic)/1000000)) # toc

        # interpret results
        testresults["${mysuite}_${mytest}"]=$result
        testtimes["${mysuite}_${mytest}"]=$duration
        if [ $result -eq 0 ]; then
            echo -e "$passed" 
        else
            echo -e "$i...$failed"
            [ $failures -lt 255 ] && ((failures++))
        fi

        #run suite teardown if any
        type teardown_$mysuite >/dev/null 2>&1
        [ $? -eq 0 ] && teardown_$mysuite
    done

    # print results for each suite
    # TODO xUnit output for appropriate $1
    for i in ${!suites[@]}; do
        echo -e "\nTest suite $i:"
        read -a tests <<< ${suites[$i]}
        for j in "${tests[@]}"; do
            [ ${testresults[${i}_$j]} -eq 0 ] && result="$passed" || result="$failed"
            echo -e "$j: $result (${testtimes[${i}_$j]} ms)"
        done
    done
    echo
    return $failures
}

