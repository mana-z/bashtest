# bashtest

An xUnit-like testing framework for Bash 5. Suitable for testing bash scripts or doing upper-level
tests for arbitrary executables and is capable of emitting xUnit XML files.

## Dependencies

- Bash (version 5+ needed, as associative arrays are widely used)
- bc
- GNU Coreutils

OR

- Docker

Note: busybox versions of Coreutils and bc (or any other version in that matter) may work, but
expect issues.

## Installing
### Without Docker

- Just put `bashtest.sh` to `/usr/local/bin` or any other place in your PATH.

### With Docker

- Build included Alpine-based dockerfile:

```
$ docker build -t bashtest .
```

## Usage

First, before defining your tests, you have to source the framework:

```
source bashtest.sh
```

After defining the tests, call the main bashtest function:

```
bashtest_runAllTests $*
```

### Understood arguments

- `xml` - output xUnit XML on the standard output
- `xmlfile=<filename>` - output xUnit XML to a file
- `test_<suite name>_<test name>` run individual test

Note that `xml` and `xmlfile=` are exclusive and if both, or multiple of one, is used, only the last
one is used.

Multiple `test_<suite name>_<test name>` arguments may be passed for triggering multiple individual
tests. If passed test is not valid, it is treated as no parameter, e.g. with no valid tests, all
tests are run, or the remaining tests are run if some tests from arguments are valid.

## Defining tests

The bashtest does lookup of functions complying to this format:

```
test_<suite name>_<test name> ()
{
    # ...do the test itself...
}
```

Please note that putting any other underscore in the function definition is not allowed, and neither
is omitting any of the suite name or test name.

Neither suites nor tests need not to be declared in any other way.

For test assertions, a `fail` alias is defined and understood by bashtest, with the example usage as
shown:

```
[[ $foo == bar ]] || fail
```

bashtest is capable of pretty-printing the failure with surrounding context for ease of use.

For each test suite, a setup and a teardown may be defined. Those are called before and
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

Setups and teardowns are optional. You may define none, one of, or both.

For ignoring of tests, you may append an arbitrary prefix to the function name, as that will
be ignored by the test discovery. For example:

```
ignore_test_<suite name>_<test name> ()
{
    # ...
}
```

See [example.sh](example.sh) for example use.


## (Optional) bash completion

A bash completion is available for convenience. Just hit this command:

```
$ source /path/to/this/repo/bashtest_completion.sh ./your_test_runner_command.sh
```

New tests are registered dynamically during completion trigger, so you only need to call this again
on a new bash session.

## Licence

This software is distributed under the GPL-3.0 license, see [COPYING](COPYING) for details.
