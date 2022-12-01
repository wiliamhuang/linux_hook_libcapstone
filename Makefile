CC=gcc
CFLAGS=-Wall -Wextra -fPIC -g -O0 -I. -Wunused
LFLAGS=-fPIC -shared -g -O0 -ldl
OBJS=obj/mini_open.o obj/hook_open.o  obj/hook.o
HEADERS=src/hook_int.h
RM=rm -rf

# in cmd of windows
ifeq ($(SHELL),sh.exe)
    RM := del /f/q
endif

all: hook_open.so mini_open.so

mini_open.so: mini_open.o
	$(CC) $(LFLAGS) -o mini_open.so obj/mini_open.o

mini_open.o: examples/mini_open.c
	$(CC) $(CFLAGS) -c -o obj/mini_open.o $<

hook_open.so: hook_open.o hook.o
	$(CC) $(LFLAGS) -o hook_open.so obj/hook_open.o obj/hook.o -lcapstone

hook_open.o: examples/hook_open.c $(HEADERS)
	$(CC) $(CFLAGS) -c -o obj/hook_open.o $<

hook.o: src/hook.c $(HEADERS)
	$(CC) $(CFLAGS) -c -o obj/hook.o $<

clean:
	$(RM) obj/*.o mini_open.so hook_open.so

$(shell   mkdir -p obj)
