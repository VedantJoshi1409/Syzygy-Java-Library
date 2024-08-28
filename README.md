# Syzygy-Java-Library
A Java port for the [Fathom Syzygy Tablebase Probe](https://github.com/jdart1/Fathom)

Usage is the same as the api that can be found in the Fathom repository, under tbprobe.h

To compile the shared library first run \
```make```\
then inside the generated obj directory, run \
```g++ -static-libgcc -shared -o tbProbe.dll TB_Tablebase.o tbprobe.o -I${JAVA_HOME}/include -I${JAVA_HOME}/include/win32```
