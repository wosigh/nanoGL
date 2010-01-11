INSTALLDIR=/usr
BUILDDIR=build
SRC=src
CXX=g++
CXX_FLAGS=-ldl -Iinclude

default: makedirs lib

lib:	$(BUILDDIR)/nanogl.o $(BUILDDIR)/nanoWrap.o $(BUILDDIR)/eglwrap.o
	$(CXX) -shared $(CXX_FLAGS) -o $(BUILDDIR)/libnanoGL.so $(BUILDDIR)/nanogl.o $(BUILDDIR)/nanoWrap.o $(BUILDDIR)/eglwrap.o

makedirs:
	@if [ ! -d $(BUILDDIR) ];then mkdir $(BUILDDIR);fi

$(BUILDDIR)/nanogl.o:	$(SRC)/nanogl.cpp
	$(CXX) $(CXX_FLAGS) -c $(SRC)/nanogl.cpp -o $(BUILDDIR)/nanogl.o
	
$(BUILDDIR)/nanoWrap.o:	$(SRC)/nanoWrap.cpp
	$(CXX) $(CXX_FLAGS) -c $(SRC)/nanoWrap.cpp -o $(BUILDDIR)/nanoWrap.o
		
$(BUILDDIR)/eglwrap.o:	$(SRC)/eglwrap.cpp
	$(CXX) $(CXX_FLAGS) -c $(SRC)/eglwrap.cpp -o $(BUILDDIR)/eglwrap.o
	
install:
	cp $(BUILDDIR)/libnanoGL.so $(INSTALLDIR)/lib/.
	@if [ ! -d $(INSTALLDIR)/include/nanoGL ];then mkdir $(INSTALLDIR)/include/nanoGL;fi
	cp include/*.h $(INSTALLDIR)/include/nanoGL/.
	
clean:
	rm -fr $(BUILDDIR)
