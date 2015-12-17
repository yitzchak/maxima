@c -*- Mode: texinfo -*-
@menu
* Introduction to Command Line::
* Functions and Variables for Command Line::
* Functions and Variables for Display::
@end menu

@c -----------------------------------------------------------------------------
@node Introduction to Command Line, Functions and Variables for Command Line, Command Line, Command Line
@section Introduction to Command Line
@c -----------------------------------------------------------------------------

@c end concepts Command Line

@c -----------------------------------------------------------------------------
@node Functions and Variables for Command Line, Functions and Variables for Display, Introduction to Command Line, Command Line
@section Functions and Variables for Command Line
@c -----------------------------------------------------------------------------

@c -----------------------------------------------------------------------------
m4_setcat(Global variables)
@anchor{__}
@c @defvr {System variable} __
m4_defvr( {System variable}, <<<__>>>)
@ifinfo
@vrindex Current input expression
@end ifinfo

@code{__} is the input expression currently being evaluated.  That is, while an
input expression @var{expr} is being evaluated, @code{__} is @var{expr}.

@code{__} is assigned the input expression before the input is simplified or
evaluated.  However, the value of @code{__} is simplified (but not evaluated)
when it is displayed.

@code{__} is recognized by @mref{batch} and @mrefdot{load}  In a file processed
by @code{batch}, @code{__} has the same meaning as at the interactive prompt.
In a file processed by @code{load}, @code{__} is bound to the input expression
most recently entered at the interactive prompt or in a batch file; @code{__}
is not bound to the input expressions in the file being processed.  In
particular, when @code{load (@var{filename})} is called from the interactive
prompt, @code{__} is bound to @code{load (@var{filename})} while the file is
being processed.

See also @mref{_} and @mrefdot{%}

Examples:

@c ===beg===
@c print ("I was called as", __);
@c foo (__);
@c g (x) := (print ("Current input expression =", __), 0);
@c [aa : 1, bb : 2, cc : 3];
@c (aa + bb + cc)/(dd + ee + g(x));
@c ===end===
@example
@group
(%i1) print ("I was called as", __);
I was called as print(I was called as, __) 
(%o1)              print(I was called as, __)
@end group
@group
(%i2) foo (__);
(%o2)                     foo(foo(__))
@end group
@group
(%i3) g (x) := (print ("Current input expression =", __), 0);
(%o3) g(x) := (print("Current input expression =", __), 0)
@end group
@group
(%i4) [aa : 1, bb : 2, cc : 3];
(%o4)                       [1, 2, 3]
@end group
@group
(%i5) (aa + bb + cc)/(dd + ee + g(x));
                            cc + bb + aa
Current input expression = -------------- 
                           g(x) + ee + dd
                                6
(%o5)                        -------
                             ee + dd
@end group
@end example

@c @opencatbox
@c @category{Global variables}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
m4_setcat(Console interaction, Global variables)
@anchor{_}
@c @defvr {System variable} _
m4_defvr( {System variable}, <<<_>>>)
@ifinfo
@vrindex Previous input
@end ifinfo

@code{_} is the most recent input expression (e.g., @code{%i1}, @code{%i2},
@code{%i3}, @dots{}).

@code{_} is assigned the input expression before the input is simplified or
evaluated.  However, the value of @code{_} is simplified (but not evaluated)
when it is displayed.

@code{_} is recognized by @mref{batch} and @mrefdot{load}  In a file processed
by @code{batch}, @code{_} has the same meaning as at the interactive prompt.
In a file processed by @code{load}, @code{_} is bound to the input expression
most recently evaluated at the interactive prompt or in a batch file; @code{_}
is not bound to the input expressions in the file being processed.

See also @mref{__} and @mrefdot{%}

Examples:

@c ===beg===
@c 13 + 29;
@c :lisp $_
@c _;
@c sin (%pi/2);
@c :lisp $_
@c _;
@c a: 13$
@c b: 29$
@c a + b;
@c :lisp $_
@c _;
@c a + b;
@c ev (_);
@c ===end===
@example
@group
(%i1) 13 + 29;
(%o1)                          42
@end group
@group
(%i2) :lisp $_
((MPLUS) 13 29)
@end group
@group
(%i2) _;
(%o2)                          42
@end group
@group
(%i3) sin (%pi/2);
(%o3)                           1
@end group
@group
(%i4) :lisp $_
((%SIN) ((MQUOTIENT) $%PI 2))
@end group
@group
(%i4) _;
(%o4)                           1
@end group
(%i5) a: 13$
(%i6) b: 29$
@group
(%i7) a + b;
(%o7)                          42
@end group
@group
(%i8) :lisp $_
((MPLUS) $A $B)
@end group
@group
(%i8) _;
(%o8)                         b + a
@end group
@group
(%i9) a + b;
(%o9)                          42
@end group
@group
(%i10) ev (_);
(%o10)                         42
@end group
@end example

@c @opencatbox
@c @category{Console interaction}
@c @category{Global variables}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
@anchor{%}
@c @defvr {System variable} %
m4_defvr( {System variable}, <<<%>>>)
@ifinfo
@vrindex Previous output
@end ifinfo

@code{%} is the output expression (e.g., @code{%o1}, @code{%o2}, @code{%o3},
@dots{}) most recently computed by Maxima, whether or not it was displayed.

@code{%} is recognized by @mref{batch} and @mrefdot{load}  In a file processed
by @code{batch}, @code{%} has the same meaning as at the interactive prompt.
In a file processed by @code{load}, @code{%} is bound to the output expression
most recently computed at the interactive prompt or in a batch file; @code{%}
is not bound to output expressions in the file being processed.

See also @mrefcomma{_} @mrefcomma{%%} and @mrefdot{%th}

@c @opencatbox
@c @category{Console interaction}
@c @category{Global variables}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
m4_setcat(Global variables)
@anchor{%%}
@c @defvr {System variable} %%
m4_defvr( {System variable}, <<<%%>>>)
@ifinfo
@vrindex Previous result in compound expression
@end ifinfo

In compound statements, namely @mrefcomma{block} @mrefcomma{lambda} or
@code{(@var{s_1}, ..., @var{s_n})}, @code{%%} is the value of the previous
statement.

At the first statement in a compound statement, or outside of a compound
statement, @code{%%} is undefined.

@code{%%} is recognized by @mref{batch} and @mrefcomma{load} and it has the
same meaning as at the interactive prompt.

See also @mrefdot{%}

Examples:

The following two examples yield the same result.

@example
(%i1) block (integrate (x^5, x), ev (%%, x=2) - ev (%%, x=1));
                               21
(%o1)                          --
                               2
(%i2) block ([prev], prev: integrate (x^5, x),
               ev (prev, x=2) - ev (prev, x=1));
                               21
(%o2)                          --
                               2

@end example

A compound statement may comprise other compound statements.  Whether a
statement be simple or compound, @code{%%} is the value of the previous
statement.

@example
(%i3) block (block (a^n, %%*42), %%/6);
                                 n
(%o3)                         7 a
@end example

Within a compound statement, the value of @code{%%} may be inspected at a break
prompt, which is opened by executing the @mref{break} function.  For example,
entering @code{%%;} in the following example yields @code{42}.

@example
(%i4) block (a: 42, break ())$

Entering a Maxima break point. Type 'exit;' to resume.
_%%;
42
_
@end example

@c @opencatbox
@c @category{Global variables}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
m4_setcat(Console interaction)
@anchor{%th}
@c @deffn {Function} %th (@var{i})
m4_deffn( {Function}, %th, <<<(@var{i})>>>)
@ifinfo
@fnindex N'th previous output
@end ifinfo

The value of the @var{i}'th previous output expression.  That is, if the next
expression to be computed is the @var{n}'th output, @code{%th (@var{m})} is the
(@var{n} - @var{m})'th output.

@code{%th} is recognized by @mref{batch} and @mrefdot{load}  In a file processed
by @code{batch}, @code{%th} has the same meaning as at the interactive prompt.
In a file processed by @code{load}, @code{%th} refers to output expressions most
recently computed at the interactive prompt or in a batch file; @code{%th} does
not refer to output expressions in the file being processed.

See also @mref{%} and @mrefdot{%%}

Example:

@code{%th} is useful in @code{batch} files or for referring to a group of
output expressions.  This example sets @code{s} to the sum of the last five
output expressions.

@example
(%i1) 1;2;3;4;5;
(%o1)                           1
(%o2)                           2
(%o3)                           3
(%o4)                           4
(%o5)                           5
(%i6) block (s: 0, for i:1 thru 5 do s: s + %th(i), s);
(%o6)                          15
@end example

@c @opencatbox
@c @category{Console interaction}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
@anchor{?}
@deffn {Special symbol} ?
@ifinfo
@fnindex Fetch documentation
@end ifinfo

As prefix to a function or variable name, @code{?} signifies that the name is a
Lisp name, not a Maxima name.  For example, @code{?round} signifies the Lisp
function @code{ROUND}.  See @ref{Lisp and Maxima} for more on this point.

The notation @code{? word} (a question mark followed a word, separated by
whitespace) is equivalent to @code{describe("word")}.  The question mark must
occur at the beginning of an input line; otherwise it is not recognized as a
request for documentation.  See also @mrefdot{describe}

@opencatbox
@category{Help}
@category{Console interaction}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{??}
@deffn {Special symbol} ??
@ifinfo
@fnindex Fetch documentation (inexact search)
@end ifinfo

The notation @code{?? word} (@code{??} followed a word, separated by whitespace)
is equivalent to @code{describe("word", inexact)}.  The question mark must occur
at the beginning of an input line; otherwise it is not recognized as a request
for documentation.  See also @mrefdot{describe}

@opencatbox
@category{Help}
@category{Console interaction}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{$}
@deffn {Input terminator} $
@ifinfo
@fnindex Input terminator (without display)
@end ifinfo

The dollar sign @code{$} terminates an input expression,
and the most recent output @code{%} and an output label, e.g. @code{%o1},
are assigned the result, but the result is not displayed.

See also @code{;}.

Example:
@c ===beg===
@c 1 + 2 + 3 $
@c %;
@c %o1;
@c ===end===
@example
(%i1) 1 + 2 + 3 $
@group
(%i2) %;
(%o2)                           6
@end group
@group
(%i3) %o1;
(%o3)                           6
@end group
@end example
@end deffn

@c -----------------------------------------------------------------------------
@anchor{;}
@deffn {Input terminator} ;
@ifinfo
@fnindex Input terminator (with display)
@end ifinfo

The semicolon @code{;} terminates an input expression,
and the resulting output is displayed.

See also @code{$}.

Example:
@c ===beg===
@c 1 + 2 + 3;
@c ===end===
@example
@group
(%i1) 1 + 2 + 3;
(%o1)                           6
@end group
@end example
@end deffn

@c -----------------------------------------------------------------------------
m4_setcat(Display flags and variables)
@anchor{inchar}
@c @defvr {Option variable} inchar
m4_defvr( {Option variable}, inchar)
Default value: @code{%i}

@code{inchar} is the prefix of the labels of expressions entered by the user.
Maxima automatically constructs a label for each input expression by 
concatenating @code{inchar} and @mrefdot{linenum}

@code{inchar} may be assigned any string or symbol, not necessarily a single 
character.  Because Maxima internally takes into account only the first char of
the prefix, the prefixes @code{inchar}, @mrefcomma{outchar} and
@mref{linechar} should have a different first char.  Otherwise some commands
like @code{kill(inlabels)} do not work as expected.

See also @code{labels}.

Example:

@c ===beg===
@c inchar: "input";
@c expand((a+b)^3);
@c ===end===
@example
@group
(%i1) inchar: "input";
(%o1)                         input
@end group
@group
(input2) expand((a+b)^3);
                     3        2      2      3
(%o2)               b  + 3 a b  + 3 a  b + a
@end group
@end example

@c @opencatbox
@c @category{Display flags and variables}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
m4_setcat(Declarations and inferences, Global variables)
@anchor{infolists}
@c @defvr {System variable} infolists
m4_defvr( {System variable}, infolists)
Default value: @code{[]}

@code{infolists} is a list of the names of all of the information
lists in Maxima.  These are:

@table @code
@item labels
All bound @code{%i}, @code{%o}, and @code{%t} labels.
@item values
All bound atoms which are user variables, not Maxima options or switches,
created by @mref{:} or @mref{::} or functional binding.
@c WHAT IS INTENDED BY "FUNCTIONAL BINDING" HERE ??
@item functions
All user-defined functions, created by @mref{:=} or @mrefdot{define}
@item arrays
All arrays, @mref{hashed arrays} and @mref{memoizing functions}.
@item macros
All user-defined macro functions, created by @mrefdot{::=}
@item myoptions
All options ever reset by the user (whether or not they
are later reset to their default values).
@item rules
All user-defined pattern matching and simplification rules, created
by @mrefcomma{tellsimp} @mrefcomma{tellsimpafter} @mrefcomma{defmatch} or
@mrefdot{defrule}
@item aliases
All atoms which have a user-defined alias, created by the @mrefcomma{alias}@w{}
@mrefcomma{ordergreat} @mref{orderless} functions or by declaring the atom as a
@mref{noun} with @mrefdot{declare}
@item dependencies
All atoms which have functional dependencies, created by the
@mref{depends}, @mref{dependencies}, or @mref{gradef} functions.
@item gradefs
All functions which have user-defined derivatives, created by the
@mref{gradef} function.
@c UMM, WE REALLY NEED TO BE SPECIFIC -- WHAT DOES "ETC" CONTAIN HERE ??
@item props
All atoms which have any property other than those mentioned above, such as
properties established by @mref{atvalue} or @mref{matchdeclare}, etc.,
as well as properties established in the @mref{declare} function.
@item structures
@c Is also documented in Structures.texi. But it definitively is an infolist
@c so it has to be documented here, too.
All structs defined using @mrefdot{defstruct}
@item let_rule_packages
All user-defined @mref{let} rule packages
plus the special package @mrefdot{default_let_rule_package}
(@code{default_let_rule_package} is the name of the rule package used when
one is not explicitly set by the user.)
@end table

@c @opencatbox
@c @category{Declarations and inferences}
@c @category{Global variables}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c REVIEW FOR ACCURACY AND COMPLETENESS
@c THIS ITEM IS VERY IMPORTANT !!
@c NEEDS EXAMPLES

@c -----------------------------------------------------------------------------
@anchor{kill}
@deffn  {Function} kill @
@fname{kill} (@var{a_1}, @dots{}, @var{a_n}) @
@fname{kill} (labels) @
@fname{kill} (inlabels, outlabels, linelabels) @
@fname{kill} (@var{n}) @
@fname{kill} ([@var{m}, @var{n}]) @
@fname{kill} (values, functions, arrays, @dots{}) @
@fname{kill} (all) @
@fname{kill} (allbut (@var{a_1}, @dots{}, @var{a_n}))

Removes all bindings (value, function, array, or rule) from the arguments
@var{a_1}, @dots{}, @var{a_n}.  An argument @var{a_k} may be a symbol or a
single array element.  When @var{a_k} is a single array element, @code{kill}
unbinds that element without affecting any other elements of the array.

Several special arguments are recognized.  Different kinds of arguments
may be combined, e.g., @code{kill (inlabels, functions, allbut (foo, bar))}.

@code{kill (labels)} unbinds all input, output, and intermediate expression
labels created so far.  @code{kill (inlabels)} unbinds only input labels which
begin with the current value of @mrefdot{inchar}  Likewise,
@code{kill (outlabels)} unbinds only output labels which begin with the current
value of @mrefcomma{outchar} and @code{kill (linelabels)} unbinds only
intermediate expression labels which begin with the current value of
@mrefdot{linechar}

@code{kill (@var{n})}, where @var{n} is an integer,
unbinds the @var{n} most recent input and output labels.

@code{kill ([@var{m}, @var{n}])} unbinds input and output labels @var{m} through
@var{n}.

@code{kill (@var{infolist})}, where @var{infolist} is any item in
@code{infolists} (such as @mrefcomma{values} @mrefcomma{functions} or
@mref{arrays}) unbinds all items in @var{infolist}.
See also @mrefdot{infolists}

@code{kill (all)} unbinds all items on all infolists.  @code{kill (all)} does
not reset global variables to their default values; see @mref{reset} on this
point.

@code{kill (allbut (@var{a_1}, ..., @var{a_n}))} unbinds all items on all
infolists except for @var{a_1}, @dots{}, @var{a_n}.
@code{kill (allbut (@var{infolist}))} unbinds all items except for the ones on
@var{infolist}, where @var{infolist} is @mrefcomma{values}@w{}
@mrefcomma{functions} @mrefcomma{arrays} etc.

The memory taken up by a bound property is not released until all symbols are
unbound from it.  In particular, to release the memory taken up by the value of
a symbol, one unbinds the output label which shows the bound value, as well as
unbinding the symbol itself.

@code{kill} quotes its arguments.  The quote-quote operator @code{'@w{}'}
defeats quotation.

@code{kill (@var{symbol})} unbinds all properties of @var{symbol}.  In contrast,
the functions @mrefcomma{remvalue} @mrefcomma{remfunction}@w{}
@mrefcomma{remarray} and @mref{remrule} unbind a specific property.
Note that facts declared by @mref{assume} don't require a symbol they apply to,
therefore aren't stored as properties of symbols and therefore aren't affected
by @code{kill}.

@code{kill} always returns @code{done}, even if an argument has no binding.

@opencatbox
@category{Evaluation}
@category{Console interaction}
@category{Session management}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
m4_setcat(Display functions, Console interaction)
@anchor{labels}
@c @deffn  {Function} labels (@var{symbol})
m4_deffn(  {Function}, labels, <<<(@var{symbol})>>>)

Returns the list of input, output, or intermediate expression labels which begin
with @var{symbol}.  Typically @var{symbol} is the value of
@mrefcomma{inchar} @mrefcomma{outchar} or @mrefdot{linechar}
If no labels begin with @var{symbol}, @code{labels} returns an empty list.

By default, Maxima displays the result of each user input expression, giving the
result an output label.  The output display is suppressed by terminating the
input with @code{$} (dollar sign) instead of @code{;} (semicolon).  An output
label is constructed and bound to the result, but not displayed, and the label
may be referenced in the same way as displayed output labels.  See also
@mrefcomma{%} @mrefcomma{%%} and @mrefdot{%th}

Intermediate expression labels can be generated by some functions.  The option
variable @mref{programmode} controls whether @mref{solve} and some other
functions generate intermediate expression labels instead of returning a list of
expressions.  Some other functions, such as @mrefcomma{ldisplay} always generate
intermediate expression labels.

See also @mrefcomma{inchar} @mrefcomma{outchar} @mrefcomma{linechar} and
@mrefdot{infolists}

@c @opencatbox
@c @category{Display functions}
@c @category{Console interaction}
@c @closecatbox
@c @end deffn
m4_end_deffn()

m4_setcat(Display flags and variables, Console interaction)
@defvr {System variable} labels

The variable @code{labels} is the list of input, output, and intermediate
expression labels, including all previous labels if @code{inchar},
@code{outchar}, or @code{linechar} were redefined.

@opencatbox
@category{Display flags and variables}
@category{Console interaction}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
m4_setcat(Display flags and variables)
@anchor{linechar}
@c @defvr {Option variable} linechar
m4_defvr( {Option variable}, linechar)
Default value: @code{%t}

@code{linechar} is the prefix of the labels of intermediate expressions 
generated by Maxima.  Maxima constructs a label for each intermediate expression 
(if displayed) by concatenating @code{linechar} and @mrefdot{linenum}

@code{linechar} may be assigned any string or symbol, not necessarily a single 
character.  Because Maxima internally takes into account only the first char of
the prefix, the prefixes @mrefcomma{inchar} @mrefcomma{outchar} and
@code{linechar} should have a different first char.  Otherwise some commands
like @code{kill(inlabels)} do not work as expected.

Intermediate expressions might or might not be displayed.
See @mref{programmode} and @mrefdot{labels}

@c @opencatbox
@c @category{Display flags and variables}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c EXPAND; SHOW WHAT HAPPENS WHEN linenum IS ASSIGNED A VALUE

@c -----------------------------------------------------------------------------
m4_setcat(Display flags and variables, Console interaction)
@anchor{linenum}
@c @defvr {System variable} linenum
m4_defvr( {System variable}, linenum)

The line number of the current pair of input and output expressions.

@c @opencatbox
@c @category{Display flags and variables}
@c @category{Console interaction}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c NEEDS WORK

@c -----------------------------------------------------------------------------
m4_setcat(Global variables, Session management, Console interaction)
@anchor{myoptions}
@c @defvr {System variable} myoptions
m4_defvr( {System variable}, myoptions)
Default value: @code{[]}

@code{myoptions} is the list of all options ever reset by the user,
whether or not they get reset to their default value.

@c @opencatbox
@c @category{Global variables}
@c @category{Session management}
@c @category{Console interaction}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
m4_setcat(Global flags, Session management)
@anchor{nolabels}
@c @defvr {Option variable} nolabels
m4_defvr( {Option variable}, nolabels)
Default value: @code{false}

When @code{nolabels} is @code{true}, input and output result labels (@code{%i}
and @code{%o}, respectively) are displayed, but the labels are not bound to
results, and the labels are not appended to the @mref{labels} list.  Since
labels are not bound to results, garbage collection can recover the memory taken
up by the results.

Otherwise input and output result labels are bound to results, and the labels
are appended to the @code{labels} list.

Intermediate expression labels (@code{%t}) are not affected by @code{nolabels};
whether @code{nolabels} is @code{true} or @code{false}, intermediate expression
labels are bound and appended to the @code{labels} list.

See also @mrefcomma{batch} @mrefcomma{load} and @mrefdot{labels}

@c @opencatbox
@c @category{Global flags}
@c @category{Session management}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c NEEDS WORK

@c -----------------------------------------------------------------------------
m4_setcat(Global flags, Session management, Console interaction)
@anchor{optionset}
@c @defvr {Option variable} optionset
m4_defvr( {Option variable}, optionset)
Default value: @code{false}

When @code{optionset} is @code{true}, Maxima prints out a message whenever a
Maxima option is reset.  This is useful if the user is doubtful of the spelling
of some option and wants to make sure that the variable he assigned a value to
was truly an option variable.

Example:

@example
(%i1) optionset:true;
assignment: assigning to option optionset
(%o1)                         true
(%i2) gamma_expand:true;
assignment: assigning to option gamma_expand
(%o2)                         true
@end example

@c @opencatbox
@c @category{Global flags}
@c @category{Session management}
@c @category{Console interaction}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
m4_setcat(Display flags and variables)
@need 800
@anchor{outchar}
@c @defvr {Option variable} outchar
m4_defvr( {Option variable}, outchar)
Default value: @code{%o}

@code{outchar} is the prefix of the labels of expressions computed by Maxima.
Maxima automatically constructs a label for each computed expression by 
concatenating @code{outchar} and @mrefdot{linenum}

@code{outchar} may be assigned any string or symbol, not necessarily a single 
character.  Because Maxima internally takes into account only the first char of
the prefix, the prefixes @mrefcomma{inchar} @code{outchar} and
@mref{linechar} should have a different first char.  Otherwise some commands
like @code{kill(inlabels)} do not work as expected.

See also @mref{labels}.

Example:

@c ===beg===
@c outchar: "output";
@c expand((a+b)^3);
@c ===end===
@example
@group
(%i1) outchar: "output";
(output1)                    output
@end group
@group
(%i2) expand((a+b)^3);
                     3        2      2      3
(output2)           b  + 3 a b  + 3 a  b + a
@end group
@end example

@c @opencatbox
@c @category{Display flags and variables}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
@anchor{playback}
@deffn {Function} playback @
@fname{playback} () @
@fname{playback} (@var{n}) @
@fname{playback} ([@var{m}, @var{n}]) @
@fname{playback} ([@var{m}]) @
@fname{playback} (input) @
@fname{playback} (slow) @
@fname{playback} (time) @
@fname{playback} (grind)

Displays input, output, and intermediate expressions, without recomputing them.
@code{playback} only displays the expressions bound to labels; any other output
(such as text printed by @mref{print} or @mrefcomma{describe} or error messages)
is not displayed.  See also @mrefdot{labels}

@code{playback} quotes its arguments.  The quote-quote operator @code{'@w{}'}
defeats quotation.  @code{playback} always returns @code{done}.

@code{playback ()} (with no arguments) displays all input, output, and
intermediate expressions generated so far.  An output expression is displayed
even if it was suppressed by the @code{$} terminator when it was originally
computed.

@code{playback (@var{n})} displays the most recent @var{n} expressions.
Each input, output, and intermediate expression counts as one.

@code{playback ([@var{m}, @var{n}])} displays input, output, and intermediate
expressions with numbers from @var{m} through @var{n}, inclusive.

@code{playback ([@var{m}])} is equivalent to
@code{playback ([@var{m}, @var{m}])}; this usually prints one pair of input and
output expressions.

@code{playback (input)} displays all input expressions generated so far.

@code{playback (slow)} pauses between expressions and waits for the user to
press @code{enter}.  This behavior is similar to @mrefdot{demo}
@c WHAT DOES THE FOLLOWING MEAN ???
@code{playback (slow)} is useful in conjunction with @code{save} or
@mref{stringout} when creating a secondary-storage file in order to pick out
useful expressions.

@code{playback (time)} displays the computation time for each expression.
@c DON'T BOTHER TO MENTION OBSOLETE OPTIONS !!!
@c The arguments @code{gctime} and @code{totaltime} have the same effect as @code{time}.

@code{playback (grind)} displays input expressions in the same format as the
@code{grind} function.  Output expressions are not affected by the @code{grind}
option.  See @mrefdot{grind}

Arguments may be combined, e.g., @code{playback ([5, 10], grind, time, slow)}.
@c APPEARS TO BE input INTERSECT (UNION OF ALL OTHER ARGUMENTS). CORRECT ???

@opencatbox
@category{Display functions}
@category{Console interaction}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
m4_setcat(Global variables, Console interaction)
@need 800
@anchor{prompt}
@c @defvr {Option variable} prompt
m4_defvr( {Option variable}, prompt)
Default value: @code{_}

@code{prompt} is the prompt symbol of the @mref{demo} function,
@code{playback (slow)} mode, and the Maxima break loop (as invoked by
@mref{break}).

@c @opencatbox
@c @category{Global variables}
@c @category{Console interaction}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
m4_setcat(Console interaction)
@anchor{quit}
@c @deffn {Function} quit ()
m4_deffn( {Function}, quit, <<<()>>>)

Terminates the Maxima session.  Note that the function must be invoked as
@code{quit();} or @code{quit()$}, not @code{quit} by itself.

To stop a lengthy computation, type @code{control-C}.  The default action is to
return to the Maxima prompt.  If @code{*debugger-hook*} is @code{nil},
@code{control-C} opens the Lisp debugger.  See also @ref{Debugging}.

@c @opencatbox
@c @category{Console interaction}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
@anchor{read}
@c @deffn {Function} read (@var{expr_1}, @dots{}, @var{expr_n})
m4_deffn( {Function}, read, <<<(@var{expr_1}, @dots{}, @var{expr_n})>>>)

Prints @var{expr_1}, @dots{}, @var{expr_n}, then reads one expression from the
console and returns the evaluated expression.  The expression is terminated with
a semicolon @code{;} or dollar sign @code{$}.

See also @mref{readonly}

Example:

@example
(%i1) foo: 42$ 
(%i2) foo: read ("foo is", foo, " -- enter new value.")$
foo is 42  -- enter new value. 
(a+b)^3;
(%i3) foo;
                                     3
(%o3)                         (b + a)
@end example

@c @opencatbox
@c @category{Console interaction}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
@anchor{readonly}
@c @deffn {Function} readonly (@var{expr_1}, @dots{}, @var{expr_n})
m4_deffn( {Function}, readonly, <<<(@var{expr_1}, @dots{}, @var{expr_n})>>>)

Prints @var{expr_1}, @dots{}, @var{expr_n}, then reads one expression from the
console and returns the expression (without evaluation).  The expression is
terminated with a @code{;} (semicolon) or @code{$} (dollar sign).

See also @mrefdot{read}

Examples:

@example
(%i1) aa: 7$
(%i2) foo: readonly ("Enter an expression:");
Enter an expression: 
2^aa;
                                  aa
(%o2)                            2
(%i3) foo: read ("Enter an expression:");
Enter an expression: 
2^aa;
(%o3)                            128
@end example

@c @opencatbox
@c @category{Console interaction}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_setcat(Session management)
@anchor{reset}
@c @deffn {Function} reset ()
m4_deffn( {Function}, reset, <<<()>>>)

Resets many global variables and options, and some other variables, to their
default values.

@code{reset} processes the variables on the Lisp list
@code{*variable-initial-values*}.  The Lisp macro @code{defmvar} puts variables
on this list (among other actions).  Many, but not all, global variables and
options are defined by @code{defmvar}, and some variables defined by
@code{defmvar} are not global variables or options.

@c @opencatbox
@c @category{Session management}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_setcat(Display flags and variables, Debugging)
@anchor{showtime}
@c @defvr {Option variable} showtime
m4_defvr( {Option variable}, showtime)
Default value: @code{false}

When @code{showtime} is @code{true}, the computation time and elapsed time is
printed with each output expression.

The computation time is always recorded, so @mref{time} and @mref{playback} can
display the computation time even when @code{showtime} is @code{false}.

See also @mrefdot{timer}

@c @opencatbox
@c @category{Display flags and variables}
@c @category{Debugging}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
m4_setcat(Console interaction)
@anchor{to_lisp}
@c @deffn {Function} to_lisp ()
m4_deffn( {Function}, to_lisp, <<<()>>>)

Enters the Lisp system under Maxima.  @code{(to-maxima)} returns to Maxima.

Example:

Define a function and enter the Lisp system under Maxima.  The definition is
inspected on the property list, then the function definition is extracted,
factored and stored in the variable @code{$result}.  The variable can be used in Maxima
after returning to Maxima.

@example
(%i1) f(x):=x^2+x;
                                  2
(%o1)                    f(x) := x  + x
(%i2) to_lisp();
Type (to-maxima) to restart, ($quit) to quit Maxima.
MAXIMA> (symbol-plist '$f)
(MPROPS (NIL MEXPR ((LAMBDA) ((MLIST) $X) 
                             ((MPLUS) ((MEXPT) $X 2) $X))))
MAXIMA> (setq $result ($factor (caddr (mget '$f 'mexpr))))
((MTIMES SIMP FACTORED) $X ((MPLUS SIMP IRREDUCIBLE) 1 $X))
MAXIMA> (to-maxima)
Returning to Maxima
(%o2)                         true
(%i3) result;
(%o3)                       x (x + 1)
@end example

@c @opencatbox
@c @category{Console interaction}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_setcat(Evaluation, Global variables)
@anchor{values}
@c @defvr {System variable} values
m4_defvr( {System variable}, values)
Initial value: @code{[]}

@code{values} is a list of all bound user variables (not Maxima options or
switches).  The list comprises symbols bound by @mrefcomma{:} or @mrefdot{::}

If the value of a variable is removed with the commands @code{kill}, 
@mrefcomma{remove} or @mref{remvalue} the variable is deleted from
@code{values}.

See @mref{functions} for a list of user defined functions.

Examples:

First, @code{values} shows the symbols @code{a}, @code{b}, and @code{c}, but 
not @code{d}, it is not bound to a value, and not the user function @code{f}.
The values are removed from the variables.  @code{values} is the empty list.

@c ===beg===
@c [a:99, b:: a-90, c:a-b, d, f(x):=x^2];
@c values;
@c [kill(a), remove(b,value), remvalue(c)];
@c values;
@c ===end===
@example
@group
(%i1) [a:99, b:: a-90, c:a-b, d, f(x):=x^2];
                                           2
(%o1)              [99, 9, 90, d, f(x) := x ]
@end group
@group
(%i2) values;
(%o2)                       [a, b, c]
@end group
@group
(%i3) [kill(a), remove(b,value), remvalue(c)];
(%o3)                   [done, done, [c]]
@end group
@group
(%i4) values;
(%o4)                          []
@end group
@end example

@c @opencatbox
@c @category{Evaluation}
@c @category{Global variables}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
@node Functions and Variables for Display, , Functions and Variables for Command Line, Command Line
@section Functions and Variables for Display
@c -----------------------------------------------------------------------------

@c -----------------------------------------------------------------------------
m4_setcat(Exponential and logarithm functions, Display flags and variables)
@anchor{%edispflag}
@c @defvr {Option variable} %edispflag
m4_defvr( {Option variable}, %edispflag)
Default value: @code{false}

When @code{%edispflag} is @code{true}, Maxima displays @code{%e} to a negative
exponent as a quotient.  For example, @code{%e^-x} is displayed as
@code{1/%e^x}.  See also @mrefdot{exptdispflag}

Example:

@c ===beg===
@c %e^-10;
@c %edispflag:true$
@c %e^-10;
@c ===end===
@example
@group
(%i1) %e^-10;
                               - 10
(%o1)                        %e
@end group
(%i2) %edispflag:true$
@group
(%i3) %e^-10;
                               1
(%o3)                         ----
                                10
                              %e
@end group
@end example

@c @opencatbox
@c @category{Exponential and logarithm functions}
@c @category{Display flags and variables}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
m4_setcat(Display flags and variables)
@anchor{absboxchar}
@c @defvr {Option variable} absboxchar
m4_defvr( {Option variable}, absboxchar)
Default value: @code{!}

@code{absboxchar} is the character used to draw absolute value
signs around expressions which are more than one line tall.

Example:

@example
(%i1) abs((x^3+1));
                            ! 3    !
(%o1)                       !x  + 1!
@end example

@c @opencatbox
@c @category{Display flags and variables}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c AFTER REVIEWING src/displa.lisp, IT LOOKS LIKE THIS VARIABLE HAS NO EFFECT
@c CUT IT ON THE NEXT PASS
@c @defvar cursordisp
@c Default value: @code{true}
@c 
@c When @code{cursordisp} is @code{true}, expressions are drawn by
@c the displayer in logical sequence.  This only works with a console
@c which can do cursor movement.  If @code{false}, expressions are
@c printed line by line.
@c 
@c @code{cursordisp} is always @code{false} when a @code{writefile} is in
@c effect.
@c 
@c @end defvar

@c -----------------------------------------------------------------------------
m4_setcat(Display functions)
@anchor{disp}
@c @deffn {Function} disp (@var{expr_1}, @var{expr_2}, @dots{})
m4_deffn( {Function}, disp, <<<(@var{expr_1}, @var{expr_2}, @dots{})>>>)

is like @mref{display} but only the value of the arguments are displayed rather
than equations.  This is useful for complicated arguments which don't have names 
or where only the value of the argument is of interest and not the name.

See also @mref{ldisp} and @mrefdot{print}

Example:

@c ===beg===
@c b[1,2]:x-x^2$
@c x:123$
@c disp(x, b[1,2], sin(1.0));
@c ===end===
@example
(%i1) b[1,2]:x-x^2$
(%i2) x:123$
@group
(%i3) disp(x, b[1,2], sin(1.0));
                               123

                                  2
                             x - x

                       0.8414709848078965

(%o3)                         done
@end group
@end example

@c @opencatbox
@c @category{Display functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
@anchor{display}
@c @deffn {Function} display (@var{expr_1}, @var{expr_2}, @dots{})
m4_deffn( {Function}, display, <<<(@var{expr_1}, @var{expr_2}, @dots{})>>>)

Displays equations whose left side is @var{expr_i} unevaluated, and whose right
side is the value of the expression centered on the line.  This function is 
useful in blocks and @mref{for} statements in order to have intermediate results
displayed.  The arguments to @code{display} are usually atoms, subscripted 
variables, or function calls.

See also @mrefcomma{ldisplay} @mrefcomma{disp} and @mrefdot{ldisp}

Example:

@c ===beg===
@c b[1,2]:x-x^2$
@c x:123$
@c display(x, b[1,2], sin(1.0));
@c ===end===
@example
(%i1) b[1,2]:x-x^2$
(%i2) x:123$
(%i3) display(x, b[1,2], sin(1.0));
                             x = 123

                                      2
                         b     = x - x
                          1, 2

                  sin(1.0) = 0.8414709848078965

(%o3)                         done
@end example

@opencatbox
@category{Display functions}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
m4_setcat(Display flags and variables)
@anchor{display2d}
@c @defvr {Option variable} display2d
m4_defvr( {Option variable}, display2d)
Default value: @code{true}

When @code{display2d} is @code{true},
the console display is an attempt to present mathematical expressions
as they might appear in books and articles,
using only letters, numbers, and some punctuation characters.
This display is sometimes called the "pretty printer" display.

When @code{display2d} is @code{false},
the console display is a 1-dimensional or linear form
which is the same as the output produced by @code{grind}.

When @code{display2d} is @code{false},
the value of @code{stringdisp} is ignored,
and strings are always displayed with quote marks.

See also @mref{leftjust} to switch between a left justified and a centered
display of equations.

Example:

@c ===beg===
@c x/(x^2+1);
@c display2d:false$
@c x/(x^2+1);
@c ===end===
@example
@group
(%i1) x/(x^2+1);
                               x
(%o1)                        ------
                              2
                             x  + 1
@end group
(%i2) display2d:false$
@group
(%i3) x/(x^2+1);
(%o3) x/(x^2+1)
@end group
@end example

@c @opencatbox
@c @category{Display flags and variables}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
@anchor{display_format_internal}
@c @defvr {Option variable} display_format_internal
m4_defvr( {Option variable}, display_format_internal)
Default value: @code{false}

When @code{display_format_internal} is @code{true}, expressions are displayed
without being transformed in ways that hide the internal mathematical
representation.  The display then corresponds to what @mref{inpart} returns
rather than @mrefdot{part}

Examples:

@example
User     part       inpart
a-b;      a - b     a + (- 1) b

           a            - 1
a/b;       -         a b
           b
                       1/2
sqrt(x);   sqrt(x)    x

          4 X        4
X*4/3;    ---        - X
           3         3
@end example

@opencatbox
@category{Display flags and variables}
@closecatbox
@end defvr

@c IS THIS FUNCTION STILL USEFUL ???
@c REPHRASE, NEEDS EXAMPLES

@c -----------------------------------------------------------------------------
m4_setcat(Display functions)
@anchor{dispterms}
@c @deffn {Function} dispterms (@var{expr})
m4_deffn( {Function}, dispterms, <<<(@var{expr})>>>)

Displays @var{expr} in parts one below the other.  That is, first the operator
of @var{expr} is displayed, then each term in a sum, or factor in a product, or
part of a more general expression is displayed separately.  This is useful if
@var{expr} is too large to be otherwise displayed.  For example if @code{P1},
@code{P2}, @dots{}  are very large expressions then the display program may run
out of storage space in trying to display @code{P1 + P2 + ...}  all at once.
However, @code{dispterms (P1 + P2 + ...)} displays @code{P1}, then below it
@code{P2}, etc.  When not using @code{dispterms}, if an exponential expression
is too wide to be displayed as @code{A^B} it appears as @code{expt (A, B)} (or
as @code{ncexpt (A, B)} in the case of @code{A^^B}).

Example:

@example
(%i1) dispterms(2*a*sin(x)+%e^x);

+

2 a sin(x)

  x
%e

(%o1)                         done
@end example

@c @opencatbox
@c @category{Display functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_setcat()
@anchor{expt}
@anchor{ncexpt}
@c @deffn  {Special symbol} expt (@var{a}, @var{b})
m4_deffn(  {Special symbol}, expt, <<<(@var{a}, @var{b})>>>)
@c @deffnx {Special symbol} ncexpt (@var{a}, @var{b})
m4_deffnx({Special symbol}, ncexpt, <<<(@var{a}, @var{b})>>>)
If an exponential expression is too wide to be displayed as
@code{@var{a}^@var{b}} it appears as @code{expt (@var{a}, @var{b})} (or as
@code{ncexpt (@var{a}, @var{b})} in the case of @code{@var{a}^^@var{b}}).

@c THIS SEEMS LIKE A BUG TO ME.  expt, ncexpt SHOULD BE RECOGNIZED SINCE MAXIMA
@c ITSELF PRINTS THEM SOMETIMES.  THESE SHOULD JUST SIMPLIFY TO ^ AND ^^,
@c RESPECTIVELY.
@code{expt} and @code{ncexpt} are not recognized in input.
@end deffn

@c -----------------------------------------------------------------------------
m4_setcat(Expressions, Display flags and variables)
@anchor{exptdispflag}
@c @defvr {Option variable} exptdispflag
m4_defvr( {Option variable}, exptdispflag)
Default value: @code{true}

When @code{exptdispflag} is @code{true}, Maxima displays expressions
with negative exponents using quotients.  See also @mrefdot{%edispflag}

Example:

@example
(%i1) exptdispflag:true;
(%o1)                         true
(%i2) 10^-x;
                                1
(%o2)                          ---
                                 x
                               10
(%i3) exptdispflag:false;
(%o3)                         false
(%i4) 10^-x;
                                - x
(%o4)                         10
@end example

@c @opencatbox
@c @category{Expressions}
@c @category{Display flags and variables}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
m4_setcat(Display functions)
@anchor{grind}
@c @deffn  {Function} grind (@var{expr})
m4_deffn(  {Function}, grind, <<<(@var{expr})>>>)

The function @code{grind} prints @var{expr} to the console in a form suitable
for input to Maxima.  @code{grind} always returns @code{done}.

When @var{expr} is the name of a function or macro, @code{grind} prints the
function or macro definition instead of just the name.

See also @mrefcomma{string} which returns a string instead of printing its
output.  @code{grind} attempts to print the expression in a manner which makes
it slightly easier to read than the output of @code{string}.

@code{grind} evaluates its argument.

Examples:

@c ===beg===
@c aa + 1729;
@c grind (%);
@c [aa, 1729, aa + 1729];
@c grind (%);
@c matrix ([aa, 17], [29, bb]);
@c grind (%);
@c set (aa, 17, 29, bb);
@c grind (%);
@c exp (aa / (bb + 17)^29);
@c grind (%);
@c expr: expand ((aa + bb)^10);
@c grind (expr);
@c string (expr);
@c cholesky (A):= block ([n : length (A), L : copymatrix (A),
@c   p : makelist (0, i, 1, length (A))], 
@c   for i thru n do for j : i thru n do
@c   (x : L[i, j], x : x - sum (L[j, k] * L[i, k], k, 1, i - 1), 
@c   if i = j then p[i] : 1 / sqrt(x) else L[j, i] : x * p[i]), 
@c   for i thru n do L[i, i] : 1 / p[i],
@c   for i thru n do for j : i + 1 thru n do L[i, j] : 0, L)$
@c grind (cholesky);
@c string (fundef (cholesky));
@c ===end===
@example
@group
(%i1) aa + 1729;
(%o1)                       aa + 1729
@end group
@group
(%i2) grind (%);
aa+1729$
(%o2)                         done
@end group
@group
(%i3) [aa, 1729, aa + 1729];
(%o3)                 [aa, 1729, aa + 1729]
@end group
@group
(%i4) grind (%);
[aa,1729,aa+1729]$
(%o4)                         done
@end group
@group
(%i5) matrix ([aa, 17], [29, bb]);
                           [ aa  17 ]
(%o5)                      [        ]
                           [ 29  bb ]
@end group
@group
(%i6) grind (%);
matrix([aa,17],[29,bb])$
(%o6)                         done
@end group
@group
(%i7) set (aa, 17, 29, bb);
(%o7)                   @{17, 29, aa, bb@}
@end group
@group
(%i8) grind (%);
@{17,29,aa,bb@}$
(%o8)                         done
@end group
@group
(%i9) exp (aa / (bb + 17)^29);
                                aa
                            -----------
                                     29
                            (bb + 17)
(%o9)                     %e
@end group
@group
(%i10) grind (%);
%e^(aa/(bb+17)^29)$
(%o10)                        done
@end group
@group
(%i11) expr: expand ((aa + bb)^10);
         10           9        2   8         3   7         4   6
(%o11) bb   + 10 aa bb  + 45 aa  bb  + 120 aa  bb  + 210 aa  bb
         5   5         6   4         7   3        8   2
 + 252 aa  bb  + 210 aa  bb  + 120 aa  bb  + 45 aa  bb
        9        10
 + 10 aa  bb + aa
@end group
@group
(%i12) grind (expr);
bb^10+10*aa*bb^9+45*aa^2*bb^8+120*aa^3*bb^7+210*aa^4*bb^6
     +252*aa^5*bb^5+210*aa^6*bb^4+120*aa^7*bb^3+45*aa^8*bb^2
     +10*aa^9*bb+aa^10$
(%o12)                        done
@end group
@group
(%i13) string (expr);
(%o13) bb^10+10*aa*bb^9+45*aa^2*bb^8+120*aa^3*bb^7+210*aa^4*bb^6\
+252*aa^5*bb^5+210*aa^6*bb^4+120*aa^7*bb^3+45*aa^8*bb^2+10*aa^9*\
bb+aa^10
@end group
@group
(%i14) cholesky (A):= block ([n : length (A), L : copymatrix (A),
  p : makelist (0, i, 1, length (A))],
  for i thru n do for j : i thru n do
  (x : L[i, j], x : x - sum (L[j, k] * L[i, k], k, 1, i - 1),
  if i = j then p[i] : 1 / sqrt(x) else L[j, i] : x * p[i]),
  for i thru n do L[i, i] : 1 / p[i],
  for i thru n do for j : i + 1 thru n do L[i, j] : 0, L)$
define: warning: redefining the built-in function cholesky
@end group
(%i15) grind (cholesky);
cholesky(A):=block(
         [n:length(A),L:copymatrix(A),
          p:makelist(0,i,1,length(A))],
         for i thru n do
             (for j from i thru n do
                  (x:L[i,j],x:x-sum(L[j,k]*L[i,k],k,1,i-1),
                   if i = j then p[i]:1/sqrt(x)
                       else L[j,i]:x*p[i])),
         for i thru n do L[i,i]:1/p[i],
         for i thru n do (for j from i+1 thru n do L[i,j]:0),L)$
(%o15)                        done
@group
(%i16) string (fundef (cholesky));
(%o16) cholesky(A):=block([n:length(A),L:copymatrix(A),p:makelis\
t(0,i,1,length(A))],for i thru n do (for j from i thru n do (x:L\
[i,j],x:x-sum(L[j,k]*L[i,k],k,1,i-1),if i = j then p[i]:1/sqrt(x\
) else L[j,i]:x*p[i])),for i thru n do L[i,i]:1/p[i],for i thru \
n do (for j from i+1 thru n do L[i,j]:0),L)
@end group
@end example

@c @opencatbox
@c @category{Display functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

m4_setcat(Display flags and variables)
@c @defvr {Option variable} grind
m4_defvr( {Option variable}, grind)

When the variable @code{grind} is @code{true}, the output of @code{string} and
@mref{stringout} has the same format as that of @code{grind}; otherwise no
attempt is made to specially format the output of those functions.  The default
value of the variable @code{grind} is @code{false}.

@code{grind} can also be specified as an argument of @mrefdot{playback}  When
@code{grind} is present, @code{playback} prints input expressions in the same
format as the @code{grind} function.  Otherwise, no attempt is made to specially
format input expressions.

@c @opencatbox
@c @category{Display flags and variables}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
m4_setcat(Console interaction)
@anchor{ibase}
@c @defvr {Option variable} ibase
m4_defvr( {Option variable}, ibase)
Default value: @code{10}

@code{ibase} is the base for integers read by Maxima.

@code{ibase} may be assigned any integer between 2 and 36 (decimal), inclusive.
When @code{ibase} is greater than 10,
the numerals comprise the decimal numerals 0 through 9
plus letters of the alphabet @code{A}, @code{B}, @code{C}, @dots{},
as needed to make @code{ibase} digits in all.
Letters are interpreted as digits only if the first digit is 0 through 9.

Uppercase and lowercase letters are not distinguished.
The numerals for base 36, the largest acceptable base,
comprise 0 through 9 and @code{A} through @code{Z}.

Whatever the value of @code{ibase},
when an integer is terminated by a decimal point,
it is interpreted in base 10.

See also @mrefdot{obase}

Examples:

@code{ibase} less than 10 (for example binary numbers).

@c ===beg===
@c ibase : 2 $
@c obase;
@c 1111111111111111;
@c ===end===
@example
(%i1) ibase : 2 $
@group
(%i2) obase;
(%o2)                          10
@end group
@group
(%i3) 1111111111111111;
(%o3)                         65535
@end group
@end example

@code{ibase} greater than 10.
Letters are interpreted as digits only if the first digit is 0
through 9 which means that hexadecimal numbers might need to
be prepended by a 0.

@c ===beg===
@c ibase : 16 $
@c obase;
@c 1000;
@c abcd;
@c symbolp (abcd);
@c 0abcd;
@c symbolp (0abcd);
@c ===end===
@example
(%i1) ibase : 16 $
@group
(%i2) obase;
(%o2)                          10
@end group
@group
(%i3) 1000;
(%o3)                         4096
@end group
@group
(%i4) abcd;
(%o4)                         abcd
@end group
@group
(%i5) symbolp (abcd);
(%o5)                         true
@end group
@group
(%i6) 0abcd;
(%o6)                         43981
@end group
@group
(%i7) symbolp (0abcd);
(%o7)                         false
@end group
@end example

When an integer is terminated by a decimal point,
it is interpreted in base 10.

@c ===beg===
@c ibase : 36 $
@c obase;
@c 1234;
@c 1234.;
@c ===end===
@example
(%i1) ibase : 36 $
@group
(%i2) obase;
(%o2)                          10
@end group
@group
(%i3) 1234;
(%o3)                         49360
@end group
@group
(%i4) 1234.;
(%o4)                         1234
@end group
@end example

@c @opencatbox
@c @category{Console interaction}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
m4_setcat(Display functions)
@anchor{ldisp}
@c @deffn {Function} ldisp (@var{expr_1}, @dots{}, @var{expr_n})
m4_deffn( {Function}, ldisp, <<<(@var{expr_1}, @dots{}, @var{expr_n})>>>)

Displays expressions @var{expr_1}, @dots{}, @var{expr_n} to the console as
printed output.  @code{ldisp} assigns an intermediate expression label to each
argument and returns the list of labels.

See also @mrefcomma{disp} @mrefcomma{display} and @mrefdot{ldisplay}

Examples:

@example
(%i1) e: (a+b)^3;
                                   3
(%o1)                       (b + a)
(%i2) f: expand (e);
                     3        2      2      3
(%o2)               b  + 3 a b  + 3 a  b + a
(%i3) ldisp (e, f);
                                   3
(%t3)                       (b + a)

                     3        2      2      3
(%t4)               b  + 3 a b  + 3 a  b + a

(%o4)                      [%t3, %t4]
(%i4) %t3;
                                   3
(%o4)                       (b + a)
(%i5) %t4;
                     3        2      2      3
(%o5)               b  + 3 a b  + 3 a  b + a
@end example

@c @opencatbox
@c @category{Display functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
@anchor{ldisplay}
@c @deffn {Function} ldisplay (@var{expr_1}, @dots{}, @var{expr_n})
m4_deffn( {Function}, ldisplay, <<<(@var{expr_1}, @dots{}, @var{expr_n})>>>)

Displays expressions @var{expr_1}, @dots{}, @var{expr_n} to the console as
printed output.  Each expression is printed as an equation of the form
@code{lhs = rhs} in which @code{lhs} is one of the arguments of @code{ldisplay}
and @code{rhs} is its value.  Typically each argument is a variable.
@mref{ldisp} assigns an intermediate expression label to each equation and
returns the list of labels.

See also @mrefcomma{display} @mrefcomma{disp} and @mrefdot{ldisp}

Examples:

@example
(%i1) e: (a+b)^3;
                                   3
(%o1)                       (b + a)
(%i2) f: expand (e);
                     3        2      2      3
(%o2)               b  + 3 a b  + 3 a  b + a
(%i3) ldisplay (e, f);
                                     3
(%t3)                     e = (b + a)

                       3        2      2      3
(%t4)             f = b  + 3 a b  + 3 a  b + a

(%o4)                      [%t3, %t4]
(%i4) %t3;
                                     3
(%o4)                     e = (b + a)
(%i5) %t4;
                       3        2      2      3
(%o5)             f = b  + 3 a b  + 3 a  b + a
@end example

@opencatbox
@category{Display functions}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
m4_setcat(Display flags and variables)
@anchor{leftjust}
@c @defvr {Option variable} leftjust
m4_defvr( {Option variable}, leftjust)
Default value: @code{false}

When @code{leftjust} is @code{true}, equations in 2D-display are drawn left
justified rather than centered.

See also @mref{display2d} to switch between 1D- and 2D-display.

Example:

@example
(%i1) expand((x+1)^3);
                        3      2
(%o1)                  x  + 3 x  + 3 x + 1
(%i2) leftjust:true$
(%i3) expand((x+1)^3);
       3      2
(%o3) x  + 3 x  + 3 x + 1
@end example

@c @opencatbox
@c @category{Display flags and variables}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
@anchor{linel}
@c @defvr {Option variable} linel
m4_defvr( {Option variable}, linel)
Default value: @code{79}

@code{linel} is the assumed width (in characters) of the console display for the
purpose of displaying expressions.  @code{linel} may be assigned any value by
the user, although very small or very large values may be impractical.  Text
printed by built-in Maxima functions, such as error messages and the output of
@mrefcomma{describe} is not affected by @code{linel}.

@c @opencatbox
@c @category{Display flags and variables}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
@need 800
@anchor{lispdisp}
@c @defvr {Option variable} lispdisp
m4_defvr( {Option variable}, lispdisp)
Default value: @code{false}

When @code{lispdisp} is @code{true}, Lisp symbols are displayed with a leading
question mark @code{?}.  Otherwise, Lisp symbols are displayed with no leading
mark. This has the same effect for 1-d and 2-d display.

Examples:

@c ===beg===
@c lispdisp: false$
@c ?foo + ?bar;
@c lispdisp: true$
@c ?foo + ?bar;
@c ===end===
@example
(%i1) lispdisp: false$
@group
(%i2) ?foo + ?bar;
(%o2)                       foo + bar
@end group
(%i3) lispdisp: true$
@group
(%i4) ?foo + ?bar;
(%o4)                      ?foo + ?bar
@end group
@end example

@c @opencatbox
@c @category{Display flags and variables}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c NEEDS CLARIFICATION, EXAMPLES

@c -----------------------------------------------------------------------------
@anchor{negsumdispflag}
@c @defvr {Option variable} negsumdispflag
m4_defvr( {Option variable}, negsumdispflag)
Default value: @code{true}

When @code{negsumdispflag} is @code{true}, @code{x - y} displays as @code{x - y}
instead of as @code{- y + x}.  Setting it to @code{false} causes the special
check in display for the difference of two expressions to not be done.  One
application is that thus @code{a + %i*b} and @code{a - %i*b} may both be
displayed the same way.

@c @opencatbox
@c @category{Display flags and variables}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
m4_setcat(Display flags and variables, Console interaction)
@anchor{obase}
@c @defvr {Option variable} obase
m4_defvr( {Option variable}, obase)
Default value: @code{10}

@code{obase} is the base for integers displayed by Maxima.

@code{obase} may be assigned any integer between 2 and 36 (decimal), inclusive.
When @code{obase} is greater than 10,
the numerals comprise the decimal numerals 0 through 9
plus capital letters of the alphabet A, B, C, @dots{}, as needed.
A leading 0 digit is displayed if the leading digit is otherwise a letter.
The numerals for base 36, the largest acceptable base,
comprise 0 through 9, and A through Z.

See also @mrefdot{ibase}

Examples:

@c ===beg===
@c obase : 2;
@c 2^8 - 1;
@c obase : 8;
@c 8^8 - 1;
@c obase : 16;
@c 16^8 - 1;
@c obase : 36;
@c 36^8 - 1;
@c ===end===
@example
@group
(%i1) obase : 2;
(%o1)                          10
@end group
@group
(%i10) 2^8 - 1;
(%o10)                      11111111
@end group
@group
(%i11) obase : 8;
(%o3)                          10
@end group
@group
(%i4) 8^8 - 1;
(%o4)                       77777777
@end group
@group
(%i5) obase : 16;
(%o5)                          10
@end group
@group
(%i6) 16^8 - 1;
(%o6)                       0FFFFFFFF
@end group
@group
(%i7) obase : 36;
(%o7)                          10
@end group
@group
(%i8) 36^8 - 1;
(%o8)                       0ZZZZZZZZ
@end group
@end example

@c @opencatbox
@c @category{Display flags and variables}
@c @category{Console interaction}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
m4_setcat(Display flags and variables)
@anchor{pfeformat}
@c @defvr {Option variable} pfeformat
m4_defvr( {Option variable}, pfeformat)
Default value: @code{false}

When @code{pfeformat} is @code{true}, a ratio of integers is displayed with the
solidus (forward slash) character, and an integer denominator @code{n} is
displayed as a leading multiplicative term @code{1/n}.

Examples:

@example
(%i1) pfeformat: false$
(%i2) 2^16/7^3;
                              65536
(%o2)                         -----
                               343
(%i3) (a+b)/8;
                              b + a
(%o3)                         -----
                                8
(%i4) pfeformat: true$ 
(%i5) 2^16/7^3;
(%o5)                       65536/343
(%i6) (a+b)/8;
(%o6)                      1/8 (b + a)
@end example

@c @opencatbox
@c @category{Display flags and variables}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
@anchor{powerdisp}
@c @defvr {Option variable} powerdisp
m4_defvr( {Option variable}, powerdisp)
Default value: @code{false}

When @code{powerdisp} is @code{true},
a sum is displayed with its terms in order of increasing power.
Thus a polynomial is displayed as a truncated power series,
with the constant term first and the highest power last.

By default, terms of a sum are displayed in order of decreasing power.

Example:

@example
(%i1) powerdisp:true;
(%o1)                         true
(%i2) x^2+x^3+x^4;
                           2    3    4
(%o2)                     x  + x  + x
(%i3) powerdisp:false;
(%o3)                         false
(%i4) x^2+x^3+x^4;
                           4    3    2
(%o4)                     x  + x  + x
@end example

@opencatbox
@category{Display flags and variables}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
m4_setcat(Display functions)
@anchor{print}
@c @deffn {Function} print (@var{expr_1}, @dots{}, @var{expr_n})
m4_deffn( {Function}, print, <<<(@var{expr_1}, @dots{}, @var{expr_n})>>>)

Evaluates and displays @var{expr_1}, @dots{}, @var{expr_n} one after another,
from left to right, starting at the left edge of the console display.

The value returned by @code{print} is the value of its last argument.
@code{print} does not generate intermediate expression labels.

See also @mrefcomma{display} @mrefcomma{disp} @mrefcomma{ldisplay} and
@mrefdot{ldisp}  Those functions display one expression per line, while
@code{print} attempts to display two or more expressions per line.

To display the contents of a file, see @mrefdot{printfile}

Examples:

@example
(%i1) r: print ("(a+b)^3 is", expand ((a+b)^3), "log (a^10/b) is",
      radcan (log (a^10/b)))$
            3        2      2      3
(a+b)^3 is b  + 3 a b  + 3 a  b + a  log (a^10/b) is 

                                              10 log(a) - log(b) 
(%i2) r;
(%o2)                  10 log(a) - log(b)
(%i3) disp ("(a+b)^3 is", expand ((a+b)^3), "log (a^10/b) is",
      radcan (log (a^10/b)))$
                           (a+b)^3 is

                     3        2      2      3
                    b  + 3 a b  + 3 a  b + a

                         log (a^10/b) is

                       10 log(a) - log(b)
@end example

@c @opencatbox
@c @category{Display functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_setcat(Mathematical functions, Display flags and variables)
@anchor{sqrtdispflag}
@c @defvr {Option variable} sqrtdispflag
m4_defvr( {Option variable}, sqrtdispflag)
Default value: @code{true}

When @code{sqrtdispflag} is @code{false}, causes @code{sqrt} to display with
exponent 1/2.
@c AND OTHERWISE ... ??

@c @opencatbox
@c @category{Mathematical functions}
@c @category{Display flags and variables}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
m4_setcat(Display flags and variables)
@anchor{stardisp}
@c @defvr {Option variable} stardisp
m4_defvr( {Option variable}, stardisp)
Default value: @code{false}

When @code{stardisp} is @code{true}, multiplication is
displayed with an asterisk @code{*} between operands.

@c @opencatbox
@c @category{Display flags and variables}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
@anchor{ttyoff}
@c @defvr {Option variable} ttyoff
m4_defvr( {Option variable}, ttyoff)
Default value: @code{false}

When @code{ttyoff} is @code{true}, output expressions are not displayed.
Output expressions are still computed and assigned labels.  See @mrefdot{labels}

Text printed by built-in Maxima functions, such as error messages and the output
of @mrefcomma{describe} is not affected by @code{ttyoff}.

@c @opencatbox
@c @category{Display flags and variables}
@c @closecatbox
@c @end defvr
m4_end_defvr()