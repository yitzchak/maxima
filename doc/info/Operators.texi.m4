@c -*- Mode: texinfo -*-
@menu     
* Introduction to operators::      
* Arithmetic operators::
* Relational operators::
* Logical operators::
* Operators for Equations::
* Assignment operators::
* User defined operators::
@end menu

@c -----------------------------------------------------------------------------
@node Introduction to operators, Arithmetic operators, Operators, Operators
@section Introduction to operators
@c -----------------------------------------------------------------------------

It is possible to define new operators with specified precedence, to undefine
existing operators, or to redefine the precedence of existing operators.  An
operator may be unary prefix or unary postfix, binary infix, n-ary infix,
matchfix, or nofix.  "Matchfix" means a pair of symbols which enclose their
argument or arguments, and "nofix" means an operator which takes no arguments.
As examples of the different types of operators, there are the following.

@table @asis
@item unary prefix
negation @code{- a}
@item unary postfix
factorial @code{a!}
@item binary infix
exponentiation @code{a^b}
@item n-ary infix
addition @code{a + b}
@item matchfix
list construction @code{[a, b]}
@end table

(There are no built-in nofix operators; for an example of such an operator,
see @code{nofix}.)

The mechanism to define a new operator is straightforward.  It is only necessary
to declare a function as an operator; the operator function might or might not
be defined.

An example of user-defined operators is the following.  Note that the explicit
function call @code{"dd" (a)} is equivalent to @code{dd a}, likewise
@code{"<-" (a, b)} is equivalent to @code{a <- b}.  Note also that the functions
@code{"dd"} and @code{"<-"} are undefined in this example.

@c ===beg===
@c prefix ("dd");
@c dd a;
@c "dd" (a);
@c infix ("<-");
@c a <- dd b;
@c "<-" (a, "dd" (b));
@c ===end===
@example
(%i1) prefix ("dd");
(%o1)                          dd
(%i2) dd a;
(%o2)                         dd a
(%i3) "dd" (a);
(%o3)                         dd a
(%i4) infix ("<-");
(%o4)                          <-
(%i5) a <- dd b;
(%o5)                      a <- dd b
(%i6) "<-" (a, "dd" (b));
(%o6)                      a <- dd b
@end example

The Maxima functions which define new operators are summarized in this table,
stating the default left and right binding powers (lbp and rbp, respectively).
@c REWORK FOLLOWING COMMENT.
@c IT'S NOT CLEAR ENOUGH, GIVEN THAT IT'S FAIRLY IMPORTANT
(Binding power determines operator precedence.  However, since left and right
binding powers can differ, binding power is somewhat more complicated than
precedence.) Some of the operation definition functions take additional
arguments; see the function descriptions for details.

@c MAKE ANCHORS FOR ALL 6 FUNCTIONS AND CHANGE @code TO @ref ACCORDINGLY
@table @code
@item prefix
rbp=180
@item postfix
lbp=180
@item infix
lbp=180, rbp=180
@item nary
lbp=180, rbp=180
@item matchfix
(binding power not applicable)
@item nofix
(binding power not applicable)
@end table

For comparison, here are some built-in operators and their left and right
binding powers.

@example
Operator   lbp     rbp

  :        180     20 
  ::       180     20 
  :=       180     20 
  ::=      180     20 
  !        160
  !!       160
  ^        140     139 
  .        130     129 
  *        120
  /        120     120 
  +        100     100 
  -        100     134 
  =        80      80 
  #        80      80 
  >        80      80 
  >=       80      80 
  <        80      80 
  <=       80      80 
  not              70 
  and      65
  or       60
  ,        10
  $        -1
  ;        -1
@end example

@mref{remove} and @mref{kill} remove operator properties from an atom.
@code{remove ("@var{a}", op)} removes only the operator properties of @var{a}.
@code{kill ("@var{a}")} removes all properties of @var{a}, including the
operator properties.  Note that the name of the operator must be enclosed in
quotation marks.

@c MAYBE COPY THIS EXAMPLE TO remove AND/OR kill
@c ===beg===
@c infix ("##");
@c "##" (a, b) := a^b;
@c 5 ## 3;
@c remove ("##", op);
@c 5 ## 3;
@c "##" (5, 3);
@c infix ("##");
@c 5 ## 3;
@c kill ("##");
@c 5 ## 3;
@c "##" (5, 3);
@c ===end===
@example
(%i1) infix ("##");
(%o1)                          ##
(%i2) "##" (a, b) := a^b;
                                     b
(%o2)                     a ## b := a
(%i3) 5 ## 3;
(%o3)                          125
(%i4) remove ("##", op);
(%o4)                         done
(%i5) 5 ## 3;
Incorrect syntax: # is not a prefix operator
5 ##
  ^
(%i5) "##" (5, 3);
(%o5)                          125
(%i6) infix ("##");
(%o6)                          ##
(%i7) 5 ## 3;
(%o7)                          125
(%i8) kill ("##");
(%o8)                         done
(%i9) 5 ## 3;
Incorrect syntax: # is not a prefix operator
5 ##
  ^
(%i9) "##" (5, 3);
(%o9)                       ##(5, 3)
@end example

@opencatbox
@category{Operators} @category{Syntax}
@closecatbox

@c -----------------------------------------------------------------------------
@node Arithmetic operators, Relational operators, Introduction to operators, Operators
@section Arithmetic operators
@c -----------------------------------------------------------------------------

@c -----------------------------------------------------------------------------
@anchor{+}
@anchor{-}
@anchor{*}
@anchor{/}
@anchor{^}
@fnindex Addition
@fnindex Subtraction
@fnindex Multiplication
@fnindex Division
@fnindex Exponentiation

@deffn {Operator} +
@deffnx {Operator} -
@deffnx {Operator} *
@deffnx {Operator} /
@deffnx {Operator} ^

The symbols @code{+} @code{*} @code{/} and @code{^} represent addition,
multiplication, division, and exponentiation, respectively.  The names of these
operators are @code{"+"} @code{"*"} @code{"/"} and @code{"^"}, which may appear
where the name of a function or operator is required.

The symbols @code{+} and @code{-} represent unary addition and negation,
respectively, and the names of these operators are @code{"+"} and @code{"-"},
respectively.

Subtraction @code{a - b} is represented within Maxima as addition,
@code{a + (- b)}.  Expressions such as @code{a + (- b)} are displayed as
subtraction.  Maxima recognizes @code{"-"} only as the name of the unary
negation operator, and not as the name of the binary subtraction operator.

Division @code{a / b} is represented within Maxima as multiplication,
@code{a * b^(- 1)}.  Expressions such as @code{a * b^(- 1)} are displayed as
division.  Maxima recognizes @code{"/"} as the name of the division operator.

Addition and multiplication are n-ary, commutative operators.
Division and exponentiation are binary, noncommutative operators.

Maxima sorts the operands of commutative operators to construct a canonical
representation.  For internal storage, the ordering is determined by
@mrefdot{orderlessp}  For display, the ordering for addition is determined by
@mrefcomma{ordergreatp} and for multiplication, it is the same as the internal
ordering.

Arithmetic computations are carried out on literal numbers (integers, rationals,
ordinary floats, and bigfloats).  Except for exponentiation, all arithmetic
operations on numbers are simplified to numbers.  Exponentiation is simplified
to a number if either operand is an ordinary float or bigfloat or if the result
is an exact integer or rational; otherwise an exponentiation may be simplified
to @mref{sqrt} or another exponentiation or left unchanged.

Floating-point contagion applies to arithmetic computations: if any operand is
a bigfloat, the result is a bigfloat; otherwise, if any operand is an ordinary
float, the result is an ordinary float; otherwise, the operands are rationals
or integers and the result is a rational or integer.

Arithmetic computations are a simplification, not an evaluation.
Thus arithmetic is carried out in quoted (but simplified) expressions.

Arithmetic operations are applied element-by-element to lists when the global
flag @mref{listarith} is @code{true}, and always applied element-by-element to
matrices.  When one operand is a list or matrix and another is an operand of
some other type, the other operand is combined with each of the elements of the
list or matrix.

Examples:

Addition and multiplication are n-ary, commutative operators.
Maxima sorts the operands to construct a canonical representation.
The names of these operators are @code{"+"} and @code{"*"}.

@c ===beg===
@c c + g + d + a + b + e + f;
@c [op (%), args (%)];
@c c * g * d * a * b * e * f;
@c [op (%), args (%)];
@c apply ("+", [a, 8, x, 2, 9, x, x, a]);
@c apply ("*", [a, 8, x, 2, 9, x, x, a]);
@c ===end===
@example
(%i1) c + g + d + a + b + e + f;
(%o1)               g + f + e + d + c + b + a
(%i2) [op (%), args (%)];
(%o2)              [+, [g, f, e, d, c, b, a]]
(%i3) c * g * d * a * b * e * f;
(%o3)                     a b c d e f g
(%i4) [op (%), args (%)];
(%o4)              [*, [a, b, c, d, e, f, g]]
(%i5) apply ("+", [a, 8, x, 2, 9, x, x, a]);
(%o5)                    3 x + 2 a + 19
(%i6) apply ("*", [a, 8, x, 2, 9, x, x, a]);
                                 2  3
(%o6)                       144 a  x
@end example

Division and exponentiation are binary, noncommutative operators.
The names of these operators are @code{"/"} and @code{"^"}.

@c ===beg===
@c [a / b, a ^ b];
@c [map (op, %), map (args, %)];
@c [apply ("/", [a, b]), apply ("^", [a, b])];
@c ===end===
@example
(%i1) [a / b, a ^ b];
                              a   b
(%o1)                        [-, a ]
                              b
(%i2) [map (op, %), map (args, %)];
(%o2)              [[/, ^], [[a, b], [a, b]]]
(%i3) [apply ("/", [a, b]), apply ("^", [a, b])];
                              a   b
(%o3)                        [-, a ]
                              b
@end example

Subtraction and division are represented internally
in terms of addition and multiplication, respectively.

@c ===beg===
@c [inpart (a - b, 0), inpart (a - b, 1), inpart (a - b, 2)];
@c [inpart (a / b, 0), inpart (a / b, 1), inpart (a / b, 2)];
@c ===end===
@example
(%i1) [inpart (a - b, 0), inpart (a - b, 1), inpart (a - b, 2)];
(%o1)                      [+, a, - b]
(%i2) [inpart (a / b, 0), inpart (a / b, 1), inpart (a / b, 2)];
                                   1
(%o2)                       [*, a, -]
                                   b
@end example

Computations are carried out on literal numbers.
Floating-point contagion applies.

@c ===beg===
@c 17 + b - (1/2)*29 + 11^(2/4);
@c [17 + 29, 17 + 29.0, 17 + 29b0];
@c ===end===
@example
(%i1) 17 + b - (1/2)*29 + 11^(2/4);
                                       5
(%o1)                   b + sqrt(11) + -
                                       2
(%i2) [17 + 29, 17 + 29.0, 17 + 29b0];
(%o2)                   [46, 46.0, 4.6b1]
@end example

Arithmetic computations are a simplification, not an evaluation.

@c ===beg===
@c simp : false;
@c '(17 + 29*11/7 - 5^3);
@c simp : true;
@c '(17 + 29*11/7 - 5^3);
@c ===end===
@example
(%i1) simp : false;
(%o1)                         false
(%i2) '(17 + 29*11/7 - 5^3);
                              29 11    3
(%o2)                    17 + ----- - 5
                                7
(%i3) simp : true;
(%o3)                         true
(%i4) '(17 + 29*11/7 - 5^3);
                                437
(%o4)                         - ---
                                 7
@end example

Arithmetic is carried out element-by-element for lists (depending on
@code{listarith}) and matrices.

@c ===beg===
@c matrix ([a, x], [h, u]) - matrix ([1, 2], [3, 4]);
@c 5 * matrix ([a, x], [h, u]);
@c listarith : false;
@c [a, c, m, t] / [1, 7, 2, 9];
@c [a, c, m, t] ^ x;
@c listarith : true;
@c [a, c, m, t] / [1, 7, 2, 9];
@c [a, c, m, t] ^ x;
@c ===end===
@example
(%i1) matrix ([a, x], [h, u]) - matrix ([1, 2], [3, 4]);
@group
                        [ a - 1  x - 2 ]
(%o1)                   [              ]
                        [ h - 3  u - 4 ]
@end group
(%i2) 5 * matrix ([a, x], [h, u]);
                          [ 5 a  5 x ]
(%o2)                     [          ]
                          [ 5 h  5 u ]
(%i3) listarith : false;
(%o3)                         false
(%i4) [a, c, m, t] / [1, 7, 2, 9];
                          [a, c, m, t]
(%o4)                     ------------
                          [1, 7, 2, 9]
(%i5) [a, c, m, t] ^ x;
                                      x
(%o5)                     [a, c, m, t]
(%i6) listarith : true;
(%o6)                         true
(%i7) [a, c, m, t] / [1, 7, 2, 9];
                              c  m  t
(%o7)                     [a, -, -, -]
                              7  2  9
(%i8) [a, c, m, t] ^ x;
                          x   x   x   x
(%o8)                   [a , c , m , t ]
@end example

@opencatbox
@category{Operators}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{**}
@deffn {Operator} **

Exponentiation operator.
Maxima recognizes @code{**} as the same operator as @mref{^} in input,
and it is displayed as @code{^} in 1-dimensional output,
or by placing the exponent as a superscript in 2-dimensional output.

The @mref{fortran} function displays the exponentiation operator as @code{**},
whether it was input as @code{**} or @code{^}.

Examples:

@c ===beg===
@c is (a**b = a^b);
@c x**y + x^z;
@c string (x**y + x^z);
@c fortran (x**y + x^z);
@c ===end===
@example
(%i1) is (a**b = a^b);
(%o1)                         true
(%i2) x**y + x^z;
                              z    y
(%o2)                        x  + x
(%i3) string (x**y + x^z);
(%o3)                        x^z+x^y
(%i4) fortran (x**y + x^z);
      x**z+x**y
(%o4)                         done
@end example

@opencatbox
@category{Operators}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{^^}
@deffn {Operator} ^^
@ifinfo
@fnindex Noncommutative exponentiation
@end ifinfo

Noncommutative exponentiation operator.
@code{^^} is the exponentiation operator corresponding to noncommutative
multiplication @code{.}, just as the ordinary exponentiation operator @code{^}
corresponds to commutative multiplication @code{*}.

Noncommutative exponentiation is displayed by @code{^^} in 1-dimensional output,
and by placing the exponent as a superscript within angle brackets @code{< >}
in 2-dimensional output.

Examples:

@c ===beg===
@c a . a . b . b . b + a * a * a * b * b;
@c string (a . a . b . b . b + a * a * a * b * b);
@c ===end===
@example
(%i1) a . a . b . b . b + a * a * a * b * b;
                        3  2    <2>    <3>
(%o1)                  a  b  + a    . b
(%i2) string (a . a . b . b . b + a * a * a * b * b);
(%o2)                  a^3*b^2+a^^2 . b^^3
@end example

@opencatbox
@category{Operators}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{.}
@deffn {Operator} .
@ifinfo
@fnindex Noncommutative multiplication
@end ifinfo

The dot operator, for matrix (non-commutative) multiplication.
When @code{"."} is used in this way, spaces should be left on both sides of
it, e.g.  @code{A . B}  This distinguishes it plainly from a decimal point in
a floating point number.

See also
@mrefcomma{Dot}
@mrefcomma{dot0nscsimp}
@mrefcomma{dot0simp}
@mrefcomma{dot1simp}
@mrefcomma{dotassoc}
@mrefcomma{dotconstrules}
@mrefcomma{dotdistrib}
@mrefcomma{dotexptsimp}
@mrefcomma{dotident}
and
@mrefdot{dotscrules}

@opencatbox
@category{Operators}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@node Relational operators, Logical operators, Arithmetic operators, Operators
@section Relational operators
@c -----------------------------------------------------------------------------

@c -----------------------------------------------------------------------------
@anchor{<}
@anchor{<=}
@anchor{>=}
@anchor{>}
@fnindex Less than
@fnindex Less than or equal
@fnindex Greater than or equal
@fnindex Greater than

@deffn {Operator} <
@deffnx {Operator} <=
@deffnx {Operator} >=
@deffnx {Operator} >

The symbols @code{<} @code{<=} @code{>=} and @code{>} represent less than, less
than or equal, greater than or equal, and greater than, respectively.  The names
of these operators are @code{"<"} @code{"<="} @code{">="} and @code{">"}, which
may appear where the name of a function or operator is required.

These relational operators are all binary operators; constructs such as
@code{a < b < c} are not recognized by Maxima.

Relational expressions are evaluated to Boolean values by the functions
@mref{is} and @mrefcomma{maybe} and the programming constructs
@mrefcomma{if} @mrefcomma{while} and @mrefdot{unless}  Relational expressions
are not otherwise evaluated or simplified to Boolean values, although the
arguments of relational expressions are evaluated (when evaluation is not
otherwise prevented by quotation).

When a relational expression cannot be evaluated to @code{true} or @code{false},
the behavior of @code{is} and @code{if} are governed by the global flag
@mrefdot{prederror}  When @code{prederror} is @code{true}, @code{is} and
@code{if} trigger an error.  When @code{prederror} is @code{false}, @code{is}
returns @code{unknown}, and @code{if} returns a partially-evaluated conditional
expression.

@code{maybe} always behaves as if @code{prederror} were @code{false}, and
@code{while} and @code{unless} always behave as if @code{prederror} were
@code{true}.

Relational operators do not distribute over lists or other aggregates.

See also @mrefcomma{=} @mrefcomma{#} @mrefcomma{equal} and @mrefdot{notequal}

Examples:

Relational expressions are evaluated to Boolean values by some functions and
programming constructs.

@c ===beg===
@c [x, y, z] : [123, 456, 789];
@c is (x < y);
@c maybe (y > z);
@c if x >= z then 1 else 0;
@c block ([S], S : 0, for i:1 while i <= 100 do S : S + i, 
@c        return (S));
@c ===end===
@example
(%i1) [x, y, z] : [123, 456, 789];
(%o1)                    [123, 456, 789]
(%i2) is (x < y);
(%o2)                         true
(%i3) maybe (y > z);
(%o3)                         false
(%i4) if x >= z then 1 else 0;
(%o4)                           0
(%i5) block ([S], S : 0, for i:1 while i <= 100 do S : S + i, 
             return (S));
(%o5)                         5050
@end example

Relational expressions are not otherwise evaluated or simplified to Boolean
values, although the arguments of relational expressions are evaluated.

@c ===beg===
@c [x, y, z] : [123, 456, 789];
@c [x < y, y <= z, z >= y, y > z];
@c map (is, %);
@c ===end===
@example
(%o1)                    [123, 456, 789]
(%i2) [x < y, y <= z, z >= y, y > z];
(%o2)    [123 < 456, 456 <= 789, 789 >= 456, 456 > 789]
(%i3) map (is, %);
(%o3)               [true, true, true, false]
@end example

@opencatbox
@category{Operators}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@node Logical operators, Operators for Equations, Relational operators, Operators
@section Logical operators
@c -----------------------------------------------------------------------------

@c NEEDS EXAMPLES

@c -----------------------------------------------------------------------------
@anchor{and}
@deffn {Operator} and
@ifinfo
@fnindex Logical conjunction
@end ifinfo

The logical conjunction operator.  @code{and} is an n-ary infix operator;
its operands are Boolean expressions, and its result is a Boolean value.

@code{and} forces evaluation (like @mref{is}) of one or more operands,
and may force evaluation of all operands.

Operands are evaluated in the order in which they appear.  @code{and} evaluates
only as many of its operands as necessary to determine the result.  If any
operand is @code{false}, the result is @code{false} and no further operands are
evaluated.

The global flag @mref{prederror} governs the behavior of @code{and} when an
evaluated operand cannot be determined to be @code{true} or @code{false}.
@code{and} prints an error message when @code{prederror} is @code{true}.
Otherwise, operands which do not evaluate to @code{true} or @code{false} are
accepted, and the result is a Boolean expression.

@code{and} is not commutative: @code{a and b} might not be equal to
@code{b and a} due to the treatment of indeterminate operands.

@opencatbox
@category{Operators}
@closecatbox
@end deffn

@c NEEDS EXAMPLES

@c -----------------------------------------------------------------------------
@anchor{not}
@deffn {Operator} not
@ifinfo
@fnindex Logical negation
@end ifinfo

The logical negation operator.  @code{not} is a prefix operator;
its operand is a Boolean expression, and its result is a Boolean value.

@code{not} forces evaluation (like @code{is}) of its operand.

The global flag @mref{prederror} governs the behavior of @code{not} when its
operand cannot be determined to be @code{true} or @code{false}.  @code{not}
prints an error message when @code{prederror} is @code{true}.  Otherwise,
operands which do not evaluate to @code{true} or @code{false} are accepted,
and the result is a Boolean expression.

@opencatbox
@category{Operators}
@closecatbox
@end deffn

@c NEEDS EXAMPLES

@c -----------------------------------------------------------------------------
@anchor{or}
@deffn {Operator} or
@ifinfo
@fnindex Logical disjunction
@end ifinfo

The logical disjunction operator.  @code{or} is an n-ary infix operator;
its operands are Boolean expressions, and its result is a Boolean value.

@code{or} forces evaluation (like @mref{is}) of one or more operands,
and may force evaluation of all operands.

Operands are evaluated in the order in which they appear.  @code{or} evaluates
only as many of its operands as necessary to determine the result.  If any
operand is @code{true}, the result is @code{true} and no further operands are
evaluated.

The global flag @mref{prederror} governs the behavior of @code{or} when an
evaluated operand cannot be determined to be @code{true} or @code{false}.
@code{or} prints an error message when @code{prederror} is @code{true}.
Otherwise, operands which do not evaluate to @code{true} or @code{false} are
accepted, and the result is a Boolean expression.

@code{or} is not commutative: @code{a or b} might not be equal to @code{b or a}
due to the treatment of indeterminate operands.

@opencatbox
@category{Operators}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@node Operators for Equations, Assignment operators, Logical operators, Operators
@section Operators for Equations
@c -----------------------------------------------------------------------------

@c -----------------------------------------------------------------------------
@anchor{#}
@deffn {Operator} #
@ifinfo
@fnindex Not equal (syntactic inequality)
@end ifinfo

Represents the negation of syntactic equality @mrefdot{=}

Note that because of the rules for evaluation of predicate expressions
(in particular because @code{not @var{expr}} causes evaluation of @var{expr}),
@code{not @var{a} = @var{b}} is equivalent to @code{is(@var{a} # @var{b})},
instead of @code{@var{a} # @var{b}}.

Examples:

@c ===beg===
@c a = b;
@c is (a = b);
@c a # b;
@c not a = b;
@c is (a # b);
@c is (not a = b);
@c ===end===
@example
(%i1) a = b;
(%o1)                         a = b
(%i2) is (a = b);
(%o2)                         false
(%i3) a # b;
(%o3)                         a # b
(%i4) not a = b;
(%o4)                         true
(%i5) is (a # b);
(%o5)                         true
(%i6) is (not a = b);
(%o6)                         true
@end example

@opencatbox
@category{Operators}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{=}
@deffn {Operator} =
@ifinfo
@fnindex Equation operator
@fnindex Equal (syntactic equality)
@end ifinfo

The equation operator.

An expression @code{@var{a} = @var{b}}, by itself, represents an unevaluated
equation, which might or might not hold.  Unevaluated equations may appear as
arguments to @mref{solve} and @mref{algsys} or some other functions.

The function @mref{is} evaluates @code{=} to a Boolean value.
@code{is(@var{a} = @var{b})} evaluates @code{@var{a} = @var{b}} to @code{true}
when @var{a} and @var{b} are identical.  That is, @var{a} and @var{b} are atoms
which are identical, or they are not atoms and their operators are identical and
their arguments are identical.  Otherwise, @code{is(@var{a} = @var{b})}
evaluates to @code{false}; it never evaluates to @code{unknown}.  When
@code{is(@var{a} = @var{b})} is @code{true}, @var{a} and @var{b} are said to be
syntactically equal, in contrast to equivalent expressions, for which
@code{is(equal(@var{a}, @var{b}))} is @code{true}.  Expressions can be
equivalent and not syntactically equal.

The negation of @code{=} is represented by @mrefdot{#}
As with @code{=}, an expression @code{@var{a} # @var{b}}, by itself, is not
evaluated.  @code{is(@var{a} # @var{b})} evaluates @code{@var{a} # @var{b}} to
@code{true} or @code{false}.

In addition to @code{is}, some other operators evaluate @code{=} and @code{#}
to @code{true} or @code{false}, namely @mrefcomma{if} @mrefcomma{and}@w{}
@mrefcomma{or} and @mrefdot{not}

Note that because of the rules for evaluation of predicate expressions
(in particular because @code{not @var{expr}} causes evaluation of @var{expr}),
@code{not @var{a} = @var{b}} is equivalent to @code{is(@var{a} # @var{b})},
instead of @code{@var{a} # @var{b}}.

@mref{rhs} and @mref{lhs} return the right-hand and left-hand sides,
respectively, of an equation or inequation.

See also @mref{equal} and @mrefdot{notequal}

Examples:

An expression @code{@var{a} = @var{b}}, by itself, represents
an unevaluated equation, which might or might not hold.

@c ===beg===
@c eq_1 : a * x - 5 * y = 17;
@c eq_2 : b * x + 3 * y = 29;
@c solve ([eq_1, eq_2], [x, y]);
@c subst (%, [eq_1, eq_2]);
@c ratsimp (%);
@c ===end===
@example
(%i1) eq_1 : a * x - 5 * y = 17;
(%o1)                    a x - 5 y = 17
(%i2) eq_2 : b * x + 3 * y = 29;
(%o2)                    3 y + b x = 29
(%i3) solve ([eq_1, eq_2], [x, y]);
                        196         29 a - 17 b
(%o3)          [[x = ---------, y = -----------]]
                     5 b + 3 a       5 b + 3 a
(%i4) subst (%, [eq_1, eq_2]);
@group
         196 a     5 (29 a - 17 b)
(%o4) [--------- - --------------- = 17, 
       5 b + 3 a      5 b + 3 a
                                  196 b     3 (29 a - 17 b)
                                --------- + --------------- = 29]
                                5 b + 3 a      5 b + 3 a
@end group
(%i5) ratsimp (%);
(%o5)                  [17 = 17, 29 = 29]
@end example

@code{is(@var{a} = @var{b})} evaluates @code{@var{a} = @var{b}} to @code{true}
when @var{a} and @var{b} are syntactically equal (that is, identical).
Expressions can be equivalent and not syntactically equal.

@c ===beg===
@c a : (x + 1) * (x - 1);
@c b : x^2 - 1;
@c [is (a = b), is (a # b)];
@c [is (equal (a, b)), is (notequal (a, b))];
@c ===end===
@example
(%i1) a : (x + 1) * (x - 1);
(%o1)                    (x - 1) (x + 1)
(%i2) b : x^2 - 1;
                              2
(%o2)                        x  - 1
(%i3) [is (a = b), is (a # b)];
(%o3)                     [false, true]
(%i4) [is (equal (a, b)), is (notequal (a, b))];
(%o4)                     [true, false]
@end example

Some operators evaluate @code{=} and @code{#} to @code{true} or @code{false}.

@c ===beg===
@c if expand ((x + y)^2) = x^2 + 2 * x * y + y^2 then FOO else 
@c       BAR;
@c eq_3 : 2 * x = 3 * x;
@c eq_4 : exp (2) = %e^2;
@c [eq_3 and eq_4, eq_3 or eq_4, not eq_3];
@c ===end===
@example
(%i1) if expand ((x + y)^2) = x^2 + 2 * x * y + y^2 then FOO else
      BAR;
(%o1)                          FOO
(%i2) eq_3 : 2 * x = 3 * x;
(%o2)                       2 x = 3 x
(%i3) eq_4 : exp (2) = %e^2;
                              2     2
(%o3)                       %e  = %e
(%i4) [eq_3 and eq_4, eq_3 or eq_4, not eq_3];
(%o4)                  [false, true, true]
@end example

Because @code{not @var{expr}} causes evaluation of @var{expr},
@code{not @var{a} = @var{b}} is equivalent to @code{is(@var{a} # @var{b})}.

@c ===beg===
@c [2 * x # 3 * x, not (2 * x = 3 * x)];
@c is (2 * x # 3 * x);
@c ===end===
@example
(%i1) [2 * x # 3 * x, not (2 * x = 3 * x)];
(%o1)                   [2 x # 3 x, true]
(%i2) is (2 * x # 3 * x);
(%o2)                         true
@end example

@opencatbox
@category{Operators}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@node Assignment operators, User defined operators, Operators for Equations, Operators
@section Assignment operators
@c -----------------------------------------------------------------------------

@c -----------------------------------------------------------------------------
@anchor{:}
@deffn {Operator} :
@ifinfo
@fnindex Assignment operator
@end ifinfo

Assignment operator.

When the left-hand side is a simple variable (not subscripted), @code{:}
evaluates its right-hand side and associates that value with the left-hand side.

When the left-hand side is a subscripted element of a list, matrix, declared
Maxima array, or Lisp array, the right-hand side is assigned to that element.
The subscript must name an existing element; such objects cannot be extended by
naming nonexistent elements.

When the left-hand side is a subscripted element of a @mrefcomma{hashed array}
the right-hand side is assigned to that element, if it already exists,
or a new element is allocated, if it does not already exist.

When the left-hand side is a list of simple and/or subscripted variables, the
right-hand side must evaluate to a list, and the elements of the right-hand
side are assigned to the elements of the left-hand side, in parallel.

See also @mref{kill} and @mrefcomma{remvalue} which undo the association between
the left-hand side and its value.

Examples:

Assignment to a simple variable.

@c ===beg===
@c a;
@c a : 123;
@c a;
@c ===end===
@example
(%i1) a;
(%o1)                           a
(%i2) a : 123;
(%o2)                          123
(%i3) a;
(%o3)                          123
@end example

Assignment to an element of a list.

@c ===beg===
@c b : [1, 2, 3];
@c b[3] : 456;
@c b;
@c ===end===
@example
(%i1) b : [1, 2, 3];
(%o1)                       [1, 2, 3]
(%i2) b[3] : 456;
(%o2)                          456
(%i3) b;
(%o3)                      [1, 2, 456]
@end example

Assignment to a variable that neither is the name of a list nor of an array
creates a @mrefdot{hashed array}

@c ===beg===
@c c[99] : 789;
@c c[99];
@c c;
@c arrayinfo (c);
@c listarray (c);
@c ===end===
@example
(%i1) c[99] : 789;
(%o1)                          789
(%i2) c[99];
(%o2)                          789
(%i3) c;
(%o3)                           c
(%i4) arrayinfo (c);
(%o4)                   [hashed, 1, [99]]
(%i5) listarray (c);
(%o5)                         [789]
@end example

Multiple assignment.

@c ===beg===
@c [a, b, c] : [45, 67, 89];
@c a;
@c b;
@c c;
@c ===end===
@example
(%i1) [a, b, c] : [45, 67, 89];
(%o1)                     [45, 67, 89]
(%i2) a;
(%o2)                          45
(%i3) b;
(%o3)                          67
(%i4) c;
(%o4)                          89
@end example

Multiple assignment is carried out in parallel.
The values of @code{a} and @code{b} are exchanged in this example.

@c ===beg===
@c [a, b] : [33, 55];
@c [a, b] : [b, a];
@c a;
@c b;
@c ===end===
@example
(%i1) [a, b] : [33, 55];
(%o1)                       [33, 55]
(%i2) [a, b] : [b, a];
(%o2)                       [55, 33]
(%i3) a;
(%o3)                          55
(%i4) b;
(%o4)                          33
@end example

@opencatbox
@category{Evaluation} @category{Operators}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@need 900
@anchor{::}
@deffn {Operator} ::
@ifinfo
@fnindex Assignment operator (evaluates left-hand side)
@end ifinfo

Assignment operator.

@code{::} is the same as @mref{:} (which see) except that @code{::} evaluates
its left-hand side as well as its right-hand side.

Examples:

@c ===beg===
@c x : 'foo;
@c x :: 123;
@c foo;
@c x : '[a, b, c];
@c x :: [11, 22, 33];
@c a;
@c b;
@c c;
@c ===end===
@example
(%i1) x : 'foo;
(%o1)                          foo
(%i2) x :: 123;
(%o2)                          123
(%i3) foo;
(%o3)                          123
(%i4) x : '[a, b, c];
(%o4)                       [a, b, c]
(%i5) x :: [11, 22, 33];
(%o5)                     [11, 22, 33]
(%i6) a;
(%o6)                          11
(%i7) b;
(%o7)                          22
(%i8) c;
(%o8)                          33
@end example

@opencatbox
@category{Evaluation} @category{Operators}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{::=}
@deffn {Operator} ::=
@ifinfo
@fnindex Macro function definition operator
@end ifinfo

Macro function definition operator.
@code{::=} defines a function (called a "macro" for historical reasons) which
quotes its arguments, and the expression which it returns (called the "macro
expansion") is evaluated in the context from which the macro was called.
A macro function is otherwise the same as an ordinary function.

@mref{macroexpand} returns a macro expansion (without evaluating it).
@code{macroexpand (foo (x))} followed by @code{''%} is equivalent to
@code{foo (x)} when @code{foo} is a macro function.

@code{::=} puts the name of the new macro function onto the global list
@mrefdot{macros}  @mrefcomma{kill} @mrefcomma{remove} and @mref{remfunction}@w{}
unbind macro function definitions and remove names from @code{macros}.

@mref{fundef} or @mref{dispfun} return a macro function definition or assign it
to a label, respectively.

Macro functions commonly contain @mref{buildq} and @mref{splice} expressions to
construct an expression, which is then evaluated.

Examples

A macro function quotes its arguments, so message (1) shows @code{y - z}, not
the value of @code{y - z}.  The macro expansion (the quoted expression
@code{'(print ("(2) x is equal to", x))}) is evaluated in the context from which
the macro was called, printing message (2).

@c ===beg===
@c x: %pi$
@c y: 1234$
@c z: 1729 * w$
@c printq1 (x) ::= block (print ("(1) x is equal to", x), 
@c                                 '(print ("(2) x is equal to", x)))$
@c printq1 (y - z);
@c ===end===
@example
(%i1) x: %pi$
(%i2) y: 1234$
(%i3) z: 1729 * w$
(%i4) printq1 (x) ::= block (print ("(1) x is equal to", x),
      '(print ("(2) x is equal to", x)))$
(%i5) printq1 (y - z);
(1) x is equal to y - z
(2) x is equal to %pi
(%o5)                                 %pi
@end example

An ordinary function evaluates its arguments, so message (1) shows the value of
@code{y - z}.  The return value is not evaluated, so message (2) is not printed
until the explicit evaluation @code{''%}.

@c ===beg===
@c x: %pi$
@c y: 1234$
@c z: 1729 * w$
@c printe1 (x) := block (print ("(1) x is equal to", x), 
@c       '(print ("(2) x is equal to", x)))$
@c printe1 (y - z);
@c ''%;
@c ===end===
@example
(%i1) x: %pi$
(%i2) y: 1234$
(%i3) z: 1729 * w$
(%i4) printe1 (x) := block (print ("(1) x is equal to", x),
      '(print ("(2) x is equal to", x)))$
(%i5) printe1 (y - z);
(1) x is equal to 1234 - 1729 w
(%o5)                     print((2) x is equal to, x)
(%i6) ''%;
(2) x is equal to %pi
(%o6)                                 %pi
@end example

@code{macroexpand} returns a macro expansion.
@code{macroexpand (foo (x))} followed by @code{''%} is equivalent to
@code{foo (x)} when @code{foo} is a macro function.

@c ===beg===
@c x: %pi$
@c y: 1234$
@c z: 1729 * w$
@c g (x) ::= buildq ([x], print ("x is equal to", x))$
@c macroexpand (g (y - z));
@c ''%;
@c g (y - z);
@c ===end===
@example
(%i1) x: %pi$
(%i2) y: 1234$
(%i3) z: 1729 * w$
(%i4) g (x) ::= buildq ([x], print ("x is equal to", x))$
(%i5) macroexpand (g (y - z));
(%o5)                     print(x is equal to, y - z)
(%i6) ''%;
x is equal to 1234 - 1729 w
(%o6)                            1234 - 1729 w
(%i7) g (y - z);
x is equal to 1234 - 1729 w
(%o7)                            1234 - 1729 w
@end example

@opencatbox
@category{Function definition} @category{Operators}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{:=}
@deffn {Operator} :=
@ifinfo
@fnindex Function definition operator
@end ifinfo

The function definition operator.

@code{@var{f}(@var{x_1}, ..., @var{x_n}) := @var{expr}} defines a function named
@var{f} with arguments @var{x_1}, @dots{}, @var{x_n} and function body
@var{expr}.  @code{:=} never evaluates the function body (unless explicitly
evaluated by quote-quote @code{'@w{}'}).
The function body is evaluated every time the function is called.

@code{@var{f}[@var{x_1}, ..., @var{x_n}] := @var{expr}} defines a so-called
@mrefdot{memoizing function}
Its function body is evaluated just once for each distinct value of its arguments,
and that value is returned, without evaluating the function body,
whenever the arguments have those values again.
(A function of this kind is also known as a ``array function''.)

@code{@var{f}[@var{x_1}, ..., @var{x_n}](@var{y_1}, ..., @var{y_m}) := @var{expr}}
is a special case of a @mrefdot{memoizing function}
@code{@var{f}[@var{x_1}, ..., @var{x_n}]} is a @mref{memoizing function} which returns a lambda expression
with arguments @code{@var{y_1}, ..., @var{y_m}}.
The function body is evaluated once for each distinct value of @code{@var{x_1}, ..., @var{x_n}},
and the body of the lambda expression is that value.

When the last or only function argument @var{x_n} is a list of one element, the
function defined by @code{:=} accepts a variable number of arguments.  Actual
arguments are assigned one-to-one to formal arguments @var{x_1}, @dots{},
@var{x_(n - 1)}, and any further actual arguments, if present, are assigned to
@var{x_n} as a list.

All function definitions appear in the same namespace; defining a function
@code{f} within another function @code{g} does not automatically limit the scope
of @code{f} to @code{g}.  However, @code{local(f)} makes the definition of
function @code{f} effective only within the block or other compound expression
in which @mref{local} appears.

If some formal argument @var{x_k} is a quoted symbol, the function defined by
@code{:=} does not evaluate the corresponding actual argument.  Otherwise all
actual arguments are evaluated.

See also @mref{define} and @mrefdot{::=}

Examples:

@code{:=} never evaluates the function body (unless explicitly evaluated by
quote-quote).

@c ===beg===
@c expr : cos(y) - sin(x);
@c F1 (x, y) := expr;
@c F1 (a, b);
@c F2 (x, y) := ''expr;
@c F2 (a, b);
@c ===end===
@example
(%i1) expr : cos(y) - sin(x);
(%o1)                    cos(y) - sin(x)
(%i2) F1 (x, y) := expr;
(%o2)                   F1(x, y) := expr
(%i3) F1 (a, b);
(%o3)                    cos(y) - sin(x)
(%i4) F2 (x, y) := ''expr;
(%o4)              F2(x, y) := cos(y) - sin(x)
(%i5) F2 (a, b);
(%o5)                    cos(b) - sin(a)
@end example

@code{f(@var{x_1}, ..., @var{x_n}) := ...} defines an ordinary function.

@c ===beg===
@c G1(x, y) := (print ("Evaluating G1 for x=", x, "and y=", y), x.y - y.x);
@c G1([1, a], [2, b]);
@c G1([1, a], [2, b]);
@c ===end===
@example
(%i1) G1(x, y) := (print ("Evaluating G1 for x=", x, "and y=", y), x.y - y.x);
(%o1) G1(x, y) := (print("Evaluating G1 for x=", x, "and y=", 
                                               y), x . y - y . x)
(%i2) G1([1, a], [2, b]);
Evaluating G1 for x= [1, a] and y= [2, b] 
(%o2)                           0
(%i3) G1([1, a], [2, b]);
Evaluating G1 for x= [1, a] and y= [2, b] 
(%o3)                           0
@end example

@code{f[@var{x_1}, ..., @var{x_n}] := ...} defines a @mrefdot{memoizing function}

@c ===beg===
@c G2[a] := (print ("Evaluating G2 for a=", a), a^2);
@c G2[1234];
@c G2[1234];
@c G2[2345];
@c arrayinfo (G2);
@c listarray (G2);
@c ===end===
@example
(%i1) G2[a] := (print ("Evaluating G2 for a=", a), a^2);
                                                     2
(%o1)     G2  := (print("Evaluating G2 for a=", a), a )
            a
(%i2) G2[1234];
Evaluating G2 for a= 1234 
(%o2)                        1522756
(%i3) G2[1234];
(%o3)                        1522756
(%i4) G2[2345];
Evaluating G2 for a= 2345 
(%o4)                        5499025
(%i5) arrayinfo (G2);
(%o5)              [hashed, 1, [1234], [2345]]
(%i6) listarray (G2);
(%o6)                  [1522756, 5499025]
@end example

@code{@var{f}[@var{x_1}, ..., @var{x_n}](@var{y_1}, ..., @var{y_m}) := @var{expr}}
is a special case of a @mrefdot{memoizing function}

@c ===beg===
@c G3[n](x) := (print ("Evaluating G3 for n=", n), diff (sin(x)^2, x, n));
@c G3[2];
@c G3[2];
@c G3[2](1);
@c arrayinfo (G3);
@c listarray (G3);
@c ===end===
@example
(%i1) G3[n](x) := (print ("Evaluating G3 for n=", n), diff (sin(x)^2, x, n));
(%o1) G3 (x) := (print("Evaluating G3 for n=", n), 
        n
                                                     2
                                             diff(sin (x), x, n))
(%i2) G3[2];
Evaluating G3 for n= 2 
                                2           2
(%o2)          lambda([x], 2 cos (x) - 2 sin (x))
(%i3) G3[2];
                                2           2
(%o3)          lambda([x], 2 cos (x) - 2 sin (x))
(%i4) G3[2](1);
                           2           2
(%o4)                 2 cos (1) - 2 sin (1)
(%i5) arrayinfo (G3);
(%o5)                   [hashed, 1, [2]]
(%i6) listarray (G3);
                                2           2
(%o6)         [lambda([x], 2 cos (x) - 2 sin (x))]
@end example

When the last or only function argument @var{x_n} is a list of one element,
the function defined by @code{:=} accepts a variable number of arguments.

@c ===beg===
@c H ([L]) := apply ("+", L);
@c H (a, b, c);
@c ===end===
@example
(%i1) H ([L]) := apply ("+", L);
(%o1)                H([L]) := apply("+", L)
(%i2) H (a, b, c);
(%o2)                       c + b + a
@end example

@code{local} makes a local function definition.

@c ===beg===
@c foo (x) := 1 - x;
@c foo (100);
@c block (local (foo), foo (x) := 2 * x, foo (100));
@c foo (100);
@c ===end===
@example
(%i1) foo (x) := 1 - x;
(%o1)                    foo(x) := 1 - x
(%i2) foo (100);
(%o2)                         - 99
(%i3) block (local (foo), foo (x) := 2 * x, foo (100));
(%o3)                          200
(%i4) foo (100);
(%o4)                         - 99
@end example

@opencatbox
@category{Function definition} @category{Operators}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@node User defined operators, , Assignment operators, Operators
@section User defined operators
@c -----------------------------------------------------------------------------

@c -----------------------------------------------------------------------------
@anchor{infix}
@deffn  {Function} infix @
@fname{infix} (@var{op}) @
@fname{infix} (@var{op}, @var{lbp}, @var{rbp}) @
@fname{infix} (@var{op}, @var{lbp}, @var{rbp}, @var{lpos}, @var{rpos}, @var{pos})

Declares @var{op} to be an infix operator.  An infix operator is a function of
two arguments, with the name of the function written between the arguments.
For example, the subtraction operator @code{-} is an infix operator.

@code{infix (@var{op})} declares @var{op} to be an infix operator with default
binding powers (left and right both equal to 180) and parts of speech (left and
right both equal to @code{any}).
@c HOW IS pos DIFFERENT FROM lpos AND rpos ??

@code{infix (@var{op}, @var{lbp}, @var{rbp})} declares @var{op} to be an infix
operator with stated left and right binding powers and default parts of speech
(left and right both equal to @code{any}).

@code{infix (@var{op}, @var{lbp}, @var{rbp}, @var{lpos}, @var{rpos}, @var{pos})}
declares @var{op} to be an infix operator with stated left and right binding
powers and parts of speech @var{lpos}, @var{rpos}, and @var{pos} for the left
operand, the right operand, and the operator result, respectively.

"Part of speech", in reference to operator declarations, means expression type.
Three types are recognized: @code{expr}, @code{clause}, and @code{any},
indicating an algebraic expression, a Boolean expression, or any kind of
expression, respectively.  Maxima can detect some syntax errors by comparing the
declared part of speech to an actual expression.

The precedence of @var{op} with respect to other operators derives from the left
and right binding powers of the operators in question.  If the left and right
binding powers of @var{op} are both greater the left and right binding powers of
some other operator, then @var{op} takes precedence over the other operator.
If the binding powers are not both greater or less, some more complicated
relation holds.

The associativity of @var{op} depends on its binding powers.  Greater left
binding power (@var{lbp}) implies an instance of @var{op} is evaluated before
other operators to its left in an expression, while greater right binding power
(@var{rbp}) implies  an instance of @var{op} is evaluated before other operators
to its right in an expression.  Thus greater @var{lbp} makes @var{op}
right-associative, while greater @var{rbp} makes @var{op} left-associative.
If @var{lbp} is equal to @var{rbp}, @var{op} is left-associative.

See also @ref{Introduction to operators}.

Examples:

If the left and right binding powers of @var{op} are both greater
the left and right binding powers of some other operator,
then @var{op} takes precedence over the other operator.

@c ===beg===
@c :lisp (get '$+ 'lbp)
@c :lisp (get '$+ 'rbp)
@c infix ("##", 101, 101);
@c "##"(a, b) := sconcat("(", a, ",", b, ")");
@c 1 + a ## b + 2;
@c infix ("##", 99, 99);
@c 1 + a ## b + 2;
@c ===end===
@example
(%i1) :lisp (get '$+ 'lbp)
100
(%i1) :lisp (get '$+ 'rbp)
100
(%i1) infix ("##", 101, 101);
(%o1)                          ##
(%i2) "##"(a, b) := sconcat("(", a, ",", b, ")");
(%o2)       (a ## b) := sconcat("(", a, ",", b, ")")
(%i3) 1 + a ## b + 2;
(%o3)                       (a,b) + 3
(%i4) infix ("##", 99, 99);
(%o4)                          ##
(%i5) 1 + a ## b + 2;
(%o5)                       (a+1,b+2)
@end example

Greater @var{lbp} makes @var{op} right-associative,
while greater @var{rbp} makes @var{op} left-associative.

@c ===beg===
@c infix ("##", 100, 99);
@c "##"(a, b) := sconcat("(", a, ",", b, ")")$
@c foo ## bar ## baz;
@c infix ("##", 100, 101);
@c foo ## bar ## baz;
@c ===end===
@example
(%i1) infix ("##", 100, 99);
(%o1)                          ##
(%i2) "##"(a, b) := sconcat("(", a, ",", b, ")")$
(%i3) foo ## bar ## baz;
(%o3)                    (foo,(bar,baz))
(%i4) infix ("##", 100, 101);
(%o4)                          ##
(%i5) foo ## bar ## baz;
(%o5)                    ((foo,bar),baz)
@end example

Maxima can detect some syntax errors by comparing the
declared part of speech to an actual expression.

@c ===beg===
@c infix ("##", 100, 99, expr, expr, expr);
@c if x ## y then 1 else 0;
@c infix ("##", 100, 99, expr, expr, clause);
@c if x ## y then 1 else 0;
@c ===end===
@example
(%i1) infix ("##", 100, 99, expr, expr, expr);
(%o1)                          ##
(%i2) if x ## y then 1 else 0;
Incorrect syntax: Found algebraic expression where logical
expression expected
if x ## y then 
             ^
(%i2) infix ("##", 100, 99, expr, expr, clause);
(%o2)                          ##
(%i3) if x ## y then 1 else 0;
(%o3)                if x ## y then 1 else 0
@end example

@opencatbox
@category{Operators} @category{Declarations and inferences} @category{Syntax}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{matchfix}
@deffn  {Function} matchfix @
@fname{matchfix} (@var{ldelimiter}, @var{rdelimiter}) @
@fname{matchfix} (@var{ldelimiter}, @var{rdelimiter}, @var{arg_pos}, @var{pos})

Declares a matchfix operator with left and right delimiters @var{ldelimiter}
and @var{rdelimiter}.  The delimiters are specified as strings.

A "matchfix" operator is a function of any number of arguments,
such that the arguments occur between matching left and right delimiters.
The delimiters may be any strings, so long as the parser can
distinguish the delimiters from the operands 
and other expressions and operators.
In practice this rules out unparseable delimiters such as
@code{%}, @code{,}, @code{$} and @code{;}, 
and may require isolating the delimiters with white space.
The right delimiter can be the same or different from the left delimiter.

A left delimiter can be associated with only one right delimiter;
two different matchfix operators cannot have the same left delimiter.

An existing operator may be redeclared as a matchfix operator
without changing its other properties.
In particular, built-in operators such as addition @code{+} can
be declared matchfix,
but operator functions cannot be defined for built-in operators.

The command @code{matchfix (@var{ldelimiter}, @var{rdelimiter}, @var{arg_pos},
@var{pos})} declares the argument part-of-speech @var{arg_pos} and result
part-of-speech @var{pos}, and the delimiters @var{ldelimiter} and
@var{rdelimiter}.

"Part of speech", in reference to operator declarations, means expression type.
Three types are recognized: @code{expr}, @code{clause}, and @code{any},
indicating an algebraic expression, a Boolean expression, or any kind of
expression, respectively.
Maxima can detect some syntax errors by comparing the
declared part of speech to an actual expression.

@c DUNNO IF WE REALLY NEED TO MENTION BINDING POWER HERE -- AS NOTED IT'S IRRELEVANT
@c An operator declared by @code{matchfix} is assigned a low binding power.
@c Since a matchfix operator must be evaluated before any expression
@c which contains it,
@c binding power is effectively irrelevant
@c to the declaration of a matchfix operator.

The function to carry out a matchfix operation is an ordinary
user-defined function.
The operator function is defined
in the usual way
with the function definition operator @code{:=} or @code{define}.
The arguments may be written between the delimiters,
or with the left delimiter as a quoted string and the arguments
following in parentheses.
@code{dispfun (@var{ldelimiter})} displays the function definition.

The only built-in matchfix operator is the list constructor @code{[ ]}.
Parentheses @code{( )} and double-quotes @code{" "} 
act like matchfix operators,
but are not treated as such by the Maxima parser.

@code{matchfix} evaluates its arguments.
@code{matchfix} returns its first argument, @var{ldelimiter}.
@c HOW TO TAKE AWAY THE MATCHFIX PROPERTY ??

Examples:

Delimiters may be almost any strings.

@c ===beg===
@c matchfix ("@@", "~");
@c @@ a, b, c ~;
@c matchfix (">>", "<<");
@c >> a, b, c <<;
@c matchfix ("foo", "oof");
@c foo a, b, c oof;
@c >> w + foo x, y oof + z << / @@ p, q ~;
@c ===end===
@example
(%i1) matchfix ("@@@@", "~");
(%o1)                          @@@@
(%i2) @@@@ a, b, c ~;
(%o2)                      @@@@a, b, c~
(%i3) matchfix (">>", "<<");
(%o3)                          >>
(%i4) >> a, b, c <<;
(%o4)                      >>a, b, c<<
(%i5) matchfix ("foo", "oof");
(%o5)                          foo
(%i6) foo a, b, c oof;
(%o6)                     fooa, b, coof
(%i7) >> w + foo x, y oof + z << / @@@@ p, q ~;
                     >>z + foox, yoof + w<<
(%o7)                ----------------------
                            @@@@p, q~
@end example

Matchfix operators are ordinary user-defined functions.

@example
(%i1) matchfix ("!-", "-!");
(%o1)                         "!-"
(%i2) !- x, y -! := x/y - y/x;
                                    x   y
(%o2)                   !-x, y-! := - - -
                                    y   x
(%i3) define (!-x, y-!, x/y - y/x);
                                    x   y
(%o3)                   !-x, y-! := - - -
                                    y   x
(%i4) define ("!-" (x, y), x/y - y/x);
                                    x   y
(%o4)                   !-x, y-! := - - -
                                    y   x
(%i5) dispfun ("!-");
                                    x   y
(%t5)                   !-x, y-! := - - -
                                    y   x

(%o5)                         done
(%i6) !-3, 5-!;
                                16
(%o6)                         - --
                                15
(%i7) "!-" (3, 5);
                                16
(%o7)                         - --
                                15
@end example

@opencatbox
@category{Syntax} @category{Operators}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{function_nary}
@deffn  {Function} nary @
@fname{nary} (@var{op}) @
@fname{nary} (@var{op}, @var{bp}, @var{arg_pos}, @var{pos})

An @code{nary} operator is used to denote a function of any number of arguments,
each of which is separated by an occurrence of the operator, e.g.  A+B or A+B+C.
The @code{nary("x")} function is a syntax extension function to declare @code{x}
to be an @code{nary} operator.  Functions may be declared to be @code{nary}.  If
@code{declare(j,nary);} is done, this tells the simplifier to simplify, e.g.
@code{j(j(a,b),j(c,d))} to @code{j(a, b, c, d)}.

See also @ref{Introduction to operators}.

@opencatbox
@category{Operators} @category{Syntax}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{nofix}
@deffn  {Function} nofix @
@fname{nofix} (@var{op}) @
@fname{nofix} (@var{op}, @var{pos})

@code{nofix} operators are used to denote functions of no arguments.
The mere presence of such an operator in a command will cause the
corresponding function to be evaluated.  For example, when one types
"exit;" to exit from a Maxima break, "exit" is behaving similar to a
@code{nofix} operator.  The function @code{nofix("x")} is a syntax extension
function which declares @code{x} to be a @code{nofix} operator.

See also @ref{Introduction to operators}.

@opencatbox
@category{Operators} @category{Syntax}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{postfix}
@deffn  {Function} postfix @
@fname{postfix} (@var{op}) @
@fname{postfix} (@var{op}, @var{lbp}, @var{lpos}, @var{pos})

@code{postfix} operators like the @code{prefix} variety denote functions of a
single argument, but in this case the argument immediately precedes an
occurrence of the operator in the input string, e.g. 3!.  The
@code{postfix("x")} function is a syntax extension function to declare @code{x}
to be a @code{postfix} operator.

See also @ref{Introduction to operators}.

@opencatbox
@category{Operators} @category{Syntax}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{prefix}
@deffn  {Function} prefix @
@fname{prefix} (@var{op}) @
@fname{prefix} (@var{op}, @var{rbp}, @var{rpos}, @var{pos})

A @code{prefix} operator is one which signifies a function of one argument,
which argument immediately follows an occurrence of the operator.
@code{prefix("x")} is a syntax extension function to declare @code{x} to be a
@code{prefix} operator.

See also @ref{Introduction to operators}.

@opencatbox
@category{Operators} @category{Syntax}
@closecatbox
@end deffn
