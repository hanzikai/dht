CXX = g++ -std=c++11

TOPDIR = ..
BOOST_DIR = /work/boost_1_72_0
BOOST_LIB_DIR = /work/boost_1_72_0/stage/lib
INC=-I$(BOOST_DIR)
LIB=-lz -lcrypto -lpthread -lrt -luuid
BASELIB= $(BOOST_LIB_DIR)/libboost_context.a  $(BOOST_LIB_DIR)/libboost_thread.a
METRICS2SDK = 
FLAG=-g -O2 -Wno-deprecated -Wl,-rpath,./

SRCS = $(wildcard *.cpp) 
OBJS = $(SRCS:.cpp=.o)
	
TARGET = test-coroutine2

.SUFFIXES: .o .cpp
.cpp.o:
	$(CXX) $(FLAG) -c -o $@ $< $(MACRO) $(INC)

all : $(TARGET)

$(TARGET) : $(OBJS)
	$(CXX) $(FLAG) -o $@ $^ $(METRICS2SDK) $(BASELIB) $(LIB) 

clean:
	rm -f $(OBJS) $(TARGET)
