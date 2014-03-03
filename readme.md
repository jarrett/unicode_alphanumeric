# Unicode Alphanumeric

This Ruby gem removes, replaces, transforms, or detects non-alphanumeric Unicode
characters in a string. Spaces optionally may be treated as alphanumeric.

## Basic usage synopsis

Detect non-alphanumerics:

    # ['+', '?', '¿']
    UnicodeAlphanumeric.scan('abc Ω + 123 ? ¿ Ñ def', :spaces => true)

Remove non-alphanumerics:

    # 'abc Ω  123   Ñ def'
    UnicodeAlphanumeric.filter('abc Ω + 123 ? ¿ Ñ def', :spaces => true)

Replace non-alphanumerics with a string:

    #'abc Ω _ 123 _ _ Ñ def'
    UnicodeAlphanumeric.replace('abc Ω + 123 ? ¿ Ñ def', '_', :spaces => true)

Replace non-alphanumerics with the return value of a block:

    # 'abc Ω ++ 123 ?? ¿¿ Ñ def'
    UnicodeAlphanumeric.map('abc Ω + 123 ? ¿ Ñ def', :spaces => true) do |char|
      char * 2
    end

If you want to, you can treat spaces as alphanumerics. By default, spaces are *not*
considered alphanumeric.

There are two ways to search for spaces. If you pass `spaces => true`, then a space is
defined as any Unicode code point which is a member of the "Separator, Space" category. Be
warned that this definition includes a lot more than the ASCII space character.

If you *only* want the ASCII space to be considered alphanumeric, you can pass in
`spaces => :ascii`.

## Implementation

This gem relies on the [Unicode gem](https://github.com/blackwinter/unicode) to analyze
non-ASCII characters. Specifically, it calls `Unicode.categories`, which returns the
category metadata from the Unicode Character Database. That metadata indicates whether the
code point is alphanumeric.

For ASCII characters, this gem relies on `gsub` with a regex. While the Unicode metadata
would achieve the same results, `gsub` is faster for ASCII.