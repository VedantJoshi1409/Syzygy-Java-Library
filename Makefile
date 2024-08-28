MKDIR_P = mkdir -p
RM      = rm
INSTALL = install

CC      ?= gcc
CXX     ?= g++
CFLAGS   = -std=gnu99 -O2 -Wall -Wshadow -Isrc
CXXFLAGS = -std=c++11 -O2 -Wall -Wshadow -Isrc
LDFLAGS  = $(CFLAGS)

PREFIX  = /usr/local
LIBDIR  = $(PREFIX)/lib64
INCDIR  = $(PREFIX)/include

# Java home directory - adjust this path as needed

# Add Java include directories
JAVA_INCLUDES = -I$(JAVA_HOME)/include -I$(JAVA_HOME)/include/linux

# Update CFLAGS and CXXFLAGS to include Java headers
CFLAGS   += $(JAVA_INCLUDES)
CXXFLAGS += $(JAVA_INCLUDES)

libfathom.so: obj/tbprobe.o obj/TB_Tablebase.o
	$(CXX) $(LDFLAGS) -shared $^ -o $@

obj/tbprobe.o: src/tbprobe.c src/tbchess.c src/stdendian.h src/tbprobe.h
	@$(MKDIR_P) obj
	$(CC) $(CFLAGS) -fPIC -c $< -o $@

obj/TB_Tablebase.o: src/TB_Tablebase.cpp src/TB_Tablebase.h
	@$(MKDIR_P) obj
	$(CXX) $(CXXFLAGS) -fPIC -c $< -o $@

clean:
	$(RM) -f libfathom.so
	$(RM) -rf obj

install: libfathom.so
	$(MKDIR_P) $(DESTDIR)$(LIBDIR)
	$(MKDIR_P) $(DESTDIR)$(INCDIR)
	$(INSTALL) -m 0644 libfathom.so $(DESTDIR)$(LIBDIR)
	$(INSTALL) -m 0644 src/{stdendian,tbconfig,tbprobe,TB_Tablebase}.h $(DESTDIR)$(INCDIR)

uninstall:
	$(RM) -f $(DESTDIR)$(LIBDIR)/libfathom.so
	$(RM) -f $(DESTDIR)$(INCDIR)/{stdendian,tbconfig,tbprobe,TB_Tablebase}.h

.PHONY: clean install uninstall