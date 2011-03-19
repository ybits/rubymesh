CC = cc -g
DEBUG = -g
CUNIT_FLAGS = -lcunit
OBJS = point.o edge.o triangle.o circle.o listnode.o list.o hash.o geom_test.o

all:

test: $(OBJS)
	$(CC) $(DEBUG) $(OBJS) $(CUNIT_FLAGS) -gstabs -o geom_test
	./geom_test

$(OBJS):

clean:
	rm *.o geom_test
