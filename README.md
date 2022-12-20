# p5-perl-metrics-maintainability

Analyze [maintainability index](https://learn.microsoft.com/en-us/visualstudio/code-quality/code-metrics-maintainability-index-range-and-meaning?view=vs-2022) of Perl files.

## Installation

```sh
$ perl ./Build.pl
$ ./Build install  #=> 'perlmi' script will be installed
```

## Usage

```shell
$ perlmi [OPTIONS] PATHS [PATHS...]
```

### Options

```
--sort    specify sort key
            mi, loc, cc, volume (default: mi)
--output  specify output type
            text, csv (defualt: text)
```

