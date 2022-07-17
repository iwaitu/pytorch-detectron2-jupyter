FROM pytorch/pytorch:1.12.0-cuda11.3-cudnn8-runtime
EXPOSE 8888

RUN apt-get update && apt-get install -y \
    apt-utils \
    vim \
    git 
RUN apt-get install wget gcc g++ -y
RUN apt-get install libsm6 libxext6 -y
RUN apt-get update && apt-get install ffmpeg -y
RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh 
RUN conda init && conda config --set always_yes yes --set changeps1 no
RUN conda --version
RUN pip install pycocotools
RUN pip install opencv-python
RUN pip install git+https://github.com/facebookresearch/fvcore
RUN pip install cython
RUN pip install git+https://github.com/philferriere/cocoapi.git#subdirectory=PythonAPI
RUN python -m pip install 'git+https://github.com/facebookresearch/detectron2.git'
RUN pip install ipywidgets
RUN pip install jupyterlab
RUN jupyter nbextension enable --py widgetsnbextension
ENV JUPYTER_TOKEN=123456
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--allow-root", "--no-browser"]


