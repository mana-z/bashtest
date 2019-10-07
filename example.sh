#!/bin/bash
################################################################################
#
# Copyright 2019 Martin Zalabak
#
# This file is part of bunit.
#
# bunit is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# bunit is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with bunit.  If not, see <https://www.gnu.org/licenses/>.
#
################################################################################


source bunit.sh


# setup function for a test suite 'general', called before every test of the suite
setup_general ()
{
    echo setup for general called > /dev/stderr
}

# teardown function for a test suite 'general', called after every test of the suite
teardown_general ()
{
    echo teardown for general called > /dev/stderr
}

# an example (passing) test called 'helloWorld' in a 'general' suite
test_general_helloWorld ()
{
    [ 0 -eq 0 ] || fail
    return 0
}

# an example (failing) test called 'helloWorld' in a 'general' suite
test_general_willFail ()
{
    [ 1 -eq 0 ] || fail
    return 0
}

# a test in an different test suite, but with a same name of test
# - same names in a different suites does not conflict
test_otherSuiteWithDifferentHello_helloWorld ()
{
    [ 0 -eq 1 ] || fail
    return 0
}


bUnit_runAllTests $1

