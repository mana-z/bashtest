#!/bin/bash
_comp_bunit ()
{
    local scriptname=$1
    tests=$(grep '^ *[^#]*test_[[:alnum:]][[:alnum:]]*_[[:alnum:]][[:alnum:]]* *()' $scriptname |
        sed 's/ *().*//')
    COMPREPLY=( $(compgen -W "$tests xml xmlfile=" -- $2) )
}

while [[ -n $1 ]]; do
    complete -F _comp_bunit $1
    shift
done
