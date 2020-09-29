# FROM pytorch/pytorch:1.2-cuda10.0-cudnn7-devel
FROM tensorflow/tensorflow:1.12.3-gpu-py3
# FROM tensorflow/tensorflow:1.15.4-gpu-py3
ENV LC_ALL=C.UTF-8
#RUN apt update && apt install -y libgl1-mesa-glx libglib2.0-0
RUN pip install --upgrade pip
RUN pip install cython opencv-python pillow matplotlib
#RUN cd / && git clone https://github.com/Guanghan/lighttrack
RUN apt-get update
RUN apt-get install -y ffmpeg libsm6 libxext6
RUN pip install torch torchvision
COPY . /lighttrack
RUN cd /lighttrack/lib && make
RUN cd /lighttrack/graph/torchlight && python setup.py install
WORKDIR /lighttrack

CMD /bin/bash
# docker build . -t lighttrack:latest
# docker build . -t lighttrack:1.12.3-gpu
# docker run --gpus all --net=host --ipc=host -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --privileged --device=/dev/video0:/dev/video0 -v /home/tiger/code/github-origin/lighttrack/weights:/lighttrack/weights -it --name lighttrack lighttrack:latest bash
# without mount option
# docker run --gpus all --net=host --ipc=host -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --privileged --device=/dev/video0:/dev/video0  -it --name lighttrack lighttrack:latest bash