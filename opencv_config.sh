export C_INCLUDE_PATH=/home/Aphrodite/Install/opencv/include/opencv:/home/Aphrodite/Install/opencv/include:$C_INCLUDE_PATH

export CPLUS_INCLUDE_PATH=/home/Aphrodite/Install/opencv/include/opencv:/home/Aphrodite/Install/opencv/include:$CPLUS_INCLUDE_PATH

export PKG_CONFIG_PATH=/home/Aphrodite/Install/opencv/lib/pkgconfig:$PKG_CONFIG_PATH

export LD_LIBRARY_PATH=/home/Aphrodite/Install/opencv/lib/:$LD_LIBRARY_PATH

export LIBRARY_PATH=/home/Aphrodite/Install/opencv/lib/:$LIBRARY_PATH

# gcc `pkg-config --cflags --libs opencv` -o my-opencv-prgm my-opencv-prgm.c

alias gcc='gcc -L/home/Aphrodite/Install/opencv/lib/ -lopencv_core -lopencv_imgproc -lopencv_highgui -lopencv_ml -lopencv_video -lopencv_features2d -lopencv_calib3d -lopencv_objdetect -lopencv_contrib -lopencv_legacy -lopencv_flann'

alias g++='g++ -L/home/Aphrodite/Install/opencv/lib/ -lopencv_core -lopencv_imgproc -lopencv_highgui -lopencv_ml -lopencv_video -lopencv_features2d -lopencv_calib3d -lopencv_objdetect -lopencv_contrib -lopencv_legacy -lopencv_flann'
