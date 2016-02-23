# Docker container for MadGraph

[MadGraph](https://launchpad.net/mg5amcnlo) is a integrated event generator for the high energy phisics and
widely used in that field.
However, to install it correctly with Pythia and Delphes, some complicated process is needed and
it is a little bit hard for those who are not so familiar with \*nixs.

Here, I made a docker container for MadGraph. Docker is easy to use!

# install

```bash
$ docker pull hfukuda/madgraph
```

# usage

This container uses model files in /var/UFO\_models and outputs in /var/MG\_outputs.

So you should indicate these folders like this:

```bash
$ docker run -t -i -v $HOME/models:/var/UFO_models -v $HOME/outputs:/var/MG_outputs hfukuda/madgraph
```

Alternatively, you can use a volume container.
