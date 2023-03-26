
Windows* OS Installation Notes:
-------------------------------

    Extract all files in iaca-win64.zip into a directory on your machine

    Add the complete path <full path of your directory >\iaca-win64 to the PATH environment variable
    For example:
    set PATH = %PATH%;"C:\iaca-win64"

Linux* OS Installation Notes:
-----------------------------

    Extract all files in iaca-lin64.zip into a directory on your machine

    Add the complete path <full path of your directory >/iaca-lin64 to the PATH environment variable
    For example:
    set PATH = $PATH:/home/iaca-lin64"

Mac* OS Installation Notes:
---------------------------

    Extract all files in iaca-mac64.zip into a directory on your machine

    Add the complete path <full path of your directory >/iaca-mac64 to the PATH environment variable
    For example:
    set PATH = $PATH:/home/iaca-mac64"

For further details on operating Intel(R) Architecture Code Analyzer please refer 
to the user's guide that is part of the release.

Intel(R) Architecture Code Analyzer 3.0 Release Notes
-----------------------------------------------------------

- Version 3.0 is a rewrite of IACA. No new microarchitectures are added, but the UI changed a bit.
  For example, port columns in the output are now large enough to accommodate up to 99.9 cycles per port.
  This may affect tools that automatically process IACA output.
- Dropped support for NHM, WSM, SNB and IVB.
- IACA now accepts a -trace <file> switch which generates an IACA trace directly
  to a file without the need for post-processing. A separate switch (-trace-cycle-count) can be used to
  control how many cycles to trace.
- Various switches were deprecated; See user guide.                           
