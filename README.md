# Docker container for ROOT with Jupyter Notebook

This imege enables Jupyter notebook on top of the official docker image of ROOT

## Prerequisite

You need to install docker first. Check [here](https://docs.docker.com/install/).

## Install

```bash
docker pull hfukuda/root-jupyter-notebook
```

## Usage

```
docker run --rm -p 8888:8888 hfukuda/root-jupyter-notebook
```

If one wants to expose the current directory, do
```
docker run --rm -p 8888:8888 -v $PWD:/home/jovyan/work hfukuda/root-jupyter-notebook
```
instead.
