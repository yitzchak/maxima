@c -*- Mode: texinfo -*-
@menu
* Introduction to Maximas Database::
* Functions and Variables for Properties::
* Functions and Variables for Facts::
* Functions and Variables for Predicates::
@end menu

@c -----------------------------------------------------------------------------
@node Introduction to Maximas Database, Functions and Variables for Properties, Maximas Database, Maximas Database
@section Introduction to Maximas Database
@c -----------------------------------------------------------------------------

@c -----------------------------------------------------------------------------
@node Functions and Variables for Properties, Functions and Variables for Facts, Introduction to Maximas Database, Maximas Database
@section Functions and Variables for Properties
@c -----------------------------------------------------------------------------

@c -----------------------------------------------------------------------------
@anchor{alphabetic}
@defvr {Property} alphabetic

@code{alphabetic} is a property type recognized by @mrefdot{declare}@w{}
The expression @code{declare(@var{s}, alphabetic)} tells Maxima to recognize
as alphabetic all of the characters in @var{s}, which must be a string.

See also @ref{Identifiers}.

Example:

@c ===beg===
@c xx\~yy\`\@ : 1729;
@c declare ("~`@", alphabetic);
@c xx~yy`@ + @yy`xx + `xx@@yy~;
@c listofvars (%);
@c ===end===
@example
(%i1) xx\~yy\`\@@ : 1729;
(%o1)                         1729
(%i2) declare ("~`@@", alphabetic);
(%o2)                         done
(%i3) xx~yy`@@ + @@yy`xx + `xx@@@@yy~;
(%o3)               `xx@@@@yy~ + @@yy`xx + 1729
(%i4) listofvars (%);
(%o4)                  [@@yy`xx, `xx@@@@yy~]
@end example

@opencatbox
@category{Declarations and inferences}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{bindtest}
@defvr {Property} bindtest

The command @code{declare(@var{x}, bindtest)} tells Maxima to trigger an error
when the symbol @var{x} is evaluated unbound.

@c ===beg===
@c aa + bb;
@c declare (aa, bindtest);
@c aa + bb;
@c aa : 1234;
@c aa + bb;
@c ===end===
@example
(%i1) aa + bb;
(%o1)                        bb + aa
(%i2) declare (aa, bindtest);
(%o2)                         done
(%i3) aa + bb;
aa unbound variable
 -- an error.  Quitting.  To debug this try debugmode(true);
(%i4) aa : 1234;
(%o4)                         1234
(%i5) aa + bb;
(%o5)                       bb + 1234
@end example
@end defvr

@c NEEDS EXPANSION, CLARIFICATION, AND EXAMPLES
@c CROSS REF declare, properties, ETC

@c -----------------------------------------------------------------------------
@anchor{constant}
@deffn {Property} constant

@code{declare(@var{a}, constant)} declares @var{a} to be a constant.  The
declaration of a symbol to be constant does not prevent the assignment of a
nonconstant value to the symbol.

See @mref{constantp} and @mrefdot{declare}
@c WHAT EXACTLY ARE THE CONSEQUENCES OF DECLARING AN ATOM TO BE CONSTANT ??

Example:

@example
(%i1) declare(c, constant);
(%o1)                         done
(%i2) constantp(c);
(%o2)                         true
(%i3) c : x;
(%o3)                           x
(%i4) constantp(c);
(%o4)                         false
@end example

@opencatbox
@category{Declarations and inferences} @category{Constants}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{constantp}
@deffn {Function} constantp (@var{expr})

Returns @code{true} if @var{expr} is a constant expression, otherwise returns
@code{false}.
@c WHAT DOES MAXIMA KNOW ABOUT CONSTANT EXPRESSIONS ??

An expression is considered a constant expression if its arguments are
numbers (including rational numbers, as displayed with @code{/R/}),
symbolic constants such as @mrefcomma{%pi} @mrefcomma{%e} and @mrefcomma{%i}@w{}
variables bound to a constant or declared constant by @mrefcomma{declare}@w{}
or functions whose arguments are constant.

@code{constantp} evaluates its arguments.

See the property @mref{constant} which declares a symbol to be constant.

Examples:

@c ===beg===
@c constantp (7 * sin(2));
@c constantp (rat (17/29));
@c constantp (%pi * sin(%e));
@c constantp (exp (x));
@c declare (x, constant);
@c constantp (exp (x));
@c constantp (foo (x) + bar (%e) + baz (2));
@c ===end===
@example
(%i1) constantp (7 * sin(2));
(%o1)                                true
(%i2) constantp (rat (17/29));
(%o2)                                true
(%i3) constantp (%pi * sin(%e));
(%o3)                                true
(%i4) constantp (exp (x));
(%o4)                                false
(%i5) declare (x, constant);
(%o5)                                done
(%i6) constantp (exp (x));
(%o6)                                true
(%i7) constantp (foo (x) + bar (%e) + baz (2));
(%o7)                                false
(%i8) 
@end example

@opencatbox
@category{Predicate functions} @category{Constants}
@closecatbox
@end deffn

@c NEEDS EXPANSION, CLARIFICATION, AND EXAMPLES
@c THIS ITEM IS EXTREMELY IMPORTANT
@c ENSURE THAT ALL KEYWORDS RECOGNIZED BY declare HAVE THEIR OWN DOCUMENTATION ITEMS !!
@c ALSO: HOW TO FIND THE LIST OF ALL SYMBOLS WHICH HAVE A GIVEN PROPERTY ??

@c -----------------------------------------------------------------------------
@anchor{declare}
@deffn {Function} declare (@var{a_1}, @var{p_1}, @var{a_2}, @var{p_2}, @dots{})

Assigns the atom or list of atoms @var{a_i} the property or list of properties
@var{p_i}.  When @var{a_i} and/or @var{p_i} are lists, each of the atoms gets
all of the properties.

@code{declare} quotes its arguments.  @code{declare} always returns @code{done}.

As noted in the description for each declaration flag, for some flags
@code{featurep(@var{object}, @var{feature})} returns @code{true} if @var{object}
has been declared to have @var{feature}.

For more information about the features system, see @mrefdot{features} To
remove a property from an atom, use @mrefdot{remove}

@code{declare} recognizes the following properties:

@table @code
@item additive
Tells Maxima to simplify @var{a_i} expressions by the substitution
@code{@var{a_i}(x + y + z + ...)} @code{-->}
@code{@var{a_i}(x) + @var{a_i}(y) + @var{a_i}(z) + ...}.
The substitution is carried out on the first argument only.

@item alphabetic
Tells Maxima to recognize all characters in @var{a_i} (which must be a
string) as alphabetic characters.

@item antisymmetric, commutative, symmetric
Tells Maxima to recognize @var{a_i} as a symmetric or antisymmetric
function.  @mref{commutative} is the same as @code{symmetric}.

@item bindtest
Tells Maxima to trigger an error when @var{a_i} is evaluated unbound.

@item constant
Tells Maxima to consider @var{a_i} a symbolic constant.
@c WHAT MAXIMA KNOWS ABOUT SYMBOLIC CONSTANTS IS PRETTY LIMITED
@c DUNNO IF WE WANT TO GET INTO DETAILS HERE.
@c MAYBE IN THE DOCUMENTATION FOR CONSTANT (IF THERE IS SUCH)

@item even, odd
Tells Maxima to recognize @var{a_i} as an even or odd integer variable.

@item evenfun, oddfun
Tells Maxima to recognize @var{a_i} as an odd or even function.

@item evflag
Makes @var{a_i} known to the @code{ev} function so that @var{a_i} is bound
to @code{true} during the execution of @code{ev} when @var{a_i} appears as
a flag argument of @code{ev}.  See @mrefdot{evflag}

@item evfun
Makes @var{a_i} known to @code{ev} so that the function named by @var{a_i}
is applied when @var{a_i} appears as a flag argument of @code{ev}.
See @mrefdot{evfun}

@item feature
Tells Maxima to recognize @var{a_i} as the name of a feature.
Other atoms may then be declared to have the @var{a_i} property.

@item increasing, decreasing
Tells Maxima to recognize @var{a_i} as an increasing or decreasing
function.
@c MAXIMA FAILS TO DEDUCE F(2) > F(1) FOR INCREASING FUNCTION F
@c AND FAILS TO DEDUCE ANYTHING AT ALL ABOUT DECREASING FUNCTIONS
@c REPORTED AS SF BUG # 1483194

@item integer, noninteger
Tells Maxima to recognize @var{a_i} as an integer or noninteger variable.

@item integervalued
Tells Maxima to recognize @var{a_i} as an integer-valued function.

@item lassociative, rassociative
Tells Maxima to recognize @var{a_i} as a right-associative or
left-associative function.

@item linear
Equivalent to declaring @var{a_i} both @code{outative} and
@code{additive}.

@item mainvar
Tells Maxima to consider @var{a_i} a "main variable".  A main variable
succeeds all other constants and variables in the canonical ordering of
Maxima expressions, as determined by @code{ordergreatp}.

@item multiplicative
Tells Maxima to simplify @var{a_i} expressions by the substitution
@code{@var{a_i}(x * y * z * ...)} @code{-->} 
@code{@var{a_i}(x) * @var{a_i}(y) * @var{a_i}(z) * ...}.
The substitution is carried out on the first argument only.

@anchor{nary}
@item nary
Tells Maxima to recognize @var{a_i} as an n-ary function.

The @code{nary} declaration is not the same as calling the @code{nary}
function.  The sole effect of @code{declare(foo, nary)} is to instruct the
Maxima simplifier to flatten nested expressions, for example, to simplify
@code{foo(x, foo(y, z))} to @code{foo(x, y, z)}.

@item nonarray
Tells Maxima to consider @var{a_i} not an array.  This declaration
prevents multiple evaluation of a subscripted variable name.

@item nonscalar
Tells Maxima to consider @var{a_i} a nonscalar variable.  The usual
application is to declare a variable as a symbolic vector or matrix.

@item noun
Tells Maxima to parse @var{a_i} as a noun.  The effect of this is to
replace instances of @var{a_i} with @code{'@var{a_i}} or
@code{nounify(@var{a_i})}, depending on the context.

@item outative
Tells Maxima to simplify @var{a_i} expressions by pulling constant factors
out of the first argument.

When @var{a_i} has one argument, a factor is considered constant if it is
a literal or declared constant.

When @var{a_i} has two or more arguments, a factor is considered constant
if the second argument is a symbol and the factor is free of the second
argument.

@item posfun
Tells Maxima to recognize @var{a_i} as a positive function.

@item rational, irrational
Tells Maxima to recognize @var{a_i} as a rational or irrational real
variable.

@item real, imaginary, complex
Tells Maxima to recognize @var{a_i} as a real, pure imaginary, or complex
variable.

@item scalar
Tells Maxima to consider @var{a_i} a scalar variable.

@c OBSOLETE @code{special} (RECOGNIZED BY DECLARE BUT NEVER USED ANYWHERE)
@c OBSOLETE @code{analytic} (RECOGNIZED BY DECLARE BUT NEVER USED ANYWHERE)
@end table

Examples of the usage of the properties are available in the documentation
for each separate description of a property.

@opencatbox
@category{Declarations and inferences}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{decreasing}
@anchor{increasing}
@defvr  {Property} decreasing
@defvrx {Property} increasing

The commands @code{declare(@var{f}, decreasing)} or
@code{declare(@var{f}, increasing)} tell Maxima to recognize the function
@var{f} as an decreasing or increasing function.

See also @mref{declare} for more properties.

Example:

@example
(%i1) assume(a > b);
(%o1)                        [a > b]
(%i2) is(f(a) > f(b));
(%o2)                        unknown
(%i3) declare(f, increasing);
(%o3)                         done
(%i4) is(f(a) > f(b));
(%o4)                         true
@end example

@opencatbox
@category{Declarations and inferences}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{even}
@anchor{odd}
@defvr  {Property} even
@defvrx {Property} odd

@code{declare(@var{a}, even)} or @code{declare(@var{a}, odd)} tells Maxima to
recognize the symbol @var{a} as an even or odd integer variable.  The
properties @code{even} and @code{odd} are not recognized by the functions
@mrefcomma{evenp} @mrefcomma{oddp} and @mrefdot{integerp}

See also @mref{declare} and @mrefdot{askinteger}

Example:

@example
(%i1) declare(n, even);
(%o1)                         done
(%i2) askinteger(n, even);
(%o2)                          yes
(%i3) askinteger(n);
(%o3)                          yes
(%i4) evenp(n);
(%o4)                         false
@end example

@opencatbox
@category{Declarations and inferences}
@closecatbox
@end defvr

@c NEEDS EXPANSION AND CLARIFICATION

@c -----------------------------------------------------------------------------
@anchor{feature}
@defvr {Property} feature

Maxima understands two distinct types of features, system features and features
which apply to mathematical expressions.  See also @mref{status} for information
about system features.  See also @mref{features} and @mref{featurep} for
information about mathematical features.
@c PROPERTIES, DECLARATIONS FALL UNDER THIS HEADING AS WELL
@c OTHER STUFF ??

@code{feature} itself is not the name of a function or variable.
@end defvr

@c NEEDS CLARIFICATION, ESPECIALLY WRT THE EXTENT OF THE FEATURE SYSTEM
@c (I.E. WHAT KINDS OF THINGS ARE FEATURES ACCORDING TO featurep)

@c -----------------------------------------------------------------------------
@anchor{featurep}
@deffn {Function} featurep (@var{a}, @var{f})

Attempts to determine whether the object @var{a} has the feature @var{f} on the
basis of the facts in the current database.  If so, it returns @code{true},
else @code{false}.

Note that @code{featurep} returns @code{false} when neither @var{f}
nor the negation of @var{f} can be established.

@code{featurep} evaluates its argument.

See also @mref{declare} and @mrefdot{features}

@example
(%i1) declare (j, even)$
(%i2) featurep (j, integer);
(%o2)                           true
@end example

@opencatbox
@category{Predicate functions} @category{Declarations and inferences}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{features}
@defvr {Declaration} features

Maxima recognizes certain mathematical properties of functions and variables.
These are called "features".

@code{declare (@var{x}, @var{foo})} gives the property @var{foo}
to the function or variable @var{x}.

@code{declare (@var{foo}, feature)} declares a new feature @var{foo}.
For example,
@code{declare ([red, green, blue], feature)}
declares three new features, @code{red}, @code{green}, and @code{blue}.

The predicate @code{featurep (@var{x}, @var{foo})}
returns @code{true} if @var{x} has the @var{foo} property,
and @code{false} otherwise.

The infolist @code{features} is a list of known features.  These are

@verbatim
   integer        noninteger      even
   odd            rational        irrational
   real           imaginary       complex
   analytic       increasing      decreasing
   oddfun         evenfun         posfun
   constant       commutative     lassociative
   rassociative   symmetric       antisymmetric
   integervalued
@end verbatim

plus any user-defined features.

@code{features} is a list of mathematical features.  There is also a list of
non-mathematical, system-dependent features.  See @mrefdot{status}

Example:

@c ===beg===
@c declare (FOO, feature);
@c declare (x, FOO);
@c featurep (x, FOO);
@c ===end===
@example
(%i1) declare (FOO, feature);
(%o1)                         done
(%i2) declare (x, FOO);
(%o2)                         done
(%i3) featurep (x, FOO);
(%o3)                         true
@end example

@opencatbox
@category{Declarations and inferences}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{get}
@deffn {Function} get (@var{a}, @var{i})

Retrieves the user property indicated by @var{i} associated with
atom @var{a} or returns @code{false} if @var{a} doesn't have property @var{i}.

@code{get} evaluates its arguments.

See also @mref{put} and @mrefdot{qput}

@c ===beg===
@c put (%e, 'transcendental, 'type);
@c put (%pi, 'transcendental, 'type)$
@c put (%i, 'algebraic, 'type)$
@c typeof (expr) := block ([q],
@c         if numberp (expr)
@c         then return ('algebraic),
@c         if not atom (expr)
@c         then return (maplist ('typeof, expr)),
@c         q: get (expr, 'type),
@c         if q=false
@c         then errcatch (error(expr,"is not numeric.")) else q)$
@c typeof (2*%e + x*%pi);
@c typeof (2*%e + %pi);
@c ===end===
@example
(%i1) put (%e, 'transcendental, 'type);
(%o1)                    transcendental
(%i2) put (%pi, 'transcendental, 'type)$
(%i3) put (%i, 'algebraic, 'type)$
(%i4) typeof (expr) := block ([q],
        if numberp (expr)
        then return ('algebraic),
        if not atom (expr)
        then return (maplist ('typeof, expr)),
        q: get (expr, 'type),
        if q=false
        then errcatch (error(expr,"is not numeric.")) else q)$
(%i5) typeof (2*%e + x*%pi);
x is not numeric.
(%o5)  [[transcendental, []], [algebraic, transcendental]]
(%i6) typeof (2*%e + %pi);
(%o6)     [transcendental, [algebraic, transcendental]]
@end example

@opencatbox
@category{Declarations and inferences}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{integer}
@anchor{noninteger}
@defvr  {Property} integer
@defvrx {Property} noninteger

@code{declare(@var{a}, integer)} or @code{declare(@var{a}, noninteger)} tells
Maxima to recognize @var{a} as an integer or noninteger variable.

See also @mrefdot{declare}

Example:

@example
(%i1) declare(n, integer, x, noninteger);
(%o1)                         done
(%i2) askinteger(n);
(%o2)                          yes
(%i3) askinteger(x);
(%o3)                          no
@end example

@opencatbox
@category{Declarations and inferences}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{integervalued}
@defvr {Property} integervalued

@code{declare(@var{f}, integervalued)} tells Maxima to recognize @var{f} as an
integer-valued function.

See also @mrefdot{declare}

Example:

@example
(%i1) exp(%i)^f(x);
                              %i f(x)
(%o1)                      (%e  )
(%i2) declare(f, integervalued);
(%o2)                         done
(%i3) exp(%i)^f(x);
                              %i f(x)
(%o3)                       %e
@end example

@opencatbox
@category{Declarations and inferences}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{nonarray}
@deffn {Property} nonarray

The command @code{declare(a, nonarray)} tells Maxima to consider @var{a} not
an array.  This declaration prevents multiple evaluation, if @var{a} is a
subscripted variable.

See also @mrefdot{declare}

Example:

@c ===beg===
@c a:'b$ b:'c$ c:'d$
@c a[x];
@c declare(a, nonarray);
@c a[x];
@c ===end===
@example
(%i1) a:'b$ b:'c$ c:'d$

(%i4) a[x];
(%o4)                          d
                                x
(%i5) declare(a, nonarray);
(%o5)                         done
(%i6) a[x];
(%o6)                          a
                                x
@end example

@opencatbox
@category{Expressions}
@closecatbox
@end deffn

@c NEEDS CLARIFICATION AND EXAMPLES

@c -----------------------------------------------------------------------------
@anchor{nonscalar}
@defvr {Property} nonscalar

Makes atoms behave as does a list or matrix with respect to the dot operator.

See also @mrefdot{declare}

@opencatbox
@category{Declarations and inferences} @category{Vectors} @category{Matrices}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{nonscalarp}
@deffn {Function} nonscalarp (@var{expr})

Returns @code{true} if @var{expr} is a non-scalar, i.e., it contains
atoms declared as non-scalars, lists, or matrices.

See also the predicate function @mref{scalarp} and @mrefdot{declare}

@opencatbox
@category{Predicate functions} @category{Vectors} @category{Matrices}
@closecatbox
@end deffn

@c NEEDS EXAMPLES

@c -----------------------------------------------------------------------------
@anchor{posfun}
@defvr {Property} posfun

@code{declare (f, posfun)} declares @code{f} to be a positive function.
@code{is (f(x) > 0)} yields @code{true}.

See also @mrefdot{declare}

@opencatbox
@category{Declarations and inferences} @category{Operators}
@closecatbox
@end defvr

@c NEEDS WORK ESPECIALLY EXAMPLES
@c WHOLE BUSINESS WITH PROPERTIES IS PRETTY CONFUSING, TRY TO CLEAR IT UP

@c -----------------------------------------------------------------------------
@anchor{printprops}
@deffn  {Function} printprops @
@fname{printprops} (@var{a}, @var{i}) @
@fname{printprops} ([@var{a_1}, @dots{}, @var{a_n}], @var{i}) @
@fname{printprops} (all, @var{i})

Displays the property with the indicator @var{i} associated with the atom
@var{a}.  @var{a} may also be a list of atoms or the atom @code{all} in which
case all of the atoms with the given property will be used.  For example,
@code{printprops ([f, g], atvalue)}.  @code{printprops} is for properties that
cannot otherwise be displayed, i.e.  for @mrefcomma{atvalue}@w{}
@mrefcomma{atomgrad} @mrefcomma{gradef} and @mrefdot{matchdeclare}

@opencatbox
@category{Declarations and inferences} @category{Display functions}
@closecatbox
@end deffn

@c CROSS REF TO WHICH FUNCTION OR FUNCTIONS ESTABLISH PROPERTIES !! (VERY IMPORTANT)
@c NEEDS EXPANSION, CLARIFICATION, AND EXAMPLES

@c -----------------------------------------------------------------------------
@anchor{properties}
@deffn {Function} properties (@var{a})

Returns a list of the names of all the properties associated with the atom
@var{a}.

@opencatbox
@category{Declarations and inferences}
@closecatbox
@end deffn

@c CROSS REF TO WHICH FUNCTION OR FUNCTIONS ESTABLISH PROPERTIES !! (VERY IMPORTANT)
@c NEEDS EXPANSION, CLARIFICATION, AND EXAMPLES
@c WHAT IS HIDDEN IN THE "etc" HERE ??

@c -----------------------------------------------------------------------------
@anchor{props}
@defvr {System variable} props
Default value: @code{[]}

@code{props} are atoms which have any property other than those explicitly
mentioned in @mrefcomma{infolists} such as specified by @mrefcomma{atvalue}@w{}
@mrefcomma{matchdeclare} etc., as well as properties specified in the
@mref{declare} function.

@opencatbox
@category{Declarations and inferences} @category{Global variables}
@closecatbox
@end defvr

@c CROSS REF TO WHICH FUNCTION OR FUNCTIONS ESTABLISH PROPERTIES !! (VERY IMPORTANT)
@c NEEDS EXPANSION, CLARIFICATION, AND EXAMPLES

@c -----------------------------------------------------------------------------
@anchor{propvars}
@deffn {Function} propvars (@var{prop})

Returns a list of those atoms on the @mref{props} list which
have the property indicated by @var{prop}.  Thus @code{propvars (atvalue)}
returns a list of atoms which have atvalues.

@opencatbox
@category{Declarations and inferences}
@closecatbox
@end deffn

@c CROSS REF TO OTHER FUNCTIONS WHICH PUT/GET PROPERTIES !! (VERY IMPORTANT)
@c NEEDS EXPANSION, CLARIFICATION, AND EXAMPLES
@c ARE PROPERTIES ESTABLISHED BY put THE SAME AS PROPERTIES ESTABLISHED BY declare OR OTHER FUNCTIONS ??
@c IS put (foo, true, integer) EQUIVALENT TO declare (foo, integer) FOR EXAMPLE ??

@c -----------------------------------------------------------------------------
@anchor{put}
@deffn {Function} put (@var{atom}, @var{value}, @var{indicator})

Assigns @var{value} to the property (specified by @var{indicator}) of
@var{atom}.  @var{indicator} may be the name of any property, not just a
system-defined property.

@mref{rem} reverses the effect of @code{put}.

@code{put} evaluates its arguments.
@code{put} returns @var{value}.

See also @mref{qput} and @mrefdot{get}

Examples:

@example
(%i1) put (foo, (a+b)^5, expr);
                                   5
(%o1)                       (b + a)
(%i2) put (foo, "Hello", str);
(%o2)                         Hello
(%i3) properties (foo);
(%o3)            [[user properties, str, expr]]
(%i4) get (foo, expr);
                                   5
(%o4)                       (b + a)
(%i5) get (foo, str);
(%o5)                         Hello
@end example

@opencatbox
@category{Declarations and inferences}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{qput}
@deffn {Function} qput (@var{atom}, @var{value}, @var{indicator})

Assigns @var{value} to the property (specified by @var{indicator}) of
@var{atom}.  This is the same as @mrefcomma{put} except that the arguments are
quoted.

See also @mrefdot{get}

Example:

@example
(%i1) foo: aa$ 
(%i2) bar: bb$
(%i3) baz: cc$
(%i4) put (foo, bar, baz);
(%o4)                          bb
(%i5) properties (aa);
(%o5)                [[user properties, cc]]
(%i6) get (aa, cc);
(%o6)                          bb
(%i7) qput (foo, bar, baz);
(%o7)                          bar
(%i8) properties (foo);
(%o8)            [value, [user properties, baz]]
(%i9) get ('foo, 'baz);
(%o9)                          bar
@end example

@opencatbox
@category{Declarations and inferences}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{rational}
@anchor{irrational}
@defvr  {Property} rational
@defvrx {Property} irrational

@code{declare(@var{a}, rational)} or @code{declare(@var{a}, irrational)} tells
Maxima to recognize @var{a} as a rational or irrational real variable.

See also @mrefdot{declare}

@opencatbox
@category{Declarations and inferences}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{real}
@anchor{imaginary}
@anchor{complex}
@defvr  {Property} real
@defvrx {Property} imaginary
@defvrx {Property} complex

@code{declare(@var{a}, real)}, @code{declare(@var{a}, imaginary)}, or
@code{declare(@var{a}, complex)} tells Maxima to recognize @var{a} as a real,
pure imaginary, or complex variable.

See also @mrefdot{declare}

@opencatbox
@category{Declarations and inferences}
@closecatbox
@end defvr

@c CROSS REF TO OTHER FUNCTIONS WHICH PUT/GET PROPERTIES !! (VERY IMPORTANT)
@c NEEDS EXPANSION, CLARIFICATION, AND EXAMPLES
@c HOW DOES THIS INTERACT WITH declare OR OTHER PROPERTY-ESTABLISHING FUNCTIONS ??
@c HOW IS THIS DIFFERENT FROM remove ??

@c -----------------------------------------------------------------------------
@anchor{rem}
@deffn {Function} rem (@var{atom}, @var{indicator})

Removes the property indicated by @var{indicator} from @var{atom}.
@code{rem} reverses the effect of @mrefdot{put}

@code{rem} returns @code{done} if @var{atom} had an @var{indicator} property
when @code{rem} was called, or @code{false} if it had no such property.

@opencatbox
@category{Declarations and inferences}
@closecatbox
@end deffn

@c CROSS REF TO OTHER FUNCTIONS WHICH PUT/GET PROPERTIES !! (VERY IMPORTANT)
@c NEEDS EXPANSION, CLARIFICATION, AND EXAMPLES
@c HOW DOES THIS INTERACT WITH declare OR OTHER PROPERTY-ESTABLISHING FUNCTIONS ??
@c HOW IS THIS DIFFERENT FROM rem ??

@c -----------------------------------------------------------------------------
@anchor{remove}
@deffn  {Function} remove @
@fname{remove} (@var{a_1}, @var{p_1}, @dots{}, @var{a_n}, @var{p_n}) @
@fname{remove} ([@var{a_1}, @dots{}, @var{a_m}], [@var{p_1}, @dots{}, @var{p_n}], @dots{}) @
@fname{remove} ("@var{a}", operator) @
@fname{remove} (@var{a}, transfun) @
@fname{remove} (all, @var{p})

Removes properties associated with atoms.

@code{remove (@var{a_1}, @var{p_1}, ..., @var{a_n}, @var{p_n})}
removes property @code{p_k} from atom @code{a_k}.

@code{remove ([@var{a_1}, ..., @var{a_m}], [@var{p_1}, ..., @var{p_n}], ...)}
removes properties @code{@var{p_1}, ..., @var{p_n}}
from atoms @var{a_1}, @dots{}, @var{a_m}.
There may be more than one pair of lists.

@c VERIFY THAT THIS WORKS AS ADVERTISED
@code{remove (all, @var{p})} removes the property @var{p} from all atoms which
have it.

@c SHOULD REFER TO A LIST OF ALL SYSTEM-DEFINED PROPERTIES HERE.
The removed properties may be system-defined properties such as
@code{function}, @code{macro}, or @mrefdot{mode_declare}
@code{remove} does not remove properties defined by @mrefdot{put}

@c VERIFY THAT THIS WORKS AS ADVERTISED
@c IS transfun PECULIAR TO remove ?? IF SO, SHOW SPECIAL CASE AS @defunx
A property may be @code{transfun} to remove
the translated Lisp version of a function.
After executing this, the Maxima version of the function is executed
rather than the translated version.

@code{remove ("@var{a}", operator)} or, equivalently,
@code{remove ("@var{a}", op)} removes from @var{a} the operator properties
declared by @mrefcomma{prefix} @mrefcomma{infix}@w{}
@mxrefcomma{function_nary, nary} @mrefcomma{postfix} @mrefcomma{matchfix} or
@mrefdot{nofix}  Note that the name of the operator must be written as a quoted
string.

@code{remove} always returns @code{done} whether or not an atom has a specified
property.  This behavior is unlike the more specific remove functions
@mrefcomma{remvalue} @mrefcomma{remarray} @mrefcomma{remfunction} and
@mrefdot{remrule}

@code{remove} quotes its arguments.

@c IN SERIOUS NEED OF EXAMPLES HERE
@opencatbox
@category{Declarations and inferences}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{scalar}
@defvr {Property} scalar

@code{declare(@var{a}, scalar)} tells Maxima to consider @var{a} a scalar
variable.

See also @mrefdot{declare}

@opencatbox
@category{Declarations and inferences}
@closecatbox
@end defvr

@c NEEDS CLARIFICATION AND EXAMPLES

@c -----------------------------------------------------------------------------
@anchor{scalarp}
@deffn {Function} scalarp (@var{expr})

Returns @code{true} if @var{expr} is a number, constant, or variable declared
@mref{scalar} with @mrefcomma{declare} or composed entirely of numbers,
constants, and such variables, but not containing matrices or lists.

See also the predicate function @mrefdot{nonscalarp}

@opencatbox
@category{Predicate functions} @category{Vectors} @category{Matrices}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@node Functions and Variables for Facts, Functions and Variables for Predicates, Functions and Variables for Properties, Maximas Database
@section Functions and Variables for Facts
@c -----------------------------------------------------------------------------

@c -----------------------------------------------------------------------------
@anchor{activate}
@deffn {Function} activate (@var{context_1}, @dots{}, @var{context_n})

Activates the contexts @var{context_1}, @dots{}, @var{context_n}.
The facts in these contexts are then available to
make deductions and retrieve information.
The facts in these contexts are not listed by @code{facts ()}.

The variable @mref{activecontexts} is the list
of contexts which are active by way of the @code{activate} function.

@opencatbox
@category{Declarations and inferences}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{activecontexts}
@defvr {System variable} activecontexts
Default value: @code{[]}

@code{activecontexts} is a list of the contexts which are active
by way of the @mref{activate} function, as opposed to being active because
they are subcontexts of the current context.

@opencatbox
@category{Declarations and inferences}
@closecatbox
@end defvr

@c THERE IS PROBABLY MORE TO THE STORY THAN WHAT IS INDICATED HERE ...

@c -----------------------------------------------------------------------------
@anchor{askinteger}
@deffn  {Function} askinteger @
@fname{askinteger} (@var{expr}, integer) @
@fname{askinteger} (@var{expr}) @
@fname{askinteger} (@var{expr}, even) @
@fname{askinteger} (@var{expr}, odd)

@code{askinteger (@var{expr}, integer)} attempts to determine from the
@code{assume} database whether @var{expr} is an integer.
@code{askinteger} prompts the user if it cannot tell otherwise,
@c UMM, askinteger AND asksign DO NOT APPEAR TO HAVE ANY EFFECT ON THE assume
@c DATABASE !!!
and attempt to install the information in the database if possible.
@code{askinteger (@var{expr})} is equivalent to
@code{askinteger (@var{expr}, integer)}.

@code{askinteger (@var{expr}, even)} and @code{askinteger (@var{expr}, odd)}
likewise attempt to determine if @var{expr} is an even integer or odd integer,
respectively.

@opencatbox
@category{Declarations and inferences}
@closecatbox
@end deffn

@c THERE IS PROBABLY MORE TO THE STORY THAN WHAT IS INDICATED HERE ...

@c -----------------------------------------------------------------------------
@anchor{asksign}
@deffn {Function} asksign (@var{expr})

First attempts to determine whether the specified
expression is positive, negative, or zero.  If it cannot, it asks the
user the necessary questions to complete its deduction.  The user's
answer is recorded in the data base for the duration of the current
computation.  The return value of @code{asksign} is one of @code{pos},
@code{neg}, or @code{zero}.

@opencatbox
@category{Declarations and inferences}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{assume}
@deffn {Function} assume (@var{pred_1}, @dots{}, @var{pred_n})

Adds predicates @var{pred_1}, @dots{}, @var{pred_n} to the current context.
If a predicate is inconsistent or redundant with the predicates in the current
context, it is not added to the context.  The context accumulates predicates
from each call to @code{assume}.

@code{assume} returns a list whose elements are the predicates added to the
context or the atoms @code{redundant} or @code{inconsistent} where applicable.

The predicates @var{pred_1}, @dots{}, @var{pred_n} can only be expressions
with the relational operators @code{< <= equal notequal >=} and @code{>}.
Predicates cannot be literal equality @code{=} or literal inequality @code{#}
expressions, nor can they be predicate functions such as @code{integerp}.

Compound predicates of the form @code{@var{pred_1} and ... and @var{pred_n}}
are recognized, but not @code{@var{pred_1} or ... or @var{pred_n}}.
@code{not @var{pred_k}} is recognized if @var{pred_k} is a relational predicate.
Expressions of the form @code{not (@var{pred_1} and @var{pred_2})}
and @code{not (@var{pred_1} or @var{pred_2})} are not recognized.

Maxima's deduction mechanism is not very strong;
there are many obvious consequences which cannot be determined by @mrefdot{is}
This is a known weakness.

@code{assume} does not handle predicates with complex numbers.  If a predicate
contains a complex number @code{assume} returns @code{inconsistent} or 
@code{redunant}.

@code{assume} evaluates its arguments.

See also @mrefcomma{is} @mrefcomma{facts} @mrefcomma{forget}@w{}
@mrefcomma{context} and @mrefdot{declare}

Examples:

@c ===beg===
@c assume (xx > 0, yy < -1, zz >= 0);
@c assume (aa < bb and bb < cc);
@c facts ();
@c is (xx > yy);
@c is (yy < -yy);
@c is (sinh (bb - aa) > 0);
@c forget (bb > aa);
@c prederror : false;
@c is (sinh (bb - aa) > 0);
@c is (bb^2 < cc^2);
@c ===end===
@example
(%i1) assume (xx > 0, yy < -1, zz >= 0);
(%o1)              [xx > 0, yy < - 1, zz >= 0]
(%i2) assume (aa < bb and bb < cc);
(%o2)                  [bb > aa, cc > bb]
(%i3) facts ();
(%o3)     [xx > 0, - 1 > yy, zz >= 0, bb > aa, cc > bb]
(%i4) is (xx > yy);
(%o4)                         true
(%i5) is (yy < -yy);
(%o5)                         true
(%i6) is (sinh (bb - aa) > 0);
(%o6)                         true
(%i7) forget (bb > aa);
(%o7)                       [bb > aa]
(%i8) prederror : false;
(%o8)                         false
(%i9) is (sinh (bb - aa) > 0);
(%o9)                        unknown
(%i10) is (bb^2 < cc^2);
(%o10)                       unknown
@end example

@opencatbox
@category{Declarations and inferences}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{assumescalar}
@defvr {Option variable} assumescalar
Default value: @code{true}

@code{assumescalar} helps govern whether expressions @code{expr}
for which @code{nonscalarp (expr)} is @code{false}
are assumed to behave like scalars for certain transformations.

Let @code{expr} represent any expression other than a list or a matrix,
and let @code{[1, 2, 3]} represent any list or matrix.
Then @code{expr . [1, 2, 3]} yields @code{[expr, 2 expr, 3 expr]}
if @code{assumescalar} is @code{true}, or @code{scalarp (expr)} is
@code{true}, or @code{constantp (expr)} is @code{true}.

If @code{assumescalar} is @code{true}, such
expressions will behave like scalars only for commutative
operators, but not for noncommutative multiplication @code{.}.

When @code{assumescalar} is @code{false}, such
expressions will behave like non-scalars.

When @code{assumescalar} is @code{all}, such expressions will behave like
scalars for all the operators listed above.

@opencatbox
@category{Declarations and inferences}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@need 800
@anchor{assume_pos}
@defvr {Option variable} assume_pos
Default value: @code{false}

When @code{assume_pos} is @code{true} and the sign of a parameter @var{x}
cannot be determined from the current context
@c WHAT ARE THOSE OTHER CONSIDERATIONS ??
or other considerations,
@code{sign} and @code{asksign (@var{x})} return @code{true}.
This may forestall some automatically-generated @code{asksign} queries,
such as may arise from @code{integrate} or other computations.

By default, a parameter is @var{x} such that @code{symbolp (@var{x})}
or @code{subvarp (@var{x})}.
The class of expressions considered parameters can be modified to some extent
via the variable @code{assume_pos_pred}.

@code{sign} and @code{asksign} attempt to deduce the sign of expressions
from the sign of operands within the expression.
For example, if @code{a} and @code{b} are both positive,
then @code{a + b} is also positive.

However, there is no way to bypass all @code{asksign} queries.
In particular, when the @code{asksign} argument is a
difference @code{@var{x} - @var{y}} or a logarithm @code{log(@var{x})},
@code{asksign} always requests an input from the user,
even when @code{assume_pos} is @code{true} and @code{assume_pos_pred} is
a function which returns @code{true} for all arguments.

@c NEED EXAMPLES HERE
@opencatbox
@category{Declarations and inferences}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{assume_pos_pred}
@defvr {Option variable} assume_pos_pred
Default value: @code{false}

When @code{assume_pos_pred} is assigned the name of a function
or a lambda expression of one argument @var{x},
that function is called to determine
whether @var{x} is considered a parameter for the purpose of @code{assume_pos}.
@code{assume_pos_pred} is ignored when @code{assume_pos} is @code{false}.

The @code{assume_pos_pred} function is called by @code{sign} and @code{asksign}
with an argument @var{x}
which is either an atom, a subscripted variable, or a function call expression.
If the @code{assume_pos_pred} function returns @code{true},
@var{x} is considered a parameter for the purpose of @code{assume_pos}.

By default, a parameter is @var{x} such that @code{symbolp (@var{x})}
or @code{subvarp (@var{x})}.

See also @mref{assume} and @mrefdot{assume_pos}

Examples:

@c ===beg===
@c assume_pos: true$
@c assume_pos_pred: symbolp$
@c sign (a);
@c sign (a[1]);
@c assume_pos_pred: lambda ([x], display (x), true)$
@c asksign (a);
@c asksign (a[1]);
@c asksign (foo (a));
@c asksign (foo (a) + bar (b));
@c asksign (log (a));
@c input:p;
@c asksign (a - b);
@c input:p;
@c ===end===
@example
(%i1) assume_pos: true$
(%i2) assume_pos_pred: symbolp$
(%i3) sign (a);
(%o3)                          pos
(%i4) sign (a[1]);
(%o4)                          pnz
(%i5) assume_pos_pred: lambda ([x], display (x), true)$
(%i6) asksign (a);
                              x = a

(%o6)                          pos
(%i7) asksign (a[1]);
                             x = a
                                  1

(%o7)                          pos
(%i8) asksign (foo (a));
                           x = foo(a)

(%o8)                          pos
(%i9) asksign (foo (a) + bar (b));
                           x = foo(a)

                           x = bar(b)

(%o9)                          pos
(%i10) asksign (log (a));
                              x = a

Is  a - 1  positive, negative, or zero?

p;
(%o10)                         pos
(%i11) asksign (a - b);
                              x = a

                              x = b

                              x = a

                              x = b

Is  b - a  positive, negative, or zero?

p;
(%o11)                         neg
@end example

@opencatbox
@category{Declarations and inferences}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{context}
@defvr {Option variable} context
Default value: @code{initial}

@code{context} names the collection of facts maintained by @mref{assume} and
@mrefdot{forget}  @code{assume} adds facts to the collection named by
@code{context}, while @code{forget} removes facts.

Binding @code{context} to a name @var{foo} changes the current context to
@var{foo}.  If the specified context @var{foo} does not yet exist,
it is created automatically by a call to @mrefdot{newcontext}
@c ISN'T THIS NEXT BIT EQUIVALENT TO THE FIRST ??
The specified context is activated automatically.

See @mref{contexts} for a general description of the context mechanism.

@opencatbox
@category{Declarations and inferences}
@closecatbox
@end defvr

@c UMM, I'M HAVING TROUBLE GETTING THE CONTEXT-SWITCHING STUFF TO BEHAVE AS EXPECTED
@c SOME EXAMPLES WILL HELP A LOT HERE

@c -----------------------------------------------------------------------------
@anchor{contexts}
@defvr {Option variable} contexts
Default value: @code{[initial, global]}

@code{contexts} is a list of the contexts which
currently exist, including the currently active context.

The context mechanism makes it possible for a user to bind together
and name a collection of facts, called a context.
Once this is done, the user can have Maxima assume or forget large numbers
of facts merely by activating or deactivating their context.

Any symbolic atom can be a context, and the facts contained in that
context will be retained in storage until destroyed one by one
by calling @mref{forget} or destroyed as a whole by calling @mref{kill}@w{}
to destroy the context to which they belong.

Contexts exist in a hierarchy, with the root always being
the context @code{global}, which contains information about Maxima that some
functions need.  When in a given context, all the facts in that
context are "active" (meaning that they are used in deductions and
retrievals) as are all the facts in any context which is a subcontext
of the active context.

When a fresh Maxima is started up, the user is in a
context called @code{initial}, which has @code{global} as a subcontext.

See also @mrefcomma{facts} @mrefcomma{newcontext} @mrefcomma{supcontext}@w{}
@mrefcomma{killcontext} @mrefcomma{activate} @mrefcomma{deactivate}@w{}
@mrefcomma{assume} and @mrefdot{forget}

@opencatbox
@category{Declarations and inferences}
@closecatbox
@end defvr

@c -----------------------------------------------------------------------------
@anchor{deactivate}
@deffn {Function} deactivate (@var{context_1}, @dots{}, @var{context_n})

Deactivates the specified contexts @var{context_1}, @dots{}, @var{context_n}.

@opencatbox
@category{Declarations and inferences}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{facts}
@deffn  {Function} facts @
@fname{facts} (@var{item}) @
@fname{facts} ()

If @var{item} is the name of a context, @code{facts (@var{item})} returns a
list of the facts in the specified context.

If @var{item} is not the name of a context, @code{facts (@var{item})} returns a
list of the facts known about @var{item} in the current context.  Facts that
are active, but in a different context, are not listed.

@code{facts ()} (i.e., without an argument) lists the current context.

@opencatbox
@category{Declarations and inferences}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{forget}
@deffn  {Function} forget @
@fname{forget} (@var{pred_1}, @dots{}, @var{pred_n}) @
@fname{forget} (@var{L})

Removes predicates established by @mrefdot{assume}
The predicates may be expressions equivalent to (but not necessarily identical
to) those previously assumed.

@code{forget (@var{L})}, where @var{L} is a list of predicates,
forgets each item on the list.

@opencatbox
@category{Declarations and inferences}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{is}
@deffn {Function} is (@var{expr})

Attempts to determine whether the predicate @var{expr} is provable from the
facts in the @code{assume} database.

If the predicate is provably @code{true} or @code{false}, @code{is} returns
@code{true} or @code{false}, respectively.  Otherwise, the return value is
governed by the global flag @mrefdot{prederror}  When @code{prederror} is
@code{true}, @code{is} complains with an error message.  Otherwise, @code{is}
returns @code{unknown}.

@code{ev(@var{expr}, pred)} (which can be written  @code{@var{expr}, pred} at
the interactive prompt) is equivalent to @code{is(@var{expr})}.

See also @mrefcomma{assume} @mrefcomma{facts} and @mrefdot{maybe}

Examples:

@code{is} causes evaluation of predicates.

@c ===beg===
@c %pi > %e;
@c is (%pi > %e);
@c ===end===
@example
(%i1) %pi > %e;
(%o1)                       %pi > %e
(%i2) is (%pi > %e);
(%o2)                         true
@end example

@code{is} attempts to derive predicates from the @code{assume} database.

@c ===beg===
@c assume (a > b);
@c assume (b > c);
@c is (a < b);
@c is (a > c);
@c is (equal (a, c));
@c ===end===
@example
(%i1) assume (a > b);
(%o1)                        [a > b]
(%i2) assume (b > c);
(%o2)                        [b > c]
(%i3) is (a < b);
(%o3)                         false
(%i4) is (a > c);
(%o4)                         true
(%i5) is (equal (a, c));
(%o5)                         false
@end example

If @code{is} can neither prove nor disprove a predicate from the @code{assume}
database, the global flag @code{prederror} governs the behavior of @code{is}.

@c ===beg===
@c assume (a > b);
@c prederror: true$
@c is (a > 0);
@c prederror: false$
@c is (a > 0);
@c ===end===
@example
(%i1) assume (a > b);
(%o1)                        [a > b]
(%i2) prederror: true$
(%i3) is (a > 0);
Maxima was unable to evaluate the predicate:
a > 0
 -- an error.  Quitting.  To debug this try debugmode(true);
(%i4) prederror: false$
(%i5) is (a > 0);
(%o5)                        unknown
@end example

@opencatbox
@category{Predicate functions} @category{Declarations and inferences}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{killcontext}
@deffn {Function} killcontext (@var{context_1}, @dots{}, @var{context_n})

Kills the contexts @var{context_1}, @dots{}, @var{context_n}.

If one of the contexts is the current context, the new current context will
become the first available subcontext of the current context which has not been
killed.  If the first available unkilled context is @code{global} then
@code{initial} is used instead.  If the @code{initial} context is killed, a
new, empty @code{initial} context is created.

@code{killcontext} refuses to kill a context which is
currently active, either because it is a subcontext of the current
context, or by use of the function @mrefdot{activate}

@code{killcontext} evaluates its arguments.
@code{killcontext} returns @code{done}.

@opencatbox
@category{Declarations and inferences}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{maybe}
@deffn {Function} maybe (@var{expr})

Attempts to determine whether the predicate @var{expr} is provable from the
facts in the @code{assume} database.

If the predicate is provably @code{true} or @code{false}, @code{maybe} returns
@code{true} or @code{false}, respectively.  Otherwise, @code{maybe} returns
@code{unknown}.

@code{maybe} is functionally equivalent to @code{is} with
@code{prederror: false}, but the result is computed without actually assigning
a value to @code{prederror}.

See also @mrefcomma{assume} @mrefcomma{facts} and @mrefdot{is}

Examples:

@c ===beg===
@c maybe (x > 0);
@c assume (x > 1);
@c maybe (x > 0);
@c ===end===
@example
(%i1) maybe (x > 0);
(%o1)                        unknown
(%i2) assume (x > 1);
(%o2)                        [x > 1]
(%i3) maybe (x > 0);
(%o3)                         true
@end example

@opencatbox
@category{Predicate functions} @category{Declarations and inferences}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{newcontext}
@deffn {Function} newcontext @
@fname{newcontext} (@var{name}) @
@fname{newcontext} ()

Creates a new, empty context, called @var{name}, which
has @code{global} as its only subcontext.  The newly-created context
becomes the currently active context.

If @var{name} is not specified, a new name is created (via @code{gensym}) and returned.

@code{newcontext} evaluates its argument.
@code{newcontext} returns @var{name} (if specified) or the new context name.

@opencatbox
@category{Declarations and inferences}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{sign}
@deffn {Function} sign (@var{expr})

Attempts to determine the sign of @var{expr} on the basis of the facts in the
current data base.  It returns one of the following answers: @code{pos}
(positive), @code{neg} (negative), @code{zero}, @code{pz} (positive or zero),
@code{nz} (negative or zero), @code{pn} (positive or negative), or @code{pnz}
(positive, negative, or zero, i.e. nothing known).

@opencatbox
@category{Declarations and inferences}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{supcontext}
@deffn {Function} supcontext @
@fname{supcontext} (@var{name}, @var{context}) @
@fname{supcontext} (@var{name}) @
@fname{supcontext} ()

Creates a new context, called @var{name}, which has @var{context} as a
subcontext.  @var{context} must exist.

If @var{context} is not specified, the current context is assumed.

If @var{name} is not specified, a new name is created (via @code{gensym}) and returned.

@code{supcontext} evaluates its argument.
@code{supcontext} returns @var{name} (if specified) or the new context name.

@opencatbox
@category{Declarations and inferences}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@node Functions and Variables for Predicates, , Functions and Variables for Facts, Maximas Database
@section Functions and Variables for Predicates
@c -----------------------------------------------------------------------------

@c -----------------------------------------------------------------------------
@anchor{charfun}
@deffn {Function} charfun (@var{p})

Return 0 when the predicate @var{p} evaluates to @code{false}; return 1 when
the predicate evaluates to @code{true}.  When the predicate evaluates to
something other than @code{true} or @code{false} (unknown),  return a noun form.

Examples:

@c ===beg===
@c charfun (x < 1);
@c subst (x = -1, %);
@c e : charfun ('"and" (-1 < x, x < 1))$
@c [subst (x = -1, e), subst (x = 0, e), subst (x = 1, e)];
@c ===end===
@example
(%i1) charfun (x < 1);
(%o1)                    charfun(x < 1)
(%i2) subst (x = -1, %);
(%o2)                           1
(%i3) e : charfun ('"and" (-1 < x, x < 1))$
(%i4) [subst (x = -1, e), subst (x = 0, e), subst (x = 1, e)];
(%o4)                       [0, 1, 0]
@end example

@opencatbox
@category{Mathematical functions}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{compare}
@deffn {Function} compare (@var{x}, @var{y})

Return a comparison operator @var{op} (@code{<}, @code{<=}, @code{>}, @code{>=},
@code{=}, or @code{#}) such that @code{is (@var{x} @var{op} @var{y})} evaluates
to @code{true}; when either @var{x} or @var{y} depends on @code{%i} and
@code{@var{x} # @var{y}}, return @code{notcomparable}; when there is no such
operator or Maxima isn't able to determine the operator, return @code{unknown}.

Examples:

@c ===beg===
@c compare (1, 2);
@c compare (1, x);
@c compare (%i, %i);
@c compare (%i, %i + 1);
@c compare (1/x, 0);
@c compare (x, abs(x));
@c ===end===
@example
(%i1) compare (1, 2);
(%o1)                           <
(%i2) compare (1, x);
(%o2)                        unknown
(%i3) compare (%i, %i);
(%o3)                           =
(%i4) compare (%i, %i + 1);
(%o4)                     notcomparable
(%i5) compare (1/x, 0);
(%o5)                           #
(%i6) compare (x, abs(x));
(%o6)                          <=
@end example

The function @code{compare} doesn't try to determine whether the real domains of
its arguments are nonempty; thus

@c ===beg===
@c compare (acos (x^2 + 1), acos (x^2 + 1) + 1);
@c ===end===
@example
(%i1) compare (acos (x^2 + 1), acos (x^2 + 1) + 1);
(%o1)                           <
@end example

@c IT IS NOT QUITE TRUE, WHAT ABOUT x=0 ?
The real domain of @code{acos (x^2 + 1)} is empty.

@opencatbox
@category{Declarations and inferences}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{equal}
@deffn {Function} equal (@var{a}, @var{b})

Represents equivalence, that is, equal value.

By itself, @code{equal} does not evaluate or simplify.
The function @mref{is} attempts to evaluate @code{equal} to a Boolean value.
@code{is(equal(@var{a}, @var{b}))} returns @code{true} (or @code{false}) if
and only if @var{a} and @var{b} are equal (or not equal) for all possible
values of their variables, as determined by evaluating
@code{ratsimp(@var{a} - @var{b})}; if @mref{ratsimp} returns 0, the two
expressions are considered equivalent.  Two expressions may be equivalent even
if they are not syntactically equal (i.e., identical).

When @code{is} fails to reduce @code{equal} to @code{true} or @code{false}, the
result is governed by the global flag @mrefdot{prederror}  When @code{prederror}
is @code{true}, @code{is} complains with an error message.  Otherwise, @code{is}
returns @code{unknown}.

In addition to @code{is}, some other operators evaluate @code{equal} and
@code{notequal} to @code{true} or @code{false}, namely @mrefcomma{if}@w{}
@mrefcomma{and} @mrefcomma{or} and @mrefdot{not}

@c FOLLOWING STATEMENT IS MORE OR LESS TRUE BUT I DON'T THINK THE DETAILS ARE CORRECT
@c Declarations (integer, complex, etc)
@c for variables appearing in @var{a} and @var{b} are ignored by @code{equal}.
@c All variables are effectively assumed to be real-valued.

The negation of @code{equal} is @mrefdot{notequal}

Examples:

By itself, @code{equal} does not evaluate or simplify.

@c ===beg===
@c equal (x^2 - 1, (x + 1) * (x - 1));
@c equal (x, x + 1);
@c equal (x, y);
@c ===end===
@example
(%i1) equal (x^2 - 1, (x + 1) * (x - 1));
                        2
(%o1)            equal(x  - 1, (x - 1) (x + 1))
(%i2) equal (x, x + 1);
(%o2)                    equal(x, x + 1)
(%i3) equal (x, y);
(%o3)                      equal(x, y)
@end example

The function @code{is} attempts to evaluate @code{equal} to a Boolean value.
@code{is(equal(@var{a}, @var{b}))} returns @code{true} when
@code{ratsimp(@var{a} - @var{b})} returns 0.  Two expressions may be equivalent
even if they are not syntactically equal (i.e., identical).

@c ===beg===
@c ratsimp (x^2 - 1 - (x + 1) * (x - 1));
@c is (equal (x^2 - 1, (x + 1) * (x - 1)));
@c is (x^2 - 1 = (x + 1) * (x - 1));
@c ratsimp (x - (x + 1));
@c is (equal (x, x + 1));
@c is (x = x + 1);
@c ratsimp (x - y);
@c is (equal (x, y));
@c is (x = y);
@c ===end===
@example
(%i1) ratsimp (x^2 - 1 - (x + 1) * (x - 1));
(%o1)                           0
(%i2) is (equal (x^2 - 1, (x + 1) * (x - 1)));
(%o2)                         true
(%i3) is (x^2 - 1 = (x + 1) * (x - 1));
(%o3)                         false
(%i4) ratsimp (x - (x + 1));
(%o4)                          - 1
(%i5) is (equal (x, x + 1));
(%o5)                         false
(%i6) is (x = x + 1);
(%o6)                         false
(%i7) ratsimp (x - y);
(%o7)                         x - y
(%i8) is (equal (x, y));
(%o8)                        unknown
(%i9) is (x = y);
(%o9)                         false
@end example

When @code{is} fails to reduce @code{equal} to @code{true} or @code{false},
the result is governed by the global flag @code{prederror}.

@c ===beg===
@c [aa : x^2 + 2*x + 1, bb : x^2 - 2*x - 1];
@c ratsimp (aa - bb);
@c prederror : true;
@c is (equal (aa, bb));
@c prederror : false;
@c is (equal (aa, bb));
@c ===end===
@example
(%i1) [aa : x^2 + 2*x + 1, bb : x^2 - 2*x - 1];
                    2             2
(%o1)             [x  + 2 x + 1, x  - 2 x - 1]
(%i2) ratsimp (aa - bb);
(%o2)                        4 x + 2
(%i3) prederror : true;
(%o3)                         true
(%i4) is (equal (aa, bb));
Maxima was unable to evaluate the predicate:
       2             2
equal(x  + 2 x + 1, x  - 2 x - 1)
 -- an error.  Quitting.  To debug this try debugmode(true);
(%i5) prederror : false;
(%o5)                         false
(%i6) is (equal (aa, bb));
(%o6)                        unknown
@end example

Some operators evaluate @code{equal} and @code{notequal} to @code{true} or
@code{false}.

@c ===beg===
@c if equal (y, y - 1) then FOO else BAR;
@c eq_1 : equal (x, x + 1);
@c eq_2 : equal (y^2 + 2*y + 1, (y + 1)^2);
@c [eq_1 and eq_2, eq_1 or eq_2, not eq_1];
@c ===end===
@example
(%i1) if equal (y, y - 1) then FOO else BAR;
(%o1)                          BAR
(%i2) eq_1 : equal (x, x + 1);
(%o2)                    equal(x, x + 1)
(%i3) eq_2 : equal (y^2 + 2*y + 1, (y + 1)^2);
                         2                   2
(%o3)             equal(y  + 2 y + 1, (y + 1) )
(%i4) [eq_1 and eq_2, eq_1 or eq_2, not eq_1];
(%o4)                  [false, true, true]
@end example

Because @code{not @var{expr}} causes evaluation of @var{expr},
@code{not equal(@var{a}, @var{b})} is equivalent to
@code{is(notequal(@var{a}, @var{b}))}.

@c ===beg===
@c [notequal (2*z, 2*z - 1), not equal (2*z, 2*z - 1)];
@c is (notequal (2*z, 2*z - 1));
@c ===end===
@example
(%i1) [notequal (2*z, 2*z - 1), not equal (2*z, 2*z - 1)];
(%o1)            [notequal(2 z, 2 z - 1), true]
(%i2) is (notequal (2*z, 2*z - 1));
(%o2)                         true
@end example

@opencatbox
@category{Operators}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{notequal}
@deffn {Function} notequal (@var{a}, @var{b})

Represents the negation of @code{equal(@var{a}, @var{b})}.

Examples:

@c ===beg===
@c equal (a, b);
@c maybe (equal (a, b));
@c notequal (a, b);
@c not equal (a, b);
@c maybe (notequal (a, b));
@c assume (a > b);
@c equal (a, b);
@c maybe (equal (a, b));
@c notequal (a, b);
@c maybe (notequal (a, b));
@c ===end===
@example
(%i1) equal (a, b);
(%o1)                      equal(a, b)
(%i2) maybe (equal (a, b));
(%o2)                        unknown
(%i3) notequal (a, b);
(%o3)                    notequal(a, b)
(%i4) not equal (a, b);
(%o4)                    notequal(a, b)
(%i5) maybe (notequal (a, b));
(%o5)                        unknown
(%i6) assume (a > b);
(%o6)                        [a > b]
(%i7) equal (a, b);
(%o7)                      equal(a, b)
(%i8) maybe (equal (a, b));
(%o8)                         false
(%i9) notequal (a, b);
(%o9)                    notequal(a, b)
(%i10) maybe (notequal (a, b));
(%o10)                        true
@end example

@opencatbox
@category{Operators}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{unknown}
@deffn {Function} unknown (@var{expr})

Returns @code{true} if and only if @var{expr} contains an operator or function
not recognized by the Maxima simplifier.

@opencatbox
@category{Predicate functions} @category{Simplification functions}
@closecatbox
@end deffn

@c THIS FUNCTION APPEARS TO BE A HACK; SEE 4'TH ITEM BELOW
@c DUNNO WHETHER WE CAN CLEAR THIS UP

@c -----------------------------------------------------------------------------
@anchor{zeroequiv}
@deffn {Function} zeroequiv (@var{expr}, @var{v})

Tests whether the expression @var{expr} in the variable @var{v} is equivalent
to zero, returning @code{true}, @code{false}, or @code{dontknow}.

@code{zeroequiv} has these restrictions:

@enumerate
@item
Do not use functions that Maxima does not know how to
differentiate and evaluate.
@item
If the expression has poles on the real line, there may be errors
in the result (but this is unlikely to occur).
@item
If the expression contains functions which are not solutions to first order
differential equations (e.g. Bessel functions) there may be incorrect results.
@item
The algorithm uses evaluation at randomly chosen points for carefully selected
subexpressions.  This is always a somewhat hazardous business, although the
algorithm tries to minimize the potential for error.
@end enumerate

For example @code{zeroequiv (sin(2 * x) - 2 * sin(x) * cos(x), x)} returns
@code{true} and @code{zeroequiv (%e^x + x, x)} returns @code{false}.
On the other hand @code{zeroequiv (log(a * b) - log(a) - log(b), a)} returns 
@code{dontknow} because of the presence of an extra parameter @code{b}.

@opencatbox
@category{Predicate functions}
@closecatbox
@end deffn

