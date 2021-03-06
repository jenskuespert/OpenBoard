
HEADERS      += src/podcast/UBPodcastController.h \
                src/podcast/UBAbstractVideoEncoder.h \
                src/podcast/UBPodcastRecordingPalette.h \
                src/podcast/youtube/UBYouTubePublisher.h \
                src/podcast/intranet/UBIntranetPodcastPublisher.h \
                
SOURCES      += src/podcast/UBPodcastController.cpp \
                src/podcast/UBAbstractVideoEncoder.cpp \
                src/podcast/UBPodcastRecordingPalette.cpp \
                src/podcast/youtube/UBYouTubePublisher.cpp \
                src/podcast/intranet/UBIntranetPodcastPublisher.cpp \

win32 {

    SOURCES  += src/podcast/windowsmedia/UBWindowsMediaVideoEncoder.cpp \
                src/podcast/windowsmedia/UBWindowsMediaFile.cpp \
                src/podcast/windowsmedia/UBWaveRecorder.cpp

    HEADERS  += src/podcast/windowsmedia/UBWindowsMediaVideoEncoder.h \
                src/podcast/windowsmedia/UBWindowsMediaFile.h \
                src/podcast/windowsmedia/UBWaveRecorder.h
}

macx {
    CONFIG += c++11

    SOURCES  += src/podcast/ffmpeg/UBFFmpegVideoEncoder.cpp \
                src/podcast/ffmpeg/UBMicrophoneInput.cpp

    HEADERS  += src/podcast/ffmpeg/UBFFmpegVideoEncoder.h \
                src/podcast/ffmpeg/UBMicrophoneInput.h

    LIBS += -lavformat -lavcodec -lswscale  -lswresample -lavutil \
        -lpthread -lvpx -lvorbisenc -lfreetype -llzma -lbz2 -lz -ldl -lavutil -lm

    # (ffmpeg-4.0 with all options (to clean))
    # brew install ffmpeg --with-chromaprint --with-fdk-aac --with-libass --with-librsvg --with-libsoxr --with-libssh --with-tesseract
    #--with-libvidstab --with-opencore-amr --with-openh264 --with-openjpeg --with-openssl --with-rtmpdump --with-rubberband --with-sdl2
    #--with-snappy --with-tools --with-webp --with-x265 --with-xz --with-zeromq --with-zimg
    # brew install opus

    LIBS += -L/usr/local/opt/x264/lib
    LIBS += -L/usr/local/opt/sdl/lib
    LIBS += -L/usr/local/opt/libvorbis/lib
    LIBS += -L/usr/local/opt/libvpx/lib
    LIBS += -L/usr/local/opt/theora/lib
    LIBS += -L/usr/local/opt/libogg/lib
    LIBS += -L/usr/local/opt/opus/lib
    LIBS += -L/usr/local/opt/lame/lib
    LIBS += -L/usr/local/opt/fdk-aac/lib
    LIBS += -L/usr/local/opt/libass/lib
}

linux-g++* {
    HEADERS  += src/podcast/ffmpeg/UBFFmpegVideoEncoder.h \
                src/podcast/ffmpeg/UBMicrophoneInput.h

    SOURCES  += src/podcast/ffmpeg/UBFFmpegVideoEncoder.cpp \
                src/podcast/ffmpeg/UBMicrophoneInput.cpp


    DEPENDPATH += /usr/lib/x86_64-linux-gnu

    LIBS += -lavformat -lavcodec -lswscale -lavutil \
            -l:libva-x11.so.2 \
            -l:libva.so.2 \
            -l:libxcb-shm.so.0 \
            -lxcb-xfixes \
            -lxcb-render -lxcb-shape -lxcb -lX11 -l:libasound.so.2 -l:libSDL-1.2.so.0 -l:libx264.so.152 -lpthread -l:libvpx.so.5 -l:libvorbisenc.so.2 -l:libvorbis.so.0 -l:libtheoraenc.so.1 -l:libtheoradec.so.1 -l:libogg.so.0 -l:libopus.so.0 -l:libmp3lame.so.0 -lfreetype -l:libfdk-aac.so.1 -l:libass.so.9 -l:liblzma.so.5 -l:libbz2.so.1 -lz -ldl -lswresample -lswscale -lavutil -lm

    FFMPEG_VERSION = $$system(ffmpeg --version|& grep -oP "version.*?\K[0-9]\.[0-9]")
    equals(FFMPEG_VERSION, 2.8) {
        LIBS -= -lswresample
        LIBS += -lavresample
    }
    equals(UBUNTU_VERSION, neon 18.04) {
        LIBS += -lxcb-render -lxcb-shape -lxcb -lX11 -l:libasound.so.2 \
                -l:libSDL-1.2.so.0 -l:libx264.so.152 -lpthread -l:libvpx.so.5 \
                -l:libvorbisenc.so.2 -l:libvorbis.so.0 -l:libtheoraenc.so.1 \
                -l:libtheoradec.so.1 -l:libogg.so.0 -l:libopus.so.0 \
                -l:libmp3lame.so.0 -lfreetype -l:libfdk-aac.so.1 \
                -l:libass.so.9 -l:liblzma.so.5 -l:libbz2.so.1 -lz -ldl \
                -lswresample -lswscale -lavutil -lm
    }
    equals(UBUNTU_VERSION, Ubuntu 19.04) {
        LIBS += -lxcb-render -lxcb-shape -lxcb -lX11 -l:libasound.so.2 \
                -l:libSDL-1.2.so.0 -l:libx264.so.155 -lpthread -l:libvpx.so.5 \
                -l:libvorbisenc.so.2 -l:libvorbis.so.0 -l:libtheoraenc.so.1 \
                -l:libtheoradec.so.1 -l:libogg.so.0 -l:libopus.so.0 \
                -l:libmp3lame.so.0 -lfreetype -l:libfdk-aac.so.1 \
                -l:libass.so.9 -l:liblzma.so.5 -l:libbz2.so.1 -lz -ldl \
                -lswresample -lswscale -lavutil -lm
    }

    QMAKE_CXXFLAGS += -std=c++11 # move this to OpenBoard.pro when we can use C++11 on all platforms
}
