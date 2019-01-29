#!/bin/bash

source bunit.sh

test_otherSuiteWithDifferentHello_helloWorld ()
{
    [ 0 -eq 1 ] || fail
    return 0
}

setup_general ()
{
    echo setup for general called > /dev/stderr
}

teardown_general ()
{
    echo teardown for general called > /dev/stderr
}

test_general_helloWorld ()
{
    [ 0 -eq 0 ] || fail
    return 0
}

test_general_willFail ()
{
    [ 1 -eq 0 ] || fail
    return 0
}

bUnit_runAllTests $1

