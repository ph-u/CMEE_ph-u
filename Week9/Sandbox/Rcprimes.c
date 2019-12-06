#include <R.h>
#include <Rdefines.h>

SEXP count_primes_C_wrap(SEXP limit)
{
		SEXP result;
		PROTECT(result = NEW_INTEGER(1)); // protect instructs R garbage collector to leave this data alone

		int limit_c = 0;
		limit_c = *(INTEGER(limit)); // tell compiler to read the limit pointer arg as a c-type int

		int c_result = count_primes_C(limit_c);
		*(INTEGER(result)) = c_result;

		UNPROTECT(1); // number of protect calls, stack balance
		return result;
}
