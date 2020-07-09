CC := gcc
CFLAGS := -nostdlib -nodefaultlibs
#CPPFLAGS := -nostdlib -nodefaultlibs
LD := ld

objects = main.o entry.o __set_errno_internal.o

main: $(objects)
	$(LD) $? -o $@

clean:
	rm -rf $(objects) main a.out
