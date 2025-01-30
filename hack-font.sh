git submodule update --depth 2 --init --recursive
cd Ligatured-Hack
docker build . -t ligatured-hack
docker run -v $(pwd)/fonts/output:/usr/src/app/fonts/output ligatured-hack
open fonts/output/HackFCLigatured-Regular.ttf
