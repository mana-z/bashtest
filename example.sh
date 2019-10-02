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

