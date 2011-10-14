DEBUG = -g
CC = cc $(DEBUG) 
CUNIT_FLAGS = -lcunit
OBJS = point.o edge.o triangle.o circle.o listnode.o list.o hash.o geom_test.o
ROBJS = listnode.o list.o hash.o run.o

all:

test: $(OBJS)
	$(CC) $(DEBUG) $(OBJS) $(CUNIT_FLAGS) -gstabs -o geom_test
	./geom_test

run: $(ROBJS)
	$(CC) $(DEBUG) $(ROBJS) -o run

$(OBJS):

$(ROBJS):

clean:
	rm *.o geom_test
