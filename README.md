# bUnit

An xUnit-like testing framework for Bash 5. Suitable for testing bash scripts or doing upper-level
tests for any other language and is capable of emitting xUnit XML files..

## Dependencies

- Bash (version 5 is needed, as associative arrays are widely used)
- bc
- GNU Coreutils

OR

- Docker

Note: busybox versions of coreutils and bc (or any other version in that matter) may work, but
expect issues.

### Installing
#### Without Docker

- Just put `bUnit.sh` to `/usr/local/bin` or any other place in your PATH.

### With Docker

- Build included Alpine-based dockerfile.


## Usage

First, before you define your tests, you have to source the framework.

```
source bunit.sh
```

and after defining the tests, call the main bUnit function  

```
bUnit_runAllTests $*
```

the function undestands a single optional paramater `xml`, which will enable emitting of xUnit XML
on the standard output.

## Defining tests

The bUnit does lookup of defined functions in this format:

```
test_<suite name>_<test name> ()
{
    # ...do the test itself...
}
```

Please note that putting any other underscore in the function definition is not allowed, and neither
is omitting any of the suite name or test name.

Neither suites nor tests need not to be declared in any other way.

For test assertions, a `fail` alias is defined and understood by bUnit, with the example usage as
shown:

```
[[ $foo == bar ]] || fail
```

bUnit is capable of pretty-printing the failure with surrounding context for ease of use.

For each test suite, a setup and a teardown may be optionally defined. Those are called before and
after each test of the suite:

```
setup_<suite name> ()
{
    # ...do some preparations...
}

teardown_<suite name> ()
{
    # ...do some cleanup....
}
```

See [example.sh](example) for example use


## Licence

This software is distributed under the GPL-3.0, see [COPYING](COPYING) for details.
