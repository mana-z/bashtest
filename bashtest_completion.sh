#!/bin/bash
################################################################################
#
# Copyright 2019 Martin Zalabak
#
# This file is part of bashtest.
#
# bashtest is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# bashtest is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with bunit.  If not, see <https://www.gnu.org/licenses/>.
#
################################################################################

_comp_bashtest ()
{
    local scriptname=$1
    tests=$(grep '^ *[^#]*test_[[:alnum:]][[:alnum:]]*_[[:alnum:]][[:alnum:]]* *()' $scriptname |
        sed 's/ *().*//')
    COMPREPLY=( $(compgen -W "$tests xml xmlfile=" -- $2) )
}

while [[ -n $1 ]]; do
    complete -F _comp_bashtest $1
    shift
done
