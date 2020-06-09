Since foo and bar have circular references between each other, I expected to have to do something like:

    # make run_2
    $(CC) ${BUILD_DIR}/main.o -L${OUT_DIR}/lib/ -lfoo -lbar -lfoo -lbar -o ${OUT_DIR}/bin/app1
    # or this:
    $(CC) ${BUILD_DIR}/main.o -L${OUT_DIR}/lib/ "-Wl,--start-group" -lfoo -lbar "-Wl,--end-group" -o ${OUT_DIR}/bin/app1

However, the following (surprisingly) succeeds:
  
    # make run_1
    $(CC) ${BUILD_DIR}/main.o -L${OUT_DIR}/lib/ -lfoo -lbar -o ${OUT_DIR}/bin/app1

I would expect `make run_1` to complain about missing symbols due to the circular references between foo and bar. What gives?

This succeeds with both clang on macos and gcc on debian:

clang on mac: 

    $ cc --version
    Apple clang version 11.0.3 (clang-1103.0.32.59)

gcc on debian:

    $ cc --version
    cc (Debian 8.3.0-6) 8.3.0
    Copyright (C) 2018 Free Software Foundation, Inc.
    This is free software; see the source for copying conditions.  There is NO
    warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 
