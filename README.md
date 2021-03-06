# The Verisec Suite

This suite was developed at the University of Toronto by Tom Hart and Kelvin Ku under the supervision of professors Marsha Chechik and David Lie. It has been used in several publications to benchmark software model checkers and other static analysis tools.

## Status

The project is no longer being actively maintained but is available for download.

## Directory Structure of the Verisec Suite

/lib contains stubs (simple implementations) of library functions in a file
stubs.c which should be linked into each testcase at analysis time.  It also
includes two header files, stubs.h and base.h.  The header file stubs.h is
#included in every testcase in the suite and itself #includes base.h.  The file
base.h #defines the macro BASE_SZ which sets the base buffer size for all
testcases.  This macro can be changed either by directly modifying base.h or, if
a tool supports it, by overriding it at the command line, e.g., via the -D
option in SatAbs and CBMC.

/programs/apps contains the testcases which are first organized into
directories by program, e.g., as shown in Figure 1 below, sendmail, OpenSER,
and MADWiFi.  Within each directory is a README file containing a brief
description of the related program.  Then there is a directory for each
vulnerability in the program for which we developed testcases.  Each
vulnerability has a README file which explains the vulnerability and briefly
describes its testcases.  There are typically multiple testcases capturing the
vulnerability.  For example, in the figure, there are two sets of testcases for
the CVE-2006-6749 vulnerability in OpenSER.  These testcases are partitioned
into directories according to the depth of the function in the calling context
of the vulnerability.  For example, in the figure below, in vulnerability
CVE-2006-6749, the overflow occurs in function parse_expression which is called
by function parse_expression_list.  Thus, the testcases in the directory
parse_expression only capture the body of parse_expression, whereas the
testcases in the directory parse_expression_list capture the bodies of both
functions, i.e., they include some of the calling context of parse_expression.
Each testcase has unsafe and safe variants, indicated by the suffixes "bad" and
"ok", respectively.  The vulnerable statements in unsafe variants are indicated
by the comment, "/* BAD */," on the line immediately preceding the statement.
The corresponding statements in safe variants are indicated by the comment, "/*
OK */."  Some vulnerabilities include a subdirectory "complete", which includes
a testcase capturing most of the calling context of the vulnerability. 

```
--------------------------------------------------------------------------
 verisec/
     README.md
     lib/
     programs/
       apps/
	 OpenSER/
	   README
	   CVE-2006-6749/
	     README
	     complete/
	     parse_expression/
		guard_random_index_bad.c
		guard_random_index_ok.c
		guard_strchr_bad.c
		guard_strchr_ok.c
		guard_strstr_bad.c
		guard_strstr_ok.c
	     parse_expression_list/
	 sendmail/
	 MADWiFi/
	 ...

Fig. 1 -- Suite directory structure.
--------------------------------------------------------------------------
```
