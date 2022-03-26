# t-labs

t-labs is a contanerized solution for prototaping or develop your data science and machine learning projects. It allows the user to launch, inside a docker container, an instance of a **jupyter lab**.

## Highlights

- 💫 It is a cool Jupyter Lab!
- ⚡️ Inside an even cooler Docker container.
- 🚀 The container's building process can automatically install the dependencies of the user's project.
- 🔐 But as default (only `jupyterlab` package), the image only weights 301MB!


## Getting started

The main idea behind the project is to have a base **dockerized** jupyter lab that can be used in different projects without mixing dependencies, etc.

### Build the image

Users can *git clone* their own repositores inside of the t-labs folder. t-labs won't commit any changes related to user's repos as it can only track its own files.

After clonning the repo, next step is to build it. There are two options here, using the `--build-arg` parameter of the docker build:

    docker build --build-arg folder=./own_folder -t t-labs .

It will search inside the user's repo for a `requirements.txt` file and install its dependencies with the ones needed by the container (that are defined inside `labs_requirements.txt`). So after building the image, it will have all the packages needed by the user.

The second option is to omit the `build-args` parameter:

    docker build -t t-labs .

In this case, the jupyter lab will have no installed packages (except for the ones inside `labs_requirements.txt`). So it will start with the basic dependencies.

In the building process, the Dockerfile makes use of **multi-stage build**, in order to optimize image size. The *researcher* user will be the default user and `/home/researcher/labs` the default working directory. Users can change the name inside the Dockerfile.

### 1st launch

Once the image is built, it is time to run the container:


    docker run -d -v $(pwd)/own_folder:/home/researcher/labs -p 8888:8888 --name container_name t-labs

User's `own_folder` is mounted in the container's `/home/researcher/labs` so that the changes done in the notebooks are also saved in the host files.

    docker logs container_name

Password can be changed using the generated token (using the command above the user can see which is the token) accesing http://address:port. However, the container has to be restarted in order to make the change effective.

    docker container restart container_name

### nth launch

Once done the basic setup in the 1st launch, the user can `start` or `stop` the container with no worries. While the container is not deleted, it will have the setup´'s config stored!