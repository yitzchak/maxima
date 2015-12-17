@c -*- Mode: texinfo -*-
@menu
* Introduction to Expressions::
* Nouns and Verbs::
* Identifiers::
* Inequality::
* Functions and Variables for Expressions::
@end menu

@c -----------------------------------------------------------------------------
@node Introduction to Expressions, Nouns and Verbs, Expressions, Expressions
@section Introduction to Expressions
@c -----------------------------------------------------------------------------

There are a number of reserved words which should not be used as variable names.
Their use would cause a possibly cryptic syntax error.

@example
integrate            next           from                 diff            
in                   at             limit                sum             
for                  and            elseif               then            
else                 do             or                   if              
unless               product        while                thru            
step                                                                     
@end example

Most things in Maxima are expressions.  A sequence of expressions
can be made into an expression by separating them by commas and
putting parentheses around them.  This is similar to the @b{C}
@i{comma expression}.

@c ===beg===
@c x: 3$
@c (x: x+1, x: x^2);
@c (if (x > 17) then 2 else 4);
@c (if (x > 17) then x: 2 else y: 4, y+x);
@c ===end===
@example
(%i1) x: 3$
(%i2) (x: x+1, x: x^2);
(%o2)                          16
(%i3) (if (x > 17) then 2 else 4);
(%o3)                           4
(%i4) (if (x > 17) then x: 2 else y: 4, y+x);
(%o4)                          20
@end example

Even loops in Maxima are expressions, although the value they
return is the not too useful @code{done}.

@c ===beg===
@c y: (x: 1, for i from 1 thru 10 do (x: x*i))$
@c y;
@c ===end===
@example
(%i1) y: (x: 1, for i from 1 thru 10 do (x: x*i))$
(%i2) y;
(%o2)                         done
@end example

Whereas what you really want is probably to include a third
term in the @i{comma expression} which actually gives back the value.

@c ===beg===
@c y: (x: 1, for i from 1 thru 10 do (x: x*i), x)$
@c y;
@c ===end===
@example
(%i3) y: (x: 1, for i from 1 thru 10 do (x: x*i), x)$
(%i4) y;
(%o4)                        3628800
@end example

@c -----------------------------------------------------------------------------
@node Nouns and Verbs, Identifiers, Introduction to Expressions, Expressions
@section Nouns and Verbs
@c -----------------------------------------------------------------------------

Maxima distinguishes between operators which are "nouns" and operators which are
"verbs".  A verb is an operator which can be executed.  A noun is an operator
which appears as a symbol in an expression, without being executed.  By default,
function names are verbs.  A verb can be changed into a noun by quoting the
function name or applying the @mref{nounify} function.  A noun can be changed
into a verb by applying the @mref{verbify} function.  The evaluation flag
@mref{nouns} causes @mref{ev} to evaluate nouns in an expression.

The verb form is distinguished by a leading dollar sign @code{$} on the
corresponding Lisp symbol.  In contrast, the noun form is distinguished by a
leading percent sign @code{%} on the corresponding Lisp symbol.  Some nouns have
special display properties, such as @code{'integrate} and @code{'derivative}
(returned by @mref{diff}), but most do not.  By default, the noun and verb forms
of a function are identical when displayed.  The global flag @mref{noundisp}@w{}
causes Maxima to display nouns with a leading quote mark @code{'}.

See also @mrefcomma{noun} @mrefcomma{nouns} @mrefcomma{nounify} and
@mrefdot{verbify}

Examples:

@c ===beg===
@c foo (x) := x^2;
@c foo (42);
@c 'foo (42);
@c 'foo (42), nouns;
@c declare (bar, noun);
@c bar (x) := x/17;
@c bar (52);
@c bar (52), nouns;
@c integrate (1/x, x, 1, 42);
@c 'integrate (1/x, x, 1, 42);
@c ev (%, nouns);
@c ===end===
@example
@group
(%i1) foo (x) := x^2;
                                     2
(%o1)                     foo(x) := x
@end group
@group
(%i2) foo (42);
(%o2)                         1764
@end group
@group
(%i3) 'foo (42);
(%o3)                        foo(42)
@end group
@group
(%i4) 'foo (42), nouns;
(%o4)                         1764
@end group
@group
(%i5) declare (bar, noun);
(%o5)                         done
@end group
@group
(%i6) bar (x) := x/17;
                                    x
(%o6)                     bar(x) := --
                                    17
@end group
@group
(%i7) bar (52);
(%o7)                        bar(52)
@end group
@group
(%i8) bar (52), nouns;
(%o8)                        bar(52)
@end group
@group
(%i9) integrate (1/x, x, 1, 42);
(%o9)                        log(42)
@end group
@group
(%i10) 'integrate (1/x, x, 1, 42);
                             42
                            /
                            [   1
(%o10)                      I   - dx
                            ]   x
                            /
                             1
@end group
@group
(%i11) ev (%, nouns);
(%o11)                       log(42)
@end group
@end example

@opencatbox
@category{Evaluation}
@category{Nouns and verbs}
@closecatbox

@c -----------------------------------------------------------------------------
@node Identifiers, Inequality, Nouns and Verbs, Expressions
@section Identifiers
@c -----------------------------------------------------------------------------

Maxima identifiers may comprise alphabetic characters, plus the numerals 0
through 9, plus any special character preceded by the backslash @code{\}
character.

A numeral may be the first character of an identifier if it is preceded by a
backslash.  Numerals which are the second or later characters need not be
preceded by a backslash.

Characters may be declared alphabetic by the @code{declare} function.
If so declared, they need not be preceded by a backslash in an identifier.
The alphabetic characters are initially @code{A} through @code{Z}, @code{a}
through @code{z}, @code{%}, and @code{_}.

Maxima is case-sensitive.  The identifiers @code{foo}, @code{FOO}, and
@code{Foo} are distinct.  See @ref{Lisp and Maxima} for more on this point.

A Maxima identifier is a Lisp symbol which begins with a dollar sign @code{$}.
Any other Lisp symbol is preceded by a question mark @code{?} when it appears
in Maxima.  See @ref{Lisp and Maxima} for more on this point.

Examples:

@c ===beg===
@c %an_ordinary_identifier42;
@c embedded\ spaces\ in\ an\ identifier;
@c symbolp (%);
@c [foo+bar, foo\+bar];
@c [1729, \1729];
@c [symbolp (foo\+bar), symbolp (\1729)];
@c [is (foo\+bar = foo+bar), is (\1729 = 1729)];
@c baz\~quux;
@c declare ("~", alphabetic);
@c baz~quux;
@c [is (foo = FOO), is (FOO = Foo), is (Foo = foo)];
@c :lisp (defvar *my-lisp-variable* '$foo)
@c ?\*my\-lisp\-variable\*;
@c ===end===
@example
@group
(%i1) %an_ordinary_identifier42;
(%o1)               %an_ordinary_identifier42
@end group
@group
(%i2) embedded\ spaces\ in\ an\ identifier;
(%o2)           embedded spaces in an identifier
@end group
@group
(%i3) symbolp (%);
(%o3)                         true
@end group
@group
(%i4) [foo+bar, foo\+bar];
(%o4)                 [foo + bar, foo+bar]
@end group
@group
(%i5) [1729, \1729];
(%o5)                     [1729, 1729]
@end group
@group
(%i6) [symbolp (foo\+bar), symbolp (\1729)];
(%o6)                     [true, true]
@end group
@group
(%i7) [is (foo\+bar = foo+bar), is (\1729 = 1729)];
(%o7)                    [false, false]
@end group
@group
(%i8) baz\~quux;
(%o8)                       baz~quux
@end group
@group
(%i9) declare ("~", alphabetic);
(%o9)                         done
@end group
@group
(%i10) baz~quux;
(%o10)                      baz~quux
@end group
@group
(%i11) [is (foo = FOO), is (FOO = Foo), is (Foo = foo)];
(%o11)                [false, false, false]
@end group
@group
(%i12) :lisp (defvar *my-lisp-variable* '$foo)
*MY-LISP-VARIABLE*
@end group
@group
(%i12) ?\*my\-lisp\-variable\*;
(%o12)                         foo
@end group
@end example

@opencatbox
@category{Syntax}
@closecatbox

@c -----------------------------------------------------------------------------
@node Inequality, Functions and Variables for Expressions, Identifiers, Expressions
@section Inequality
@c -----------------------------------------------------------------------------

Maxima has the inequality operators @code{<}, @code{<=}, @code{>=}, @code{>},
@code{#}, and @code{notequal}.  See @code{if} for a description of conditional
expressions.

@c -----------------------------------------------------------------------------
@node Functions and Variables for Expressions,  , Inequality, Expressions
@section Functions and Variables for Expressions
@c -----------------------------------------------------------------------------

@c NEEDS WORK, ESPECIALLY EXAMPLES

@c -----------------------------------------------------------------------------
m4_setcat(Declarations and inferences)
@anchor{alias}
@c @deffn {Function} alias (@var{new_name_1}, @var{old_name_1}, @dots{}, @var{new_name_n}, @var{old_name_n})
m4_deffn({Function}, alias, <<<(@var{new_name_1}, @var{old_name_1}, @dots{}, @var{new_name_n}, @var{old_name_n})>>>)

provides an alternate name for a (user or system) function, variable, array,
etc.  Any even number of arguments may be used.

@c @opencatbox
@c @category{Declarations and inferences}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_setcat(Declarations and inferences, Global variables)
@anchor{aliases}
@c @defvr {System variable} aliases
m4_defvr({System variable}, aliases)
Default value: @code{[]}

@code{aliases} is the list of atoms which have a user defined alias (set up by
the @mrefcomma{alias} @mrefcomma{ordergreat} @mref{orderless} functions or by
declaring the atom a @mref{noun} with @mrefdot{declare})

@c @opencatbox
@c @category{Declarations and inferences}
@c @category{Global variables}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c NEEDS TO BE REWORKED.  NOT CONVINCED THIS SYMBOL NEEDS ITS OWN ITEM
@c (SHOULD BE DESCRIBED IN CONTEXT OF EACH FUNCTION WHICH RECOGNIZES IT)

@c -----------------------------------------------------------------------------
m4_setcat()
@anchor{allbut}
@c @defvr {Keyword} allbut
m4_defvr({Keyword}, allbut)

works with the @code{part} commands (i.e.  @mrefcomma{part}@w{}
@mrefcomma{inpart} @mrefcomma{substpart} @mrefcomma{substinpart}@w{}
@mrefcomma{dpart} and @mref{lpart}).
For example,

@c ===beg===
@c expr : e + d + c + b + a;
@c part (expr, [2, 5]);
@c ===end===
@example
@group
(%i1) expr : e + d + c + b + a;
(%o1)                   e + d + c + b + a
@end group
@group
(%i2) part (expr, [2, 5]);
(%o2)                         d + a
@end group
@end example

while

@c ===beg===
@c expr : e + d + c + b + a;
@c part (expr, allbut (2, 5));
@c ===end===
@example
@group
(%i1) expr : e + d + c + b + a;
(%o1)                   e + d + c + b + a
@end group
@group
(%i2) part (expr, allbut (2, 5));
(%o2)                       e + c + b
@end group
@end example

@code{allbut} is also recognized by @mrefdot{kill}

@c ===beg===
@c [aa : 11, bb : 22, cc : 33, dd : 44, ee : 55];
@c kill (allbut (cc, dd));
@c [aa, bb, cc, dd];
@c ===end===
@example
@group
(%i1) [aa : 11, bb : 22, cc : 33, dd : 44, ee : 55];
(%o1)                 [11, 22, 33, 44, 55]
@end group
@group
(%i2) kill (allbut (cc, dd));
(%o0)                         done
@end group
@group
(%i1) [aa, bb, cc, dd];
(%o1)                   [aa, bb, 33, 44]
@end group
@end example

@code{kill(allbut(@var{a_1}, @var{a_2}, ...))} has the effect of
@code{kill(all)} except that it does not kill the symbols @var{a_1}, @var{a_2},
@dots{}
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
m4_setcat(Expressions)
@anchor{args}
@c @deffn {Function} args (@var{expr})
m4_deffn({Function}, args, <<<(@var{expr})>>>)

Returns the list of arguments of @code{expr}, which may be any kind of
expression other than an atom.  Only the arguments of the top-level operator
are extracted; subexpressions of @code{expr} appear as elements or
subexpressions of elements of the list of arguments.

The order of the items in the list may depend on the global flag
@mrefdot{inflag}

@code{args (@var{expr})} is equivalent to @code{substpart ("[", @var{expr}, 0)}.
See also @mrefcomma{substpart} @mrefcomma{apply} @mrefcomma{funmake} and @mrefdot{op}

How to convert a matrix to a nested list:

@c ===beg===
@c M:matrix([1,2],[3,4]);
@c args(M);
@c ===end===
@example
@group
(%i1) M:matrix([1,2],[3,4]);
                            [ 1  2 ]
(%o1)                       [      ]
                            [ 3  4 ]
@end group
@group
(%i2) args(M);
(%o2)                   [[1, 2], [3, 4]]
@end group
@end example

Since maxima internally treats a sum of @code{n} terms as a summation command
with @code{n} arguments args() can extract the list of terms in a sum:

@c ===beg===
@c a+b+c;
@c args(%);
@c ===end===
@example
@group
(%i1) a+b+c;
(%o1)                       c + b + a
@end group
@group
(%i2) args(%);
(%o2)                       [c, b, a]
@end group
@end example



@c @opencatbox
@c @category{Expressions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c REPHRASE
@c SPLIT OFF EXAMPLES INTO EXAMPLE SECTION

@c -----------------------------------------------------------------------------
m4_setcat(Expressions, Predicate functions)
@anchor{atom}
@c @deffn {Function} atom (@var{expr})
m4_deffn({Function}, atom, <<<(@var{expr})>>>)

Returns @code{true} if @var{expr} is atomic (i.e. a number, name or string) else
@code{false}.  Thus @code{atom(5)} is @code{true} while @code{atom(a[1])} and
@code{atom(sin(x))} are @code{false} (assuming @code{a[1]} and @code{x} are
unbound).

@c @opencatbox
@c @category{Expressions}
@c @category{Predicate functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_setcat(Expressions)
@anchor{box}
@c @deffn {Function} box @
m4_deffn({Function}, box, <<<>>>) @
@fname{box} (@var{expr}) @
@fname{box} (@var{expr}, @var{a})

Returns @var{expr} enclosed in a box.  The return value is an expression with
@code{box} as the operator and @var{expr} as the argument.  A box is drawn on
the display when @code{display2d} is @code{true}.

@code{box (@var{expr}, @var{a})} encloses @var{expr} in a box labelled by the
symbol @var{a}.  The label is truncated if it is longer than the width of the
box.

@code{box} evaluates its argument.  However, a boxed expression does not
evaluate to its content, so boxed expressions are effectively excluded from
computations. @mref{rembox} removes the box again.

@mref{boxchar} is the character used to draw the box in @code{box} and in the
@mref{dpart} and @mref{lpart} functions.

See also @mrefcomma{rembox} @mref{dpart} and @mrefdot{lpart}

Examples:

@c ===beg===
@c box (a^2 + b^2);
@c a : 1234;
@c b : c - d;
@c box (a^2 + b^2);
@c box (a^2 + b^2, term_1);
@c 1729 - box (1729);
@c boxchar: "-";
@c box (sin(x) + cos(y));
@c ===end===
@example
@group
(%i1) box (a^2 + b^2);
                            """""""""
                            " 2    2"
(%o1)                       "b  + a "
                            """""""""
@end group
@group
(%i2) a : 1234;
(%o2)                         1234
@end group
@group
(%i3) b : c - d;
(%o3)                         c - d
@end group
@group
(%i4) box (a^2 + b^2);
                      """"""""""""""""""""
                      "       2          "
(%o4)                 "(c - d)  + 1522756"
                      """"""""""""""""""""
@end group
@group
(%i5) box (a^2 + b^2, term_1);
                      term_1""""""""""""""
                      "       2          "
(%o5)                 "(c - d)  + 1522756"
                      """"""""""""""""""""
@end group
@group
(%i6) 1729 - box (1729);
                                 """"""
(%o6)                     1729 - "1729"
                                 """"""
@end group
@group
(%i7) boxchar: "-";
(%o7)                           -
@end group
@group
(%i8) box (sin(x) + cos(y));
                        -----------------
(%o8)                   -cos(y) + sin(x)-
                        -----------------
@end group
@end example

@c @opencatbox
@c @category{Expressions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_setcat(Expressions)
@anchor{boxchar}
@c @defvr {Option variable} boxchar
m4_defvr({Option variable}, boxchar)
Default value: @code{"}

@code{boxchar} is the character used to draw the box in the @mref{box}@w{}
and in the @mref{dpart} and @mref{lpart} functions.

All boxes in an expression are drawn with the current value of @code{boxchar};
the drawing character is not stored with the box expression.

@c @opencatbox
@c @category{Expressions}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c NEEDS CLARIFICATION !!!

@c -----------------------------------------------------------------------------
m4_setcat(Expressions)
@anchor{collapse}
@c @deffn {Function} collapse (@var{expr})
m4_deffn({Function}, collapse, <<<(@var{expr})>>>)

Collapses @var{expr} by causing all of its common (i.e., equal) subexpressions
to share (i.e., use the same cells), thereby saving space.  (@code{collapse} is
a subroutine used by the @mref{optimize} command.)  Thus, calling
@code{collapse} may be useful after loading in a @mref{save} file.  You can
collapse several expressions together by using
@code{collapse ([@var{expr_1}, ..., @var{expr_n}])}.  Similarly, you can
collapse the elements of the array @code{A} by doing
@code{collapse (listarray ('A))}.

@c @opencatbox
@c @category{Expressions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
@anchor{copy}
@c @deffn {Function} copy (@var{e})
m4_deffn({Function}, copy, <<<(@var{e})>>>)

Return a copy of the Maxima expression @var{e}.  Although @var{e} can be any
Maxima expression, the copy function is the most useful when @var{e} is either 
a list or a matrix; consider:

@c ===beg===
@c m : [1,[2,3]]$
@c mm : m$
@c mm[2][1] : x$
@c m;
@c mm;
@c ===end===
@example
(%i1) m : [1,[2,3]]$
(%i2) mm : m$
(%i3) mm[2][1] : x$
@group
(%i4) m;
(%o4)                      [1, [x, 3]]
@end group
@group
(%i5) mm;
(%o5)                      [1, [x, 3]]
@end group
@end example

Let's try the same experiment, but this time let @var{mm} be a copy of @var{m}

@c ===beg===
@c m : [1,[2,3]]$
@c mm : copy(m)$
@c mm[2][1] : x$
@c m;
@c mm;
@c ===end===
@example
(%i1) m : [1,[2,3]]$
(%i2) mm : copy(m)$
(%i3) mm[2][1] : x$
@group
(%i4) m;
(%o4)                      [1, [2, 3]]
@end group
@group
(%i5) mm;
(%o5)                      [1, [x, 3]]
@end group
@end example

This time, the assignment to @var{mm} does not change the value of @var{m}.

@c @opencatbox
@c @category{Expressions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c NEEDS WORK

@c -----------------------------------------------------------------------------
@anchor{disolate}
@c @deffn {Function} disolate (@var{expr}, @var{x_1}, @dots{}, @var{x_n})
m4_deffn({Function}, disolate, <<<(@var{expr}, @var{x_1}, @dots{}, @var{x_n})>>>)

is similar to @mref{isolate}@code{ (@var{expr}, @var{x})} except that it enables the
user to isolate more than one variable simultaneously.  This might be useful,
for example, if one were attempting to change variables in a multiple
integration, and that variable change involved two or more of the integration
variables.  This function is autoloaded from @file{simplification/disol.mac}.
A demo is available by @code{demo("disol")$}.

@c @opencatbox
@c @category{Expressions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
@anchor{dispform}
@c @deffn  {Function} dispform @
m4_deffn({Function}, dispform, <<<>>>) @
@fname{dispform} (@var{expr}) @
@fname{dispform} (@var{expr}, all)

Returns the external representation of @var{expr}.

@code{dispform(@var{expr})} returns the external representation with respect to
the main (top-level) operator.  @code{dispform(@var{expr}, all)} returns the
external representation with respect to all operators in @var{expr}.

See also @mrefcomma{part} @mrefcomma{inpart} and @mrefdot{inflag}

Examples:

The internal representation of @code{- x} is "negative one times @code{x}"
while the external representation is "minus @code{x}".

@c ===beg===
@c - x;
@c ?format (true, "~S~%", %);
@c dispform (- x);
@c ?format (true, "~S~%", %);
@c ===end===
@example
@group
(%i1) - x;
(%o1)                          - x
@end group
@group
(%i2) ?format (true, "~S~%", %);
((MTIMES SIMP) -1 $X)
(%o2)                         false
@end group
@group
(%i3) dispform (- x);
(%o3)                          - x
@end group
@group
(%i4) ?format (true, "~S~%", %);
((MMINUS SIMP) $X)
(%o4)                         false
@end group
@end example

The internal representation of @code{sqrt(x)} is "@code{x} to the power 1/2"
while the external representation is "square root of @code{x}".

@c ===beg===
@c sqrt (x);
@c ?format (true, "~S~%", %);
@c dispform (sqrt (x));
@c ?format (true, "~S~%", %);
@c ===end===
@example
@group
(%i1) sqrt (x);
(%o1)                        sqrt(x)
@end group
@group
(%i2) ?format (true, "~S~%", %);
((MEXPT SIMP) $X ((RAT SIMP) 1 2))
(%o2)                         false
@end group
@group
(%i3) dispform (sqrt (x));
(%o3)                        sqrt(x)
@end group
@group
(%i4) ?format (true, "~S~%", %);
((%SQRT SIMP) $X)
(%o4)                         false
@end group
@end example

Use of the optional argument @code{all}.

@c ===beg===
@c expr : sin (sqrt (x));
@c freeof (sqrt, expr);
@c freeof (sqrt, dispform (expr));
@c freeof (sqrt, dispform (expr, all));
@c ===end===
@example
@group
(%i1) expr : sin (sqrt (x));
(%o1)                     sin(sqrt(x))
@end group
@group
(%i2) freeof (sqrt, expr);
(%o2)                         true
@end group
@group
(%i3) freeof (sqrt, dispform (expr));
(%o3)                         true
@end group
@group
(%i4) freeof (sqrt, dispform (expr, all));
(%o4)                         false
@end group
@end example

@c @opencatbox
@c @category{Expressions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c NEEDS WORK

@c -----------------------------------------------------------------------------
@anchor{dpart}
@c @deffn {Function} dpart (@var{expr}, @var{n_1}, @dots{}, @var{n_k})
m4_deffn({Function}, dpart, <<<(@var{expr}, @var{n_1}, @dots{}, @var{n_k})>>>)

Selects the same subexpression as @mrefcomma{part} but instead of just returning
that subexpression as its value, it returns the whole expression with the
selected subexpression displayed inside a box.  The box is actually part of the
expression.

@c ===beg===
@c dpart (x+y/z^2, 1, 2, 1);
@c ===end===
@example
(%i1) dpart (x+y/z^2, 1, 2, 1);
                             y
(%o1)                       ---- + x
                               2
                            """
                            "z"
                            """
@end example

@c @opencatbox
@c @category{Expressions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
@anchor{exptisolate}
@c @defvr {Option variable} exptisolate
m4_defvr({Option variable}, exptisolate)
Default value: @code{false}

@c WHAT DOES THIS MEAN EXACTLY ??
@code{exptisolate}, when @code{true}, causes @code{isolate (expr, var)} to
examine exponents of atoms (such as @code{%e}) which contain @code{var}.

@c NEED EXAMPLES HERE
@c @opencatbox
@c @category{Expressions}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
m4_setcat(Exponential and logarithm functions, Expressions)
@anchor{exptsubst}
@c @defvr {Option variable} exptsubst
m4_defvr({Option variable}, exptsubst)
Default value: @code{false}

@code{exptsubst}, when @code{true}, permits substitutions such as @code{y}
for @code{%e^x} in @code{%e^(a x)}.

@c ===beg===
@c %e^(a*x);
@c exptsubst;
@c subst(y, %e^x, %e^(a*x));
@c exptsubst: not exptsubst;
@c subst(y, %e^x, %e^(a*x));
@c ===end===
@example
@group
(%i1) %e^(a*x);
                                a x
(%o1)                         %e
@end group
@group
(%i2) exptsubst;
(%o2)                         false
@end group
@group
(%i3) subst(y, %e^x, %e^(a*x));
                                a x
(%o3)                         %e
@end group
@group
(%i4) exptsubst: not exptsubst;
(%o4)                         true
@end group
@group
(%i5) subst(y, %e^x, %e^(a*x));
                                a
(%o5)                          y
@end group
@end example

@c @opencatbox
@c @category{Exponential and logarithm functions}
@c @category{Expressions}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
@anchor{freeof}
@c @deffn {Function} freeof (@var{x_1}, @dots{}, @var{x_n}, @var{expr})
m4_deffn({Function}, freeof, <<<(@var{x_1}, @dots{}, @var{x_n}, @var{expr})>>>)

@code{freeof (@var{x_1}, @var{expr})} returns @code{true} if no subexpression of
@var{expr} is equal to @var{x_1} or if @var{x_1} occurs only as a dummy variable
in @var{expr}, or if @var{x_1} is neither the noun nor verb form of any operator
in @var{expr}, and returns @code{false} otherwise.

@code{freeof (@var{x_1}, ..., @var{x_n}, @var{expr})} is equivalent to 
@code{freeof (@var{x_1}, @var{expr}) and ... and freeof (@var{x_n},
@var{expr})}.

The arguments @var{x_1}, @dots{}, @var{x_n} may be names of functions and
variables, subscripted names, operators (enclosed in double quotes), or general
expressions.  @code{freeof} evaluates its arguments.

@code{freeof} operates only on @var{expr} as it stands (after simplification and
evaluation) and does not attempt to determine if some equivalent expression 
would give a different result.  In particular, simplification may yield an
equivalent but different expression which comprises some different elements than
the original form of @var{expr}.

A variable is a dummy variable in an expression if it has no binding outside of 
the expression.  Dummy variables recognized by @code{freeof} are the index of a 
sum or product, the limit variable in @mrefcomma{limit} the integration variable
in the definite integral form of @mref{integrate}, the original variable in
@mrefcomma{laplace} formal variables in @mref{at} expressions, and arguments in
@mref{lambda} expressions.

The indefinite form of @code{integrate} is @i{not} free of its variable of 
integration.

Examples:

Arguments are names of functions, variables, subscripted names, operators, and 
expressions.  @code{freeof (a, b, expr)} is equivalent to 
@code{freeof (a, expr) and freeof (b, expr)}.

@c ===beg===
@c expr: z^3 * cos (a[1]) * b^(c+d);
@c freeof (z, expr);
@c freeof (cos, expr);
@c freeof (a[1], expr);
@c freeof (cos (a[1]), expr);
@c freeof (b^(c+d), expr);
@c freeof ("^", expr);
@c freeof (w, sin, a[2], sin (a[2]), b*(c+d), expr);
@c ===end===
@example
(%i1) expr: z^3 * cos (a[1]) * b^(c+d);
                                 d + c  3
(%o1)                   cos(a ) b      z
                             1
(%i2) freeof (z, expr);
(%o2)                         false
(%i3) freeof (cos, expr);
(%o3)                         false
(%i4) freeof (a[1], expr);
(%o4)                         false
(%i5) freeof (cos (a[1]), expr);
(%o5)                         false
(%i6) freeof (b^(c+d), expr);
(%o6)                         false
(%i7) freeof ("^", expr);
(%o7)                         false
(%i8) freeof (w, sin, a[2], sin (a[2]), b*(c+d), expr);
(%o8)                         true
@end example

@code{freeof} evaluates its arguments.

@c ===beg===
@c expr: (a+b)^5$
@c c: a$
@c freeof (c, expr);
@c ===end===
@example
(%i1) expr: (a+b)^5$
(%i2) c: a$
(%i3) freeof (c, expr);
(%o3)                         false
@end example

@code{freeof} does not consider equivalent expressions.
Simplification may yield an equivalent but different expression.

@c ===beg===
@c expr: (a+b)^5$
@c expand (expr);
@c freeof (a+b, %);
@c freeof (a+b, expr);
@c exp (x);
@c freeof (exp, exp (x));
@c ===end===
@example
(%i1) expr: (a+b)^5$
(%i2) expand (expr);
          5        4       2  3       3  2      4      5
(%o2)    b  + 5 a b  + 10 a  b  + 10 a  b  + 5 a  b + a
(%i3) freeof (a+b, %);
(%o3)                         true
(%i4) freeof (a+b, expr);
(%o4)                         false
(%i5) exp (x);
                                 x
(%o5)                          %e
(%i6) freeof (exp, exp (x));
(%o6)                         true
@end example

A summation or definite integral is free of its dummy variable.
An indefinite integral is not free of its variable of integration.

@c ===beg===
@c freeof (i, 'sum (f(i), i, 0, n));
@c freeof (x, 'integrate (x^2, x, 0, 1));
@c freeof (x, 'integrate (x^2, x));
@c ===end===
@example
(%i1) freeof (i, 'sum (f(i), i, 0, n));
(%o1)                         true
(%i2) freeof (x, 'integrate (x^2, x, 0, 1));
(%o2)                         true
(%i3) freeof (x, 'integrate (x^2, x));
(%o3)                         false
@end example

@c @opencatbox
@c @category{Expressions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_setcat(Expressions)
@anchor{inflag}
@c @defvr {Option variable} inflag
m4_defvr({Option variable}, inflag)
Default value: @code{false}

When @code{inflag} is @code{true}, functions for part extraction inspect the
internal form of @code{expr}.

Note that the simplifier re-orders expressions.  Thus @code{first (x + y)}
returns @code{x} if @code{inflag} is @code{true} and @code{y} if @code{inflag}
is @code{false}.  (@code{first (y + x)} gives the same results.)

Also, setting @code{inflag} to @code{true} and calling @mref{part} or
@mref{substpart} is the same as calling @mref{inpart} or @mrefdot{substinpart}

Functions affected by the setting of @code{inflag} are: @mrefcomma{part}@w{}
@mrefcomma{substpart} @mrefcomma{first} @mrefcomma{rest} @mrefcomma{last}@w{}
@mrefcomma{length} the @mref{for} @dots{} @code{in} construct,
@mrefcomma{map} @mrefcomma{fullmap} @mrefcomma{maplist} @mref{reveal} and
@mrefdot{pickapart}

@c NEED EXAMPLES HERE
@c @opencatbox
@c @category{Expressions}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c NEEDS WORK

@c -----------------------------------------------------------------------------
@anchor{inpart}
@c @deffn {Function} inpart (@var{expr}, @var{n_1}, @dots{}, @var{n_k})
m4_deffn({Function}, inpart, <<<(@var{expr}, @var{n_1}, @dots{}, @var{n_k})>>>)

is similar to @mref{part} but works on the internal representation of the
expression rather than the displayed form and thus may be faster since no
formatting is done.  Care should be taken with respect to the order of
subexpressions in sums and products (since the order of variables in the
internal form is often different from that in the displayed form) and in dealing
with unary minus, subtraction, and division (since these operators are removed
from the expression).  @code{part (x+y, 0)} or @code{inpart (x+y, 0)} yield
@code{+}, though in order to refer to the operator it must be enclosed in "s.
For example @code{... if inpart (%o9,0) = "+" then ...}.

Examples:

@c ===beg===
@c x + y + w*z;
@c inpart (%, 3, 2);
@c part (%th (2), 1, 2);
@c 'limit (f(x)^g(x+1), x, 0, minus);
@c inpart (%, 1, 2);
@c ===end===
@example
(%i1) x + y + w*z;
(%o1)                      w z + y + x
(%i2) inpart (%, 3, 2);
(%o2)                           z
(%i3) part (%th (2), 1, 2);
(%o3)                           z
(%i4) 'limit (f(x)^g(x+1), x, 0, minus);
                                  g(x + 1)
(%o4)                 limit   f(x)
                      x -> 0-
(%i5) inpart (%, 1, 2);
(%o5)                       g(x + 1)
@end example

@c @opencatbox
@c @category{Expressions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c NEEDS WORK

@c -----------------------------------------------------------------------------
@anchor{isolate}
@c @deffn {Function} isolate (@var{expr}, @var{x})
m4_deffn({Function}, isolate, <<<(@var{expr}, @var{x})>>>)

Returns @var{expr} with subexpressions which are sums and which do not contain
@var{var} replaced by intermediate expression labels (these being atomic symbols
like @code{%t1}, @code{%t2}, @dots{}).  This is often useful to avoid
unnecessary expansion of subexpressions which don't contain the variable of
interest.  Since the intermediate labels are bound to the subexpressions they
can all be substituted back by evaluating the expression in which they occur.

@mref{exptisolate} (default value: @code{false}) if @code{true} will cause
@code{isolate} to examine exponents of atoms (like @code{%e}) which contain
@var{var}.

@code{isolate_wrt_times} if @code{true}, then @code{isolate} will also isolate
with respect to products.  See @mrefdot{isolate_wrt_times} See also @mrefdot{disolate}


Do @code{example (isolate)} for examples.

@c @opencatbox
@c @category{Expressions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c NEEDS WORK

@c -----------------------------------------------------------------------------
@anchor{isolate_wrt_times}
@c @defvr {Option variable} isolate_wrt_times
m4_defvr({Option variable}, isolate_wrt_times)
Default value: @code{false}

When @code{isolate_wrt_times} is @code{true}, @code{isolate} will also isolate
with respect to products.  E.g. compare both settings of the switch on

@example
(%i1) isolate_wrt_times: true$
(%i2) isolate (expand ((a+b+c)^2), c);

(%t2)                          2 a


(%t3)                          2 b

                          2            2
(%t4)                    b  + 2 a b + a

                     2
(%o4)               c  + %t3 c + %t2 c + %t4
(%i4) isolate_wrt_times: false$
(%i5) isolate (expand ((a+b+c)^2), c);
                     2
(%o5)               c  + 2 b c + 2 a c + %t4
@end example

@c @opencatbox
@c @category{Expressions}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c NEEDS EXAMPLES

@c -----------------------------------------------------------------------------
@anchor{listconstvars}
@c @defvr {Option variable} listconstvars
m4_defvr({Option variable}, listconstvars)
Default value: @code{false}

When @code{listconstvars} is @code{true} the list returned by
@code{listofvars} contains constant variables, such as @code{%e},
@code{%pi}, @code{%i} or any variables declared as constant that
occur in @var{expr}. A variable is declared as @code{constant}
type via @mref{declare}, and @mref{constantp} returns @code{true}
for all variables declared as @code{constant}. The default is to
omit constant variables from @code{listofvars} return value.

@c @opencatbox
@c @category{Expressions}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
@anchor{listdummyvars}
@c @defvr {Option variable} listdummyvars
m4_defvr({Option variable}, listdummyvars)
Default value: @code{true}

When @code{listdummyvars} is @code{false}, "dummy variables" in the expression
will not be included in the list returned by @mrefdot{listofvars}  (The meaning
of "dummy variables" is as given in @mrefdot{freeof}  "Dummy variables" are
mathematical things like the index of a sum or product, the limit variable,
and the definite integration variable.)

Example:

@c ===beg===
@c listdummyvars: true$
@c listofvars ('sum(f(i), i, 0, n));
@c listdummyvars: false$
@c listofvars ('sum(f(i), i, 0, n));
@c ===end===
@example
(%i1) listdummyvars: true$
(%i2) listofvars ('sum(f(i), i, 0, n));
(%o2)                        [i, n]
(%i3) listdummyvars: false$
(%i4) listofvars ('sum(f(i), i, 0, n));
(%o4)                          [n]
@end example

@c @opencatbox
@c @category{Expressions}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c NEEDS WORK

@c -----------------------------------------------------------------------------
@anchor{listofvars}
@c @deffn {Function} listofvars (@var{expr})
m4_deffn({Function}, listofvars, <<<(@var{expr})>>>)

Returns a list of the variables in @var{expr}.

@mref{listconstvars} if @code{true} causes @code{listofvars} to include 
@code{%e}, @code{%pi}, @code{%i}, and any variables declared constant in the 
list it returns if they appear in @var{expr}.  The default is to omit these.

See also the option variable @mref{listdummyvars} to exclude or include
"dummy variables" in the list of variables.

@c ===beg===
@c listofvars (f (x[1]+y) / g^(2+a));
@c ===end===
@example
(%i1) listofvars (f (x[1]+y) / g^(2+a));
(%o1)                     [g, a, x , y]
                                  1
@end example

@c @opencatbox
@c @category{Expressions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c NEEDS WORK

@c -----------------------------------------------------------------------------
@anchor{lfreeof}
@c @deffn {Function} lfreeof (@var{list}, @var{expr})
m4_deffn({Function}, lfreeof, <<<(@var{list}, @var{expr})>>>)

For each member @var{m} of @var{list}, calls
@code{freeof (@var{m}, @var{expr})}.  It returns @code{false} if any call to
@mref{freeof} does and @code{true} otherwise.

Example:

@c ===beg===
@c lfreeof ([ a, x], x^2+b);
@c lfreeof ([ b, x], x^2+b);
@c lfreeof ([ a, y], x^2+b);
@c ===end===
@example
@group
(%i1) lfreeof ([ a, x], x^2+b);
(%o1)                         false
@end group
@group
(%i2) lfreeof ([ b, x], x^2+b);
(%o2)                         false
@end group
@group
(%i3) lfreeof ([ a, y], x^2+b);
(%o3)                         true
@end group
@end example

@c @opencatbox
@c @category{Expressions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c NEEDS WORK

@c -----------------------------------------------------------------------------
@anchor{lpart}
@c @deffn {Function} lpart (@var{label}, @var{expr}, @var{n_1}, @dots{}, @var{n_k})
m4_deffn({Function}, lpart, <<<(@var{label}, @var{expr}, @var{n_1}, @dots{}, @var{n_k})>>>)

is similar to @mref{dpart} but uses a labelled box.  A labelled box is similar
to the one produced by @code{dpart} but it has a name in the top line.

@c @opencatbox
@c @category{Expressions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c NEEDS CLARIFICATION, EXAMPLES

@c -----------------------------------------------------------------------------
m4_setcat(Declarations and inferences, Expressions)
@anchor{mainvar}
@c @defvr {Property} mainvar
m4_defvr({Property}, mainvar)

You may declare variables to be @code{mainvar}.  The ordering scale for atoms is
essentially: numbers < constants (e.g., @code{%e}, @code{%pi}) < scalars < other
variables < mainvars.  E.g., compare @code{expand ((X+Y)^4)} with
@code{(declare (x, mainvar), expand ((x+y)^4))}.  (Note: Care should be taken if
you elect to use the above feature.  E.g., if you subtract an expression in
which @code{x} is a @code{mainvar} from one in which @code{x} isn't a
@code{mainvar}, resimplification e.g. with @code{ev (expr, simp)} may be
necessary if cancellation is to occur.  Also, if you save an expression in which
@code{x} is a @code{mainvar}, you probably should also save @code{x}.)

@c @opencatbox
@c @category{Declarations and inferences}
@c @category{Expressions}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c NEEDS CLARIFICATION, EXAMPLES

@c -----------------------------------------------------------------------------
m4_setcat(Nouns and verbs)
@anchor{noun}
@c @defvr {Property} noun
m4_defvr({Property}, noun)

@code{noun} is one of the options of the @mref{declare} command.  It makes a
function so declared a "noun", meaning that it won't be evaluated
automatically.

Example:

@c ===beg===
@c factor (12345678);
@c declare (factor, noun);
@c factor (12345678);
@c ''%, nouns;
@c ===end===
@example
@group
(%i1) factor (12345678);
                             2
(%o1)                     2 3  47 14593
@end group
@group
(%i2) declare (factor, noun);
(%o2)                         done
@end group
@group
(%i3) factor (12345678);
(%o3)                   factor(12345678)
@end group
@group
(%i4) ''%, nouns;
                             2
(%o4)                     2 3  47 14593
@end group
@end example

@c @opencatbox
@c @category{Nouns and verbs}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c NEEDS CLARIFICATION, EXAMPLES

@c -----------------------------------------------------------------------------
m4_setcat(Display flags and variables, Nouns and verbs)
@anchor{noundisp}
@c @defvr {Option variable} noundisp
m4_defvr({Option variable}, noundisp)
Default value: @code{false}

When @code{noundisp} is @code{true}, nouns display with
a single quote.  This switch is always @code{true} when displaying function
definitions.

@c @opencatbox
@c @category{Display flags and variables}
@c @category{Nouns and verbs}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c NEEDS WORK

@c -----------------------------------------------------------------------------
m4_setcat(Nouns and verbs)
@anchor{nounify}
@c @deffn {Function} nounify (@var{f})
m4_deffn({Function}, nounify, <<<(@var{f})>>>)

Returns the noun form of the function name @var{f}.  This is
needed if one wishes to refer to the name of a verb function as if it
were a noun.  Note that some verb functions will return their noun
forms if they can't be evaluated for certain arguments.  This is also
the form returned if a function call is preceded by a quote.

See also @mrefdot{verbify}

@c @opencatbox
@c @category{Nouns and verbs}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c NEEDS WORK

@c -----------------------------------------------------------------------------
m4_setcat(Expressions)
@anchor{nterms}
@c @deffn {Function} nterms (@var{expr})
m4_deffn({Function}, nterms, <<<(@var{expr})>>>)

Returns the number of terms that @var{expr} would have if it were fully
expanded out and no cancellations or combination of terms occurred.
Note that expressions like @code{sin (@var{expr})}, @code{sqrt (@var{expr})},
@code{exp (@var{expr})}, etc. count as just one term regardless of how many
terms @var{expr} has (if it is a sum).

@c @opencatbox
@c @category{Expressions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c NEEDS WORK

@c -----------------------------------------------------------------------------
m4_setcat(Expressions, Operators)
@anchor{op}
@c @deffn {Function} op (@var{expr})
m4_deffn({Function}, op, <<<(@var{expr})>>>)

Returns the main operator of the expression @var{expr}.
@code{op (@var{expr})} is equivalent to @code{part (@var{expr}, 0)}.

@code{op} returns a string if the main operator is a built-in or user-defined
prefix, binary or n-ary infix, postfix, matchfix, or nofix operator.
Otherwise, if @var{expr} is a subscripted function expression, @code{op}
returns the subscripted function; in this case the return value is not an atom.
Otherwise, @var{expr} is a @mref{memoizing function} or ordinary function expression,
and @code{op} returns a symbol.

@code{op} observes the value of the global flag @mrefdot{inflag}

@code{op} evaluates it argument.

See also @mrefdot{args}

Examples:

@c ===beg===
@c stringdisp: true$
@c op (a * b * c);
@c op (a * b + c);
@c op ('sin (a + b));
@c op (a!);
@c op (-a);
@c op ([a, b, c]);
@c op ('(if a > b then c else d));
@c op ('foo (a));
@c prefix (foo);
@c op (foo a);
@c op (F [x, y] (a, b, c));
@c op (G [u, v, w]);
@c ===end===
@example
(%i1) stringdisp: true$
@group
(%i2) op (a * b * c);
(%o2)                          "*"
@end group
@group
(%i3) op (a * b + c);
(%o3)                          "+"
@end group
@group
(%i4) op ('sin (a + b));
(%o4)                          sin
@end group
@group
(%i5) op (a!);
(%o5)                          "!"
@end group
@group
(%i6) op (-a);
(%o6)                          "-"
@end group
@group
(%i7) op ([a, b, c]);
(%o7)                          "["
@end group
@group
(%i8) op ('(if a > b then c else d));
(%o8)                         "if"
@end group
@group
(%i9) op ('foo (a));
(%o9)                          foo
@end group
@group
(%i10) prefix (foo);
(%o10)                        "foo"
@end group
@group
(%i11) op (foo a);
(%o11)                        "foo"
@end group
@group
(%i12) op (F [x, y] (a, b, c));
(%o12)                        F
                               x, y
@end group
@group
(%i13) op (G [u, v, w]);
(%o13)                          G
@end group
@end example

@c @opencatbox
@c @category{Expressions}
@c @category{Operators}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c NEEDS WORK

@c -----------------------------------------------------------------------------
m4_setcat(Operators, Predicate functions)
@anchor{operatorp}
@c @deffn  {Function} operatorp @
m4_deffn({Function}, operatorp, <<<>>>) @
@fname{operatorp} (@var{expr}, @var{op}) @
@fname{operatorp} (@var{expr}, [@var{op_1}, @dots{}, @var{op_n}])

@code{operatorp (@var{expr}, @var{op})} returns @code{true}
if @var{op} is equal to the operator of @var{expr}.

@code{operatorp (@var{expr}, [@var{op_1}, ..., @var{op_n}])} returns
@code{true} if some element @var{op_1}, @dots{}, @var{op_n} is equal to the
operator of @var{expr}.

@c @opencatbox
@c @category{Operators}
@c @category{Predicate functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c NEEDS CLARIFICATION, EXAMPLES

@c -----------------------------------------------------------------------------
m4_setcat(Expressions)
@anchor{option_opsubst}
@c @defvr {Option variable} opsubst
m4_defvr({Option variable}, opsubst)
Default value: @code{true}

When @code{opsubst} is @code{false}, @mref{subst} does not attempt to
substitute into the operator of an expression.  E.g., 
@code{(opsubst: false, subst (x^2, r, r+r[0]))} will work.

@c ===beg===
@c r+r[0];
@c opsubst;
@c subst (x^2, r, r+r[0]);
@c opsubst: not opsubst;
@c subst (x^2, r, r+r[0]);
@c ===end===
@example
@group
(%i1) r+r[0];
(%o1)                        r + r
                                  0
@end group
@group
(%i2) opsubst;
(%o2)                         true
@end group
@group
(%i3) subst (x^2, r, r+r[0]);
                            2     2
(%o3)                      x  + (x )
                                    0
@end group
@group
(%i4) opsubst: not opsubst;
(%o4)                         false
@end group
@group
(%i5) subst (x^2, r, r+r[0]);
                              2
(%o5)                        x  + r
                                   0
@end group
@end example

@c @opencatbox
@c @category{Expressions}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c NEEDS WORK

@c -----------------------------------------------------------------------------
m4_setcat(Expressions)
@anchor{optimize}
@c @deffn {Function} optimize (@var{expr})
m4_deffn({Function}, optimize, <<<(@var{expr})>>>)

Returns an expression that produces the same value and
side effects as @var{expr} but does so more efficiently by avoiding the
recomputation of common subexpressions.  @code{optimize} also has the side
effect of "collapsing" its argument so that all common subexpressions
are shared.  Do @code{example (optimize)} for examples.

@c @opencatbox
@c @category{Expressions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
@anchor{optimprefix}
@c @defvr {Option variable} optimprefix
m4_defvr({Option variable}, optimprefix)
Default value: @code{%}

@code{optimprefix} is the prefix used for generated symbols by
the @mref{optimize} command.

@c @opencatbox
@c @category{Expressions}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
m4_setcat(Expressions)
@anchor{ordergreat}
@anchor{orderless}
@c @deffn  {Function} ordergreat (@var{v_1}, @dots{}, @var{v_n})
m4_deffn({Function}, ordergreat, <<<(@var{v_1}, @dots{}, @var{v_n})>>>)
m4_deffnx({Function}, orderless, <<<(@var{v_1}, @dots{}, @var{v_n})>>>)

@code{ordergreat} changes the canonical ordering of Maxima expressions
such that @var{v_1} succeeds @var{v_2} succeeds @dots{}  succeeds @var{v_n},
and @var{v_n} succeeds any other symbol not mentioned as an argument.

@code{orderless} changes the canonical ordering of Maxima expressions
such that @var{v_1} precedes @var{v_2} precedes @dots{} precedes @var{v_n},
and @var{v_n} precedes any other variable not mentioned as an argument.

The order established by @code{ordergreat} and @code{orderless} is dissolved
by @mrefdot{unorder}  @code{ordergreat} and @code{orderless} can be called only
once each, unless @code{unorder} is called; only the last call to
@code{ordergreat} and @code{orderless} has any effect.

See also @mrefdot{ordergreatp}

@c @opencatbox
@c @category{Expressions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_setcat(Expressions, Predicate functions)
@anchor{ordergreatp}
@anchor{orderlessp}
@c @deffn  {Function} ordergreatp (@var{expr_1}, @var{expr_2})
m4_deffn( {Function}, ordergreatp, <<<(@var{expr_1}, @var{expr_2})>>>)
m4_deffnx({Function}, orderlessp, <<<(@var{expr_1}, @var{expr_2})>>>)

@code{ordergreatp} returns @code{true} if @var{expr_1} succeeds @var{expr_2} in
the canonical ordering of Maxima expressions, and @code{false} otherwise.

@code{orderlessp} returns @code{true} if @var{expr_1} precedes @var{expr_2} in
the canonical ordering of Maxima expressions, and @code{false} otherwise.

All Maxima atoms and expressions are comparable under @code{ordergreatp} and
@code{orderlessp}, although there are isolated examples of expressions for which
these predicates are not transitive; that is a bug.

The canonical ordering of atoms (symbols, literal numbers, and strings) is the
following.

(integers and floats) precede (bigfloats) precede
(declared constants) precede (strings) precede (declared scalars)
precede (first argument to @mref{orderless}) precedes @dots{} precedes
(last argument to @code{orderless}) precedes (other symbols) precede
(last argument to @mref{ordergreat}) precedes @dots{} precedes
(first argument to @code{ordergreat}) precedes (declared main variables)

For non-atomic expressions, the canonical ordering is derived from the ordering
for atoms.  For the built-in @code{+} @code{*} and @code{^} operators,
the ordering is not easily summarized.  For other built-in operators and all
other functions and operators, expressions are ordered by their arguments
(beginning with the first argument), then by the name of the operator or
function.  In the case of subscripted expressions, the subscripted symbol is
considered the operator and the subscript is considered an argument.

The canonical ordering of expressions is modified by the functions
@mref{ordergreat} and @mrefcomma{orderless} and the @mrefcomma{mainvar}@w{}
@mrefcomma{constant} and @code{scalar} declarations.

See also @mrefdot{sort}

Examples:

Ordering ordinary symbols and constants.
Note that @code{%pi} is not ordered according to its numerical value.

@c ===beg===
@c stringdisp : true;
@c sort ([%pi, 3b0, 3.0, x, X, "foo", 3, a, 4, "bar", 4.0, 4b0]);
@c ===end===
@example
@group
(%i1) stringdisp : true;
(%o1)                         true
@end group
@group
(%i2) sort ([%pi, 3b0, 3.0, x, X, "foo", 3, a, 4, "bar", 4.0, 4b0]);
(%o2) [3, 3.0, 4, 4.0, 3.0b0, 4.0b0, %pi, "bar", "foo", X, a, x]
@end group
@end example

Effect of @code{ordergreat} and @code{orderless} functions.

@c ===beg===
@c sort ([M, H, K, T, E, W, G, A, P, J, S]);
@c ordergreat (S, J);
@c orderless (M, H);
@c sort ([M, H, K, T, E, W, G, A, P, J, S]);
@c ===end===
@example
@group
(%i1) sort ([M, H, K, T, E, W, G, A, P, J, S]);
(%o1)           [A, E, G, H, J, K, M, P, S, T, W]
@end group
@group
(%i2) ordergreat (S, J);
(%o2)                         done
@end group
@group
(%i3) orderless (M, H);
(%o3)                         done
@end group
@group
(%i4) sort ([M, H, K, T, E, W, G, A, P, J, S]);
(%o4)           [M, H, A, E, G, K, P, T, W, J, S]
@end group
@end example

Effect of @code{mainvar}, @code{constant}, and @code{scalar} declarations.

@c ===beg===
@c sort ([aa, foo, bar, bb, baz, quux, cc, dd, A1, B1, C1]);
@c declare (aa, mainvar);
@c declare ([baz, quux], constant);
@c declare ([A1, B1], scalar);
@c sort ([aa, foo, bar, bb, baz, quux, cc, dd, A1, B1, C1]);
@c ===end===
@example
@group
(%i1) sort ([aa, foo, bar, bb, baz, quux, cc, dd, A1, B1, C1]);
(%o1)   [A1, B1, C1, aa, bar, baz, bb, cc, dd, foo, quux]
@end group
@group
(%i2) declare (aa, mainvar);
(%o2)                         done
@end group
@group
(%i3) declare ([baz, quux], constant);
(%o3)                         done
@end group
@group
(%i4) declare ([A1, B1], scalar);
(%o4)                         done
@end group
@group
(%i5) sort ([aa, foo, bar, bb, baz, quux, cc, dd, A1, B1, C1]);
(%o5)   [baz, quux, A1, B1, C1, bar, bb, cc, dd, foo, aa]
@end group
@end example

Ordering non-atomic expressions.

@c ===beg===
@c sort ([1, 2, n, f(1), f(2), f(2, 1), g(1), g(1, 2), g(n), 
@c        f(n, 1)]);
@c sort ([foo(1), X[1], X[k], foo(k), 1, k]);
@c ===end===
@example
@group
(%i1) sort ([1, 2, n, f(1), f(2), f(2, 1), g(1), g(1, 2), g(n),
       f(n, 1)]);
(%o1) [1, 2, f(1), g(1), g(1, 2), f(2), f(2, 1), n, g(n), 
                                                         f(n, 1)]
@end group
@group
(%i2) sort ([foo(1), X[1], X[k], foo(k), 1, k]);
(%o2)            [1, X , foo(1), k, X , foo(k)]
                      1              k
@end group
@end example

@c @opencatbox
@c @category{Expressions}
@c @category{Predicate functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c NEEDS WORK

@c -----------------------------------------------------------------------------
m4_setcat(Expressions)
@anchor{part}
@c @deffn {Function} part (@var{expr}, @var{n_1}, @dots{}, @var{n_k})
m4_deffn({Function}, part, <<<(@var{expr}, @var{n_1}, @dots{}, @var{n_k})>>>)

Returns parts of the displayed form of @code{expr}.  It obtains the part of
@code{expr} as specified by the indices @var{n_1}, @dots{}, @var{n_k}.  First
part @var{n_1} of @code{expr} is obtained, then part @var{n_2} of that, etc.
The result is part @var{n_k} of @dots{} part @var{n_2} of part @var{n_1} of
@code{expr}.  If no indices are specified @code{expr} is returned.

@code{part} can be used to obtain an element of a list, a row of a matrix, etc.

@c "If the last argument to a part function" => FOLLOWING APPLIES TO OTHER FUNCTIONS ??
@c ATTEMPT TO VERIFY; IF SO, COPY THIS COMMENTARY TO DESCRIPTIONS OF OTHER FUNCTIONS
If the last argument to a @code{part} function is a list of indices then
several subexpressions are picked out, each one corresponding to an
index of the list.  Thus @code{part (x + y + z, [1, 3])} is @code{z+x}.

@mref{piece} holds the last expression selected when using the @code{part}
functions.  It is set during the execution of the function and thus
may be referred to in the function itself as shown below.

If @mref{partswitch} is set to @code{true} then @code{end} is returned when a
selected part of an expression doesn't exist, otherwise an error message is
given.

See also @mrefcomma{inpart} @mrefcomma{substpart} @mrefcomma{substinpart}@w{}
@mrefcomma{dpart} and @mrefdot{lpart}

Examples:

@c ===beg===
@c part(z+2*y+a,2);
@c part(z+2*y+a,[1,3]);
@c part(z+2*y+a,2,1);
@c ===end===
@example
@group
(%i1) part(z+2*y+a,2);
(%o1)                          2 y
@end group
@group
(%i2) part(z+2*y+a,[1,3]);
(%o2)                         z + a
@end group
@group
(%i3) part(z+2*y+a,2,1);
(%o3)                           2
@end group
@end example

@code{example (part)} displays additional examples.

@c @opencatbox
@c @category{Expressions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c NEEDS WORK

@c -----------------------------------------------------------------------------
@anchor{partition}
@c @deffn {Function} partition (@var{expr}, @var{x})
m4_deffn({Function}, partition, <<<(@var{expr}, @var{x})>>>)

Returns a list of two expressions.  They are (1) the factors of @var{expr}
(if it is a product), the terms of @var{expr} (if it is a sum), or the list
(if it is a list) which don't contain @var{x} and, (2) the factors, terms,
or list which do.

Examples:

@c ===beg===
@c partition (2*a*x*f(x), x);
@c partition (a+b, x);
@c partition ([a, b, f(a), c], a);
@c ===end===
@example
(%i1) partition (2*a*x*f(x), x);
(%o1)                     [2 a, x f(x)]
(%i2) partition (a+b, x);
(%o2)                      [b + a, 0]
(%i3) partition ([a, b, f(a), c], a); 
(%o3)                  [[b, c], [a, f(a)]]
@end example

@c @opencatbox
@c @category{Expressions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c NEEDS EXAMPLE

@c -----------------------------------------------------------------------------
@anchor{partswitch}
@c @defvr {Option variable} partswitch
m4_defvr({Option variable}, partswitch)
Default value: @code{false}

When @code{partswitch} is @code{true}, @code{end} is returned
when a selected part of an expression doesn't exist, otherwise an
error message is given.

@c @opencatbox
@c @category{Expressions}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
@anchor{pickapart}
@c @deffn {Function} pickapart (@var{expr}, @var{n})
m4_deffn({Function}, pickapart, <<<(@var{expr}, @var{n})>>>)

Assigns intermediate expression labels to subexpressions of @var{expr} at depth
@var{n}, an integer.  Subexpressions at greater or lesser depths are not
assigned labels.  @code{pickapart} returns an expression in terms of
intermediate expressions equivalent to the original expression @var{expr}.

See also @mrefcomma{part} @mrefcomma{dpart} @mrefcomma{lpart}@w{}
@mrefcomma{inpart} and @mrefdot{reveal}

Examples:

@example
(%i1) expr: (a+b)/2 + sin (x^2)/3 - log (1 + sqrt(x+1));
                                          2
                                     sin(x )   b + a
(%o1)       - log(sqrt(x + 1) + 1) + ------- + -----
                                        3        2
(%i2) pickapart (expr, 0);
@group
                                          2
                                     sin(x )   b + a
(%t2)       - log(sqrt(x + 1) + 1) + ------- + -----
                                        3        2
@end group
(%o2)                          %t2
(%i3) pickapart (expr, 1);

(%t3)                - log(sqrt(x + 1) + 1)


                                  2
                             sin(x )
(%t4)                        -------
                                3


                              b + a
(%t5)                         -----
                                2

(%o5)                    %t5 + %t4 + %t3
(%i5) pickapart (expr, 2);

(%t6)                 log(sqrt(x + 1) + 1)


                                  2
(%t7)                        sin(x )


(%t8)                         b + a

                         %t8   %t7
(%o8)                    --- + --- - %t6
                          2     3
(%i8) pickapart (expr, 3);

(%t9)                    sqrt(x + 1) + 1


                                2
(%t10)                         x

                  b + a              sin(%t10)
(%o10)            ----- - log(%t9) + ---------
                    2                    3
(%i10) pickapart (expr, 4);

(%t11)                     sqrt(x + 1)
@group
                      2
                 sin(x )   b + a
(%o11)           ------- + ----- - log(%t11 + 1)
                    3        2
@end group
(%i11) pickapart (expr, 5);

(%t12)                        x + 1

                   2
              sin(x )   b + a
(%o12)        ------- + ----- - log(sqrt(%t12) + 1)
                 3        2
(%i12) pickapart (expr, 6);
                  2
             sin(x )   b + a
(%o12)       ------- + ----- - log(sqrt(x + 1) + 1)
                3        2
@end example

@c @opencatbox
@c @category{Expressions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c NEEDS WORK

@c -----------------------------------------------------------------------------
@anchor{piece}
@c @defvr {System variable} piece
m4_defvr({System variable}, piece)

Holds the last expression selected when using the @mref{part} functions.
@c WHAT DOES THIS MEAN EXACTLY ??
It is set during the execution of the function and thus may be referred to in
the function itself.

@c NEED "SEE ALSO" TO POINT TO LIST OF ALL RELEVANT FUNCTIONS

@c @opencatbox
@c @category{Expressions}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
@anchor{psubst}
@c @deffn  {Function} psubst @
m4_deffn( {Function}, psubst, <<<>>>) @
@fname{psubst} (@var{list}, @var{expr}) @
@fname{psubst} (@var{a}, @var{b}, @var{expr})

@code{psubst(@var{a}, @var{b}, @var{expr})} is simliar to @code{subst}.  See 
@mrefdot{subst}

In distinction from @code{subst} the function @code{psubst} makes parallel 
substitutions, if the first argument @var{list} is a list of equations.

See also @mref{sublis} for making parallel substitutions and @mref{let} and
@mref{letsimp} for others ways to do substitutions.

Example:

The first example shows parallel substitution with @code{psubst}.  The second
example shows the result for the function @code{subst}, which does a serial
substitution.

@c ===beg===
@c psubst ([a^2=b, b=a], sin(a^2) + sin(b));
@c subst ([a^2=b, b=a], sin(a^2) + sin(b));
@c ===end===
@example
@group
(%i1) psubst ([a^2=b, b=a], sin(a^2) + sin(b));
(%o1)                    sin(b) + sin(a)
@end group
@group
(%i2) subst ([a^2=b, b=a], sin(a^2) + sin(b));
(%o2)                       2 sin(a)
@end group
@end example

@c @opencatbox
@c @category{Expressions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
@anchor{rembox}
@c @deffn  {Function} rembox @
m4_deffn( {Function}, rembox, <<<>>>) @
@fname{rembox} (@var{expr}, unlabelled) @
@fname{rembox} (@var{expr}, @var{label}) @
@fname{rembox} (@var{expr})

Removes boxes from @var{expr}.

@code{rembox (@var{expr}, unlabelled)} removes all unlabelled boxes from
@var{expr}.

@code{rembox (@var{expr}, @var{label})} removes only boxes bearing @var{label}.

@code{rembox (@var{expr})} removes all boxes, labelled and unlabelled.

Boxes are drawn by the @mrefcomma{box} @mrefcomma{dpart} and @mref{lpart}@w{}
functions.

Examples:

@c ===beg===
@c expr: (a*d - b*c)/h^2 + sin(%pi*x);
@c dpart (dpart (expr, 1, 1), 2, 2);
@c expr2: lpart (BAR, lpart (FOO, %, 1), 2);
@c rembox (expr2, unlabelled);
@c rembox (expr2, FOO);
@c rembox (expr2, BAR);
@c rembox (expr2);
@c ===end===
@example
@group
(%i1) expr: (a*d - b*c)/h^2 + sin(%pi*x);
                                  a d - b c
(%o1)                sin(%pi x) + ---------
                                      2
                                     h
@end group
@group
(%i2) dpart (dpart (expr, 1, 1), 2, 2);
dpart: fell off the end.
 -- an error. To debug this try: debugmode(true);
@end group
@group
(%i3) expr2: lpart (BAR, lpart (FOO, %, 1), 2);
                                  BAR""""""""
                   FOO"""""""""   "a d - b c"
(%o3)              "sin(%pi x)" + "---------"
                   """"""""""""   "    2    "
                                  "   h     "
                                  """""""""""
@end group
@group
(%i4) rembox (expr2, unlabelled);
                                  BAR""""""""
                   FOO"""""""""   "a d - b c"
(%o4)              "sin(%pi x)" + "---------"
                   """"""""""""   "    2    "
                                  "   h     "
                                  """""""""""
@end group
@group
(%i5) rembox (expr2, FOO);
                                 BAR""""""""
                                 "a d - b c"
(%o5)               sin(%pi x) + "---------"
                                 "    2    "
                                 "   h     "
                                 """""""""""
@end group
@group
(%i6) rembox (expr2, BAR);
                    FOO"""""""""   a d - b c
(%o6)               "sin(%pi x)" + ---------
                    """"""""""""       2
                                      h
@end group
@group
(%i7) rembox (expr2);
                                  a d - b c
(%o7)                sin(%pi x) + ---------
                                      2
                                     h
@end group
@end example

@c @opencatbox
@c @category{Expressions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_setcat(Expressions, Display functions)
@anchor{reveal}
@c @deffn {Function} reveal (@var{expr}, @var{depth})
m4_deffn({Function}, reveal, <<<(@var{expr}, @var{depth})>>>)

Replaces parts of @var{expr} at the specified integer @var{depth}
with descriptive summaries.

@itemize @bullet
@item
Sums and differences are replaced by @code{Sum(@var{n})}
where @var{n} is the number of operands of the sum.
@item
Products are replaced by @code{Product(@var{n})}
where @var{n} is the number of operands of the product.
@item
Exponentials are replaced by @code{Expt}.
@item
Quotients are replaced by @code{Quotient}.
@item
Unary negation is replaced by @code{Negterm}.
@item
Lists are replaced by @code{List(@var{n})} where @var{n} ist the number of
elements of the list.
@end itemize

When @var{depth} is greater than or equal to the maximum depth of @var{expr},
@code{reveal (@var{expr}, @var{depth})} returns @var{expr} unmodified.

@code{reveal} evaluates its arguments.
@code{reveal} returns the summarized expression.

Example:

@c ===beg===
@c e: expand ((a - b)^2)/expand ((exp(a) + exp(b))^2);
@c reveal (e, 1);
@c reveal (e, 2);
@c reveal (e, 3);
@c reveal (e, 4);
@c reveal (e, 5);
@c reveal (e, 6);
@c ===end===
@example
(%i1) e: expand ((a - b)^2)/expand ((exp(a) + exp(b))^2);
                          2            2
                         b  - 2 a b + a
(%o1)               -------------------------
                        b + a     2 b     2 a
                    2 %e      + %e    + %e
(%i2) reveal (e, 1);
(%o2)                       Quotient
(%i3) reveal (e, 2);
                             Sum(3)
(%o3)                        ------
                             Sum(3)
(%i4) reveal (e, 3);
@group
                     Expt + Negterm + Expt
(%o4)               ------------------------
                    Product(2) + Expt + Expt
@end group
(%i5) reveal (e, 4);
                       2                 2
                      b  - Product(3) + a
(%o5)         ------------------------------------
                         Product(2)     Product(2)
              2 Expt + %e           + %e
(%i6) reveal (e, 5);
                         2            2
                        b  - 2 a b + a
(%o6)              --------------------------
                       Sum(2)     2 b     2 a
                   2 %e       + %e    + %e
(%i7) reveal (e, 6);
                          2            2
                         b  - 2 a b + a
(%o7)               -------------------------
                        b + a     2 b     2 a
                    2 %e      + %e    + %e
@end example

@c @opencatbox
@c @category{Expressions}
@c @category{Display functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c NEEDS EXPANSION, CLARIFICATION, MORE EXAMPLES

@c -----------------------------------------------------------------------------
m4_setcat(Expressions)
@anchor{sublis}
@c @deffn {Function} sublis (@var{list}, @var{expr})
m4_deffn({Function}, sublis, <<<(@var{list}, @var{expr})>>>)

Makes multiple parallel substitutions into an expression.  @var{list} is a list
of equations.  The left hand side of the equations must be an atom.

The variable @mref{sublis_apply_lambda} controls simplification after
@code{sublis}.

See also @mref{psubst} for making parallel substitutions.

Example:

@c ===beg===
@c sublis ([a=b, b=a], sin(a) + cos(b));
@c ===end===
@example
@group
(%i1) sublis ([a=b, b=a], sin(a) + cos(b));
(%o1)                    sin(b) + cos(a)
@end group
@end example

@c @opencatbox
@c @category{Expressions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
@anchor{sublis_apply_lambda}
@c @defvr {Option variable} sublis_apply_lambda
m4_defvr({Option variable}, sublis_apply_lambda)
Default value: @code{true}

Controls whether @code{lambda}'s substituted are applied in simplification after
@code{sublis} is used or whether you have to do an @mref{ev} to get things to
apply.  @code{true} means do the application.

@c @opencatbox
@c @category{Expressions}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c -----------------------------------------------------------------------------
@anchor{subnumsimp}
@c @defvr {Option variable} subnumsimp
m4_defvr({Option variable}, subnumsimp)
Default value: @code{false}

If @code{true} then the functions @mref{subst} and @mref{psubst} can substitute
a subscripted variable @code{f[x]} with a number, when only the symbol @code{f}
is given.

See also @mrefdot{subst}

@c ===beg===
@c subst(100,g,g[x]+2);
@c subst(100,g,g[x]+2),subnumsimp:true;
@c ===end===
@example
(%i1) subst(100,g,g[x]+2);

subst: cannot substitute 100 for operator g in expression g
                                                           x
 -- an error. To debug this try: debugmode(true);

(%i2) subst(100,g,g[x]+2),subnumsimp:true;
(%o2)                          102
@end example

@c @opencatbox
@c @category{Expressions}
@c @closecatbox
@c @end defvr
m4_end_defvr()

@c NEEDS CLARIFICATION, MORE EXAMPLES

@c -----------------------------------------------------------------------------
m4_setcat(Expressions)
@anchor{subst}
@c @deffn {Function} subst (@var{a}, @var{b}, @var{c})
m4_deffn({Function}, subst, <<<(@var{a}, @var{b}, @var{c})>>>)

Substitutes @var{a} for @var{b} in @var{c}.  @var{b} must be an atom or a
complete subexpression of @var{c}.  For example, @code{x+y+z} is a complete
subexpression of @code{2*(x+y+z)/w} while @code{x+y} is not.  When @var{b} does
not have these characteristics, one may sometimes use @mref{substpart} or
@mref{ratsubst} (see below).  Alternatively, if @var{b} is of the form
@code{e/f} then one could use @code{subst (a*f, e, c)} while if @var{b} is of
the form @code{e^(1/f)} then one could use @code{subst (a^f, e, c)}.  The
@code{subst} command also discerns the @code{x^y} in @code{x^-y} so that
@code{subst (a, sqrt(x), 1/sqrt(x))} yields @code{1/a}.  @var{a} and @var{b}
may also be operators of an expression enclosed in double-quotes @code{"} or
they may be function names.  If one wishes to substitute for the independent
variable in derivative forms then the @code{at} function (see below) should be
used.

@c UMM, REVERSE THIS AND MOVE IT TO substitute ??
@code{subst} is an alias for @code{substitute}.

The commands @code{subst (@var{eq_1}, @var{expr})} or
@code{subst ([@var{eq_1}, ..., @var{eq_k}], @var{expr})} are other permissible
forms.  The @var{eq_i} are equations indicating substitutions to be made.
For each equation, the right side will be substituted for the left in the 
expression @var{expr}.  The equations are substituted in serial from left to
right in @var{expr}.  See the functions @code{sublis} and @code{psubst} for 
making parallel substitutions.

@mref{exptsubst} if @code{true} permits substitutions
like @code{y} for @code{%e^x} in @code{%e^(a*x)} to take place.

@c WHAT IS THIS ABOUT ??
When @code{opsubst} is @code{false},
@code{subst} will not attempt to substitute into the operator of an expression.
E.g. @code{(opsubst: false, subst (x^2, r, r+r[0]))} will work.

See also @mrefcomma{at} @mref{ev} and @mrefcomma{psubst} as well as @mref{let}
and @mrefdot{letsimp}

Examples:

@c ===beg===
@c subst (a, x+y, x + (x+y)^2 + y);
@c subst (-%i, %i, a + b*%i);
@c ===end===
@example
@group
(%i1) subst (a, x+y, x + (x+y)^2 + y);
                                    2
(%o1)                      y + x + a
@end group
@group
(%i2) subst (-%i, %i, a + b*%i);
(%o2)                       a - %i b
@end group
@end example

The substitution is done in serial for a list of equations.  Compare this with
a parallel substitution:

@c ===beg===
@c subst([a=b, b=c], a+b);
@c sublis([a=b, b=c], a+b);
@c ===end===
@example
@group
(%i1) subst([a=b, b=c], a+b);
(%o1)                          2 c
@end group
@group
(%i2) sublis([a=b, b=c], a+b);
(%o2)                         c + b
@end group
@end example

Single-character Operators like @code{+} and @code{-} have to be quoted in
order to be replaced by subst. It is to note, though, that @code{a+b-c}
might be expressed as @code{a+b+(-1*c)} internally.

@c ===beg===
@c subst(["+"="-"],a+b-c);
@c ===end===
@example
(%i3) subst(["+"="-"],a+b-c);
(%o3)                                 c-b+a
@end example

The difference between @code{subst} and @code{at} can be seen in the
following example:
@c ===beg===
@c g1:y(t)=a*x(t)+b*diff(x(t),t);
@c subst('diff(x(t),t)=1,g1);
@c at(g1,'diff(x(t),t)=1);
@c ===end===
@example
@group
(%i1) g1:y(t)=a*x(t)+b*diff(x(t),t);
                            d
(%o1)             y(t) = b (-- (x(t))) + a x(t)
                            dt
@end group
@group
(%i2) subst('diff(x(t),t)=1,g1);
(%o2)                   y(t) = a x(t) + b
@end group
@group
(%i3) at(g1,'diff(x(t),t)=1);
                              !
                     d        !
(%o3)      y(t) = b (-- (x(t))!             ) + a x(t)
                     dt       !d
                              !-- (x(t)) = 1
                               dt
@end group
@end example

@noindent
For further examples, do @code{example (subst)}.

@c @opencatbox
@c @category{Expressions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c NEEDS CLARIFICATION

@c ----------------------------------------------------------------------------
@anchor{substinpart}
@c @deffn {Function} substinpart (@var{x}, @var{expr}, @var{n_1}, @dots{}, @var{n_k})
m4_deffn({Function}, substinpart, <<<(@var{x}, @var{expr}, @var{n_1}, @dots{}, @var{n_k})>>>)

Similar to @mrefcomma{substpart} but @code{substinpart} works on the
internal representation of @var{expr}.

Examples:

@c ===beg===
@c x . 'diff (f(x), x, 2);
@c substinpart (d^2, %, 2);
@c substinpart (f1, f[1](x + 1), 0);
@c ===end===
@example
@group
(%i1) x . 'diff (f(x), x, 2);
                              2
                             d
(%o1)                   x . (--- (f(x)))
                               2
                             dx
@end group
@group
(%i2) substinpart (d^2, %, 2);
                                  2
(%o2)                        x . d
@end group
@group
(%i3) substinpart (f1, f[1](x + 1), 0);
(%o3)                       f1(x + 1)
@end group
@end example

If the last argument to a @code{part} function is a list of indices then
several subexpressions are picked out, each one corresponding to an
index of the list.  Thus

@c ===beg===
@c part (x + y + z, [1, 3]);
@c ===end===
@example
@group
(%i1) part (x + y + z, [1, 3]);
(%o1)                         z + x
@end group
@end example

@mref{piece} holds the value of the last expression selected when using the
@code{part} functions.  It is set during the execution of the function and
thus may be referred to in the function itself as shown below.
If @mref{partswitch} is set to @code{true} then @code{end} is returned when a
selected part of an expression doesn't exist, otherwise an error
message is given.

@c ===beg===
@c expr: 27*y^3 + 54*x*y^2 + 36*x^2*y + y + 8*x^3 + x + 1;
@c part (expr, 2, [1, 3]);
@c sqrt (piece/54);
@c substpart (factor (piece), expr, [1, 2, 3, 5]);
@c expr: 1/x + y/x - 1/z;
@c substpart (xthru (piece), expr, [2, 3]);
@c ===end===
@example
@group
(%i1) expr: 27*y^3 + 54*x*y^2 + 36*x^2*y + y + 8*x^3 + x + 1;
              3         2       2            3
(%o1)     27 y  + 54 x y  + 36 x  y + y + 8 x  + x + 1
@end group
@group
(%i2) part (expr, 2, [1, 3]);
                                  2
(%o2)                         54 y
@end group
@group
(%i3) sqrt (piece/54);
(%o3)                        abs(y)
@end group
@group
(%i4) substpart (factor (piece), expr, [1, 2, 3, 5]);
                               3
(%o4)               (3 y + 2 x)  + y + x + 1
@end group
@group
(%i5) expr: 1/x + y/x - 1/z;
                             1    y   1
(%o5)                     (- -) + - + -
                             z    x   x
@end group
@group
(%i6) substpart (xthru (piece), expr, [2, 3]);
                            y + 1   1
(%o6)                       ----- - -
                              x     z
@end group
@end example

Also, setting the option @mref{inflag} to @code{true} and calling @mref{part}
or @mref{substpart} is the same as calling @mref{inpart} or @code{substinpart}.

@c @opencatbox
@c @category{Expressions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c NEEDS CLARIFICATION

@c -----------------------------------------------------------------------------
@anchor{substpart}
@c @deffn {Function} substpart (@var{x}, @var{expr}, @var{n_1}, @dots{}, @var{n_k})
m4_deffn({Function}, substpart, <<<(@var{x}, @var{expr}, @var{n_1}, @dots{}, @var{n_k})>>>)

Substitutes @var{x} for the subexpression picked out by the rest of the
arguments as in @mrefdot{part}  It returns the new value of @var{expr}.  @var{x}
may be some operator to be substituted for an operator of @var{expr}.  In some
cases @var{x} needs to be enclosed in double-quotes @code{"} (e.g.
@code{substpart ("+", a*b, 0)} yields @code{b + a}).

Example:

@c ===beg===
@c 1/(x^2 + 2);
@c substpart (3/2, %, 2, 1, 2);
@c a*x + f(b, y);
@c substpart ("+", %, 1, 0);
@c ===end===
@example
@group
(%i1) 1/(x^2 + 2);
                               1
(%o1)                        ------
                              2
                             x  + 2
@end group
@group
(%i2) substpart (3/2, %, 2, 1, 2);
                               1
(%o2)                       --------
                             3/2
                            x    + 2
@end group
@group
(%i3) a*x + f(b, y);
(%o3)                     a x + f(b, y)
@end group
@group
(%i4) substpart ("+", %, 1, 0);
(%o4)                    x + f(b, y) + a
@end group
@end example

Also, setting the option @mref{inflag} to @code{true} and calling @mref{part}
or @code{substpart} is the same as calling @code{inpart} or
@mrefdot{substinpart}

@c @opencatbox
@c @category{Expressions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_setcat(Predicate functions)
@anchor{symbolp}
@c @deffn {Function} symbolp (@var{expr})
m4_deffn({Function}, symbolp, <<<(@var{expr})>>>)

Returns @code{true} if @var{expr} is a symbol, else @code{false}.

@c FOLLOWING REALLY WANTS TO BE @xref{Identiifers} BUT THAT
@c LEAVES THE UNPLEASANT RESIDUE *Note ...:: IN THE OUTPUT OF describe
See also @ref{Identifiers}.

@c @opencatbox
@c @category{Predicate functions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_setcat(Expressions)
@anchor{unorder}
@c @deffn {Function} unorder ()
m4_deffn({Function}, unorder, <<<()>>>)

Disables the aliasing created by the last use of the ordering commands 
@code{ordergreat} and @code{orderless}.  @code{ordergreat} and @code{orderless} 
may not be used more than one time each without calling @code{unorder}.
@code{unorder} does not substitute back in expressions the original symbols for
the aliases introduced by @code{ordergreat} and @code{orderless}.  Therefore,
after execution of @code{unorder} the aliases appear in previous expressions.
 
See also @code{ordergreat} and @code{orderless}.

Examples:

@code{ordergreat(a)} introduces an alias for the symbol @code{a}.  Therefore,
the difference of @code{%o2} and @code{%o4} does not vanish.  @code{unorder}
does not substitute back the symbol @code{a} and the alias appears in the
output @code{%o7}.

@c ===beg===
@c unorder();
@c b*x + a^2;
@c ordergreat (a);
@c b*x + a^2;
@c  %th(1) - %th(3);
@c unorder();
@c %th(2);
@c ===end===
@example
@group
(%i1) unorder();
(%o1)                          []
@end group
@group
(%i2) b*x + a^2;
                                   2
(%o2)                       b x + a
@end group
@group
(%i3) ordergreat (a);
(%o3)                         done
@end group
@group
(%i4) b*x + a^2;
 %th(1) - %th(3);
                             2
(%o4)                       a  + b x
@end group
@group
(%i5) unorder();
                              2    2
(%o5)                        a  - a
@end group
@group
(%i6) %th(2);
(%o6)                          [a]
@end group
@end example

@c @opencatbox
@c @category{Expressions}
@c @closecatbox
@c @end deffn
m4_end_deffn()

@c -----------------------------------------------------------------------------
m4_setcat(Nouns and verbs)
@anchor{verbify}
@c @deffn {Function} verbify (@var{f})
m4_deffn({Function}, verbify, <<<(@var{f})>>>)

Returns the verb form of the function name @var{f}.
See also @code{verb}, @code{noun}, and @code{nounify}.

Examples:

@c ===beg===
@c verbify ('foo);
@c :lisp $%
@c nounify (foo);
@c :lisp $%
@c ===end===
@example
@group
(%i1) verbify ('foo);
(%o1)                          foo
@end group
@group
(%i2) :lisp $%
$FOO
@end group
@group
(%i2) nounify (foo);
(%o2)                          foo
@end group
@group
(%i3) :lisp $%
%FOO
@end group
@end example

@c @opencatbox
@c @category{Nouns and verbs}
@c @closecatbox
@c @end deffn
m4_end_deffn()