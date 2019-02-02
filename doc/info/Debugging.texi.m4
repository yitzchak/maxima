@c -*- Mode: texinfo -*-
@menu
* Source Level Debugging::
* Keyword Commands::
* Functions and Variables for Debugging::   
@end menu

@c -----------------------------------------------------------------------------
@node Source Level Debugging, Keyword Commands, , Debugging
@section Source Level Debugging
@c -----------------------------------------------------------------------------

Maxima has a built-in source level debugger.  
The user can set a breakpoint at a function,
and then step line by line from there.  The call
stack may be examined, together with the variables bound at that level.

The command @code{:help} or @code{:h} shows the list of debugger commands.
(In general,
commands may be abbreviated if the abbreviation is unique.  If not
unique, the alternatives will be listed.)
Within the debugger, the user can also use any ordinary Maxima
functions to examine, define, and manipulate variables and expressions.

A breakpoint is set by the @code{:br} command at the Maxima prompt.
Within the debugger,
the user can advance one line at a time using the @code{:n} (``next'') command.
The @code{:bt} (``backtrace'') command shows a list of stack frames.
The @code{:r} (``resume'') command exits the debugger and continues with 
execution.  These commands are demonstrated in the example below.

@example
(%i1) load ("/tmp/foobar.mac");

(%o1)                           /tmp/foobar.mac

(%i2) :br foo
Turning on debugging debugmode(true)
Bkpt 0 for foo (in /tmp/foobar.mac line 1) 

(%i2) bar (2,3);
Bkpt 0:(foobar.mac 1)
/tmp/foobar.mac:1::

(dbm:1) :bt                        <-- :bt typed here gives a backtrace
#0: foo(y=5)(foobar.mac line 1)
#1: bar(x=2,y=3)(foobar.mac line 9)

(dbm:1) :n                         <-- Here type :n to advance line
(foobar.mac 2)
/tmp/foobar.mac:2::

(dbm:1) :n                         <-- Here type :n to advance line
(foobar.mac 3)
/tmp/foobar.mac:3::

(dbm:1) u;                         <-- Investigate value of u
28

(dbm:1) u: 33;                     <-- Change u to be 33
33

(dbm:1) :r                         <-- Type :r to resume the computation

(%o2)                                1094
@end example

The file @code{/tmp/foobar.mac} is the following:

@example
foo(y) := block ([u:y^2],
  u: u+3,
  u: u^2,
  u);
 
bar(x,y) := (
  x: x+2,
  y: y+2,
  x: foo(y),
  x+y);
@end example

USE OF THE DEBUGGER THROUGH EMACS

If the user is running the code under GNU emacs in a shell
window (dbl shell), or is running the graphical interface version,
Xmaxima, then if he stops at a break point, he will see his
current position in the source file which will be displayed in the
other half of the window, either highlighted in red, or with a little
arrow pointing at the right line.  He can advance single lines at a
time by typing M-n (Alt-n).

Under Emacs you should run in a @code{dbl} shell, which requires the
@code{dbl.el} file in the elisp directory.
Make sure you install the elisp files or add the Maxima elisp directory to
your path:
e.g., add the following to your @file{.emacs} file or the @file{site-init.el}

@example
(setq load-path (cons "/usr/share/maxima/5.9.1/emacs" load-path))
(autoload 'dbl "dbl")
@end example

then in emacs 

@example
M-x dbl
@end example

should start a shell window in which you can run programs, for example
Maxima, gcl, gdb etc.   This shell window also knows about source level
debugging, and display of source code in the other window.

The user may set a break point at a certain line of the
file by typing @code{C-x space}.  This figures out which function
the cursor is in, and then it sees which line of that function
the cursor is on.   If the cursor is on, say, line 2 of @code{foo}, then it will
insert in the other window the command, ``@code{:br foo 2}'', to
break @code{foo} at its second line.   To have this enabled, the user must have
maxima-mode.el turned on in the window in which the file @code{foobar.mac} is
visiting.  There are additional commands available in that file window, such as
evaluating the function into the Maxima, by typing @code{Alt-Control-x}.

@opencatbox
@category{Debugging}
@closecatbox

@c -----------------------------------------------------------------------------
@node Keyword Commands, Functions and Variables for Debugging, Source Level Debugging, Debugging
@section Keyword Commands
@c -----------------------------------------------------------------------------

Keyword commands are special keywords which are not interpreted as Maxima
expressions.  A keyword command can be entered at the Maxima prompt or the
debugger prompt, although not at the break prompt.
Keyword commands start with a colon, '@code{:}'.
For example, to evaluate a Lisp form you
may type @code{:lisp} followed by the form to be evaluated.

@example
(%i1) :lisp (+ 2 3) 
5
@end example

The number of arguments taken depends on the particular command.  Also,
you need not type the whole command, just enough to be unique among
the break keywords.   Thus @code{:br} would suffice for @code{:break}.

The keyword commands are listed below.

@table @code
@item :break F n
Set a breakpoint in function @code{F} at line offset @code{n}
from the beginning of the function.
If @code{F} is given as a string, then it is assumed to be
a file, and @code{n} is the offset from the beginning of the file.
The offset is optional. If not given, it is assumed to be zero
(first line of the function or file).
@item :bt
Print a backtrace of the stack frames
@item :continue
Continue the computation
@c CAN'T SEEM TO GET :delete TO WORK !!!
@item :delete
Delete the specified breakpoints, or all if none are specified
@c CAN'T SEEM TO GET :disable TO WORK !!!
@item :disable
Disable the specified breakpoints, or all if none are specified
@c CAN'T SEEM TO GET :enable TO WORK !!!
@item :enable
Enable the specified breakpoints, or all if none are specified
@item :frame n
Print stack frame @code{n}, or the current frame if none is specified
@c CAN'T SEEM TO GET :help TO WORK !!!
@item :help
Print help on a debugger command, or all commands if none is specified
@c CAN'T SEEM TO GET :info TO WORK !!!
@item :info
Print information about item
@item :lisp some-form
Evaluate @code{some-form} as a Lisp form
@item :lisp-quiet some-form
Evaluate Lisp form @code{some-form} without any output
@item :next
Like @code{:step}, except @code{:next} steps over function calls
@item :quit
Quit the current debugger level without completing the computation
@item :resume
Continue the computation
@item :step
Continue the computation until it reaches a new source line
@item :top
Return to the Maxima prompt (from any debugger level) without 
completing the computation
@end table 

@opencatbox
@category{Debugging}
@closecatbox

@c -----------------------------------------------------------------------------
@node Functions and Variables for Debugging, , Keyword Commands, Debugging
@section Functions and Variables for Debugging
@c -----------------------------------------------------------------------------

@c -----------------------------------------------------------------------------
m4_setcat(Debugging, Global flags)
@anchor{debugmode}
@c @defvr {Option variable} debugmode
m4_defvr({Option variable}, debugmode)
Default value: @code{false}

When a Maxima error occurs, Maxima will start the debugger if @code{debugmode}
is @code{true}.  The user may enter commands to examine the call stack, set
breakpoints, step through Maxima code, and so on.  See @code{debugging} for a
list of debugger commands.

Enabling @code{debugmode} will not catch Lisp errors.
@c DO WE WANT TO SAY MORE ABOUT DEBUGGING LISP ERRORS ???
@c I'M NOT CONVINCED WE WANT TO OPEN THAT CAN OF WORMS !!!

@c @opencatbox
@c @category{Debugging}
@c @category{Global flags}
@c @closecatbox
@c @end defvr
m4_end_defvr()
@c -----------------------------------------------------------------------------
m4_setcat(Evaluation, Console interaction, Global flags)
@anchor{refcheck}
@c @defvr {Option variable} refcheck
m4_defvr({Option variable}, refcheck)
Default value: @code{false}

When @code{refcheck} is @code{true}, Maxima prints a message
each time a bound variable is used for the first time in a
computation.

@c @opencatbox
@c @category{Evaluation}
@c @category{Console interaction}
@c @category{Global flags}
@c @closecatbox
@c @end defvr
m4_end_defvr()
@c -----------------------------------------------------------------------------
m4_setcat(Console interaction, Global flags)
@anchor{setcheck}
@c @defvr {Option variable} setcheck
m4_defvr({Option variable}, setcheck)
Default value: @code{false}

If @code{setcheck} is set to a list of variables (which can
be subscripted), 
Maxima prints a message whenever the variables, or
subscripted occurrences of them, are bound with the
ordinary assignment operator @code{:}, the @code{::} assignment
operator, or function argument binding,
but not the function assignment @code{:=} nor the macro assignment
@code{::=} operators.
The message comprises the name of the variable and the
value it is bound to.

@code{setcheck} may be set to @code{all} or @code{true} thereby
including all variables.

Each new assignment of @code{setcheck} establishes a new list of variables to
check, and any variables previously assigned to @code{setcheck} are forgotten.

The names assigned to @code{setcheck} must be quoted if they would otherwise
evaluate to something other than themselves.
For example, if @code{x}, @code{y}, and @code{z} are already bound, then enter

@example
setcheck: ['x, 'y, 'z]$
@end example

to put them on the list of variables to check.

No printout is generated when a
variable on the @code{setcheck} list is assigned to itself, e.g., @code{X: 'X}.

@c @opencatbox
@c @category{Console interaction}
@c @category{Global flags}
@c @closecatbox
@c @end defvr
m4_end_defvr()
@c -----------------------------------------------------------------------------
@anchor{setcheckbreak}
@c @defvr {Option variable} setcheckbreak
m4_defvr({Option variable}, setcheckbreak)
Default value: @code{false}

When @code{setcheckbreak} is @code{true},
Maxima will present a break prompt 
whenever a variable on the @code{setcheck} list is assigned a new value.
The break occurs before the assignment is carried out.
At this point, @code{setval} holds the value to which the variable is 
about to be assigned.
Hence, one may assign a different value by assigning to @code{setval}.

See also @mref{setcheck} and @mrefdot{setval}

@c @opencatbox
@c @category{Console interaction}
@c @category{Global flags}
@c @closecatbox
@c @end defvr
m4_end_defvr()
@c -----------------------------------------------------------------------------
@anchor{setval}
@c @defvr {System variable} setval
m4_defvr({System variable}, setval)

Holds the value to which a variable is about to be set when
a @mref{setcheckbreak} occurs.
Hence, one may assign a different value by assigning to @mref{setval}.

See also @mref{setcheck} and @mrefdot{setcheckbreak}

@c @opencatbox
@c @category{Console interaction}
@c @category{Global variables}
@c @closecatbox
@c @end defvr
m4_end_defvr()
@c -----------------------------------------------------------------------------
@anchor{timer}
@deffn  {Function} timer (@var{f_1}, @dots{}, @var{f_n}) @
@fname{timer} (all) @
@fname{timer} ()

Given functions @var{f_1}, @dots{}, @var{f_n}, @code{timer} puts each one on the
list of functions for which timing statistics are collected.
@code{timer(f)$ timer(g)$} puts @code{f} and then @code{g} onto the list;
the list accumulates from one call to the next.

@code{timer(all)} puts all user-defined functions (as named by the global
variable @code{functions}) on the list of timed functions.

With no arguments,  @code{timer} returns the list of timed functions.

Maxima records how much time is spent executing each function
on the list of timed functions.
@code{timer_info} returns the timing statistics, including the
average time elapsed per function call, the number of calls, and the
total time elapsed.
@code{untimer} removes functions from the list of timed functions.

@code{timer} quotes its arguments.
@code{f(x) := x^2$ g:f$ timer(g)$} does not put @code{f} on the timer list.

If @code{trace(f)} is in effect, then @code{timer(f)} has no effect;
@code{trace} and @code{timer} cannot both be in effect at the same time.

See also @mrefdot{timer_devalue}

@opencatbox
@category{Debugging}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{untimer}
@deffn  {Function} untimer (@var{f_1}, @dots{}, @var{f_n}) @
@fname{untimer} ()

Given functions @var{f_1}, @dots{}, @var{f_n},
@code{untimer} removes each function from the timer list.

With no arguments, @code{untimer} removes all functions currently on the timer
list.

After @code{untimer (f)} is executed, @code{timer_info (f)} still returns
previously collected timing statistics,
although @code{timer_info()} (with no arguments) does not
return information about any function not currently on the timer list.
@code{timer (f)} resets all timing statistics to zero
and puts @code{f} on the timer list again.

@opencatbox
@category{Debugging}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
m4_setcat(Debugging, Global flags)
@anchor{timer_devalue}
@c @defvr {Option variable} timer_devalue
m4_defvr({Option variable}, timer_devalue)
Default value: @code{false}

When @code{timer_devalue} is @code{true}, Maxima subtracts from each timed
function the time spent in other timed functions.  Otherwise, the time reported
for each function includes the time spent in other functions.
Note that time spent in untimed functions is not subtracted from the
total time.

See also @mref{timer} and @mrefdot{timer_info}

@c @opencatbox
@c @category{Debugging}
@c @category{Global flags}
@c @closecatbox
@c @end defvr
m4_end_defvr()
@c -----------------------------------------------------------------------------
@anchor{timer_info}
@deffn {Function} timer_info (@var{f_1}, ..., @var{f_n}) @
@fname{timer_info} ()

Given functions @var{f_1}, ..., @var{f_n}, @code{timer_info} returns a matrix
containing timing information for each function.
With no arguments, @code{timer_info} returns timing information for
all functions currently on the timer list.

The matrix returned by @code{timer_info} contains the function name,
time per function call, number of function calls, total time,
and @code{gctime}, which meant "garbage collection time" in the original Macsyma
but is now always zero.

The data from which @code{timer_info} constructs its return value
can also be obtained by the @code{get} function:

@example
get(f, 'calls);  get(f, 'runtime);  get(f, 'gctime);
@end example

See also @mrefdot{timer}

@opencatbox
@category{Debugging}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{trace}
@deffn  {Function} trace (@var{f_1}, @dots{}, @var{f_n}) @
@fname{trace} (all) @
@fname{trace} ()

Given functions @var{f_1}, @dots{}, @var{f_n}, @code{trace} instructs Maxima to
print out debugging information whenever those functions are called.
@code{trace(f)$ trace(g)$} puts @code{f} and then @code{g} onto the list of
functions to be traced; the list accumulates from one call to the next.

@code{trace(all)} puts all user-defined functions (as named by the global
variable @code{functions}) on the list of functions to be traced.

With no arguments,
@code{trace} returns a list of all the functions currently being traced.

The @code{untrace} function disables tracing.
See also @mrefdot{trace_options}

@code{trace} quotes its arguments.  Thus,
@code{f(x) := x^2$ g:f$ trace(g)$} does not put @code{f} on the trace list.

When a function is redefined, it is removed from the timer list.
Thus after @code{timer(f)$ f(x) := x^2$},
function @code{f} is no longer on the timer list.

If @code{timer (f)} is in effect, then @code{trace (f)} has no effect;
@code{trace} and @code{timer} can't both be in effect for the same function.

@opencatbox
@category{Debugging}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{trace_options}
@deffn  {Function} trace_options (@var{f}, @var{option_1}, @dots{}, @var{option_n}) @
@fname{trace_options} (@var{f})

Sets the trace options for function @var{f}.
Any previous options are superseded.
@code{trace_options (@var{f}, ...)} has no effect unless @code{trace (@var{f})}
is also called (either before or after @code{trace_options}).

@code{trace_options (@var{f})} resets all options to their default values.

The option keywords are:

@itemize @bullet
@item
@code{noprint}
Do not print a message at function entry and exit.
@item
@code{break}
Put a breakpoint before the function is entered,
and after the function is exited.  See @code{break}.
@item
@code{lisp_print}
Display arguments and return values as Lisp objects.
@item
@code{info}
Print @code{-> true} at function entry and exit.
@item
@code{errorcatch}
Catch errors, giving the option to signal an error,
retry the function call, or specify a return value.
@end itemize

Trace options are specified in two forms.  The presence of the option 
keyword alone puts the option into effect unconditionally.
(Note that option @var{foo} is not put into effect by specifying 
@code{@var{foo}: true} or a similar form; note also that keywords need not
be quoted.) Specifying the option keyword with a predicate
function makes the option conditional on the predicate.

The argument list to the predicate function is always 
@code{[level, direction, function, item]} where @code{level} is the recursion
level for the function,  @code{direction} is either @code{enter} or @code{exit},
@code{function} is the name of the function, and @code{item} is the argument
list (on entering) or the return value (on exiting).

Here is an example of unconditional trace options:

@example
(%i1) ff(n) := if equal(n, 0) then 1 else n * ff(n - 1)$

(%i2) trace (ff)$

(%i3) trace_options (ff, lisp_print, break)$

(%i4) ff(3);
@end example

Here is the same function, with the @code{break} option conditional
on a predicate:

@example
(%i5) trace_options (ff, break(pp))$

(%i6) pp (level, direction, function, item) := block (print (item),
    return (function = 'ff and level = 3 and direction = exit))$

(%i7) ff(6);
@end example

@opencatbox
@category{Debugging}
@closecatbox
@end deffn

@c -----------------------------------------------------------------------------
@anchor{untrace}
@deffn {Function} untrace @
@fname{untrace} (@var{f_1}, @dots{}, @var{f_n}) @
@fname{untrace} ()

Given functions @var{f_1}, @dots{}, @var{f_n},
@code{untrace} disables tracing enabled by the @code{trace} function.
With no arguments, @code{untrace} disables tracing for all functions.

@code{untrace} returns a list of the functions for which 
it disabled tracing.

@opencatbox
@category{Debugging}
@closecatbox
@end deffn

