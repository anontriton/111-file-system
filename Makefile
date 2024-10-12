STARTER_DIR=/comp/111m1/assignments/fs
TEST_DIR=$(STARTER_DIR)/tests
CC=gcc
LD=$(CC)
CPPFLAGS=-g -std=gnu11 -Wpedantic -Wall -Wextra
CFLAGS=-I$(STARTER_DIR)
LDFLAGS=
LDLIBS=-lm
PROGRAM=command_line
TEST=test

all: $(PROGRAM) $(TEST)

$(TEST).o: $(TEST_DIR)/$(TEST).o
	ln -s $(TEST_DIR)/$(TEST).o

$(TEST_DIR)/$(TEST).o: $(TEST_DIR)/$(TEST).c
	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

$(PROGRAM).o: $(STARTER_DIR)/$(PROGRAM).c
	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

basic_file_system.o: $(STARTER_DIR)/basic_file_system.c
	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

raw_disk.o: $(STARTER_DIR)/raw_disk.c
	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

%.o: %.c
	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

$(PROGRAM): $(PROGRAM).o jumbo_file_system.o basic_file_system.o raw_disk.o
	$(LD) $(CPPFLAGS) $(LDFLAGS) $(LDLIBS) -o $@ $^

$(TEST): $(TEST).o jumbo_file_system.o basic_file_system.o raw_disk.o
	$(LD) $(CPPFLAGS) $(LDFLAGS) $(LDLIBS) -o $@ $^

.PHONY:
clean:
	rm -f *.o $(PROGRAM) $(TEST) DISK TEST_DISK

.PHONY:
check: $(TEST)
	./$(TEST) -f
