#include "logging.h"

#include <stdlib.h> // malloc()
#include <string.h>
#include <assert.h>

// only defined/used when not USE_SYSLOG
//
// QUESTION: Do we really want fuse to abort routines with error-codes
//    if the logging function fails?  I suspect not.  If you wanted to,
//    you could define LOG(...) to be TRY_GE0(printf_log(...))

ssize_t printf_log(size_t prio, const char *format, ...)
{
  va_list list;
  va_start(list, format);

  ssize_t written = vfprintf(stderr, format, list);

  fflush(stderr);
  return written;
}