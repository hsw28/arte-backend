 g++ -framework GLUT -framework OpenGL -framework Cocoa -I /opt/local/include/GL/ -L /opt/local/lib -lGLEW  -I ../../../include/netcom/ -I ../../../include/common/  -D__STDC_LIMIT_MACROS *.cpp ../../netcom/*.cpp -o sv2 
