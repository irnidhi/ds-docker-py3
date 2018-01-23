## Python3 based minimal Docker container for Data Science Development.

- Builds on the latest image of CentOS
- Installs Python
- Installs Development Tools (system libraries like `make`, `gcc`, `wget` …)
- Installs `git` version 2.x (because CentOS ships with version 1.8.x and that is obsolete)
- Set up `Jenkinsfile` and /src/ for packaging

## Pull the latest image
- Run `docker pull eadlab/ds-docker-py3`

## Run the Container
- Run `docker run -it -p 8080:8080 eadlab/ds-docker-py3`

## Run Jupyter
- Run `jupyter notebook --no-browser --ip 0.0.0.0 --port 8080 --allow-root`
- Access the Jupyter Web App on any browser by copy-pasting the URL

## To Build the Container from scratch
- Clone this repo.
- Open the Terminal and `cd` into the directory
- Run `docker build -t foobar .`

## Note

- The default environment comes with essentials like `pandas`, `seaborn`, `scikit-learn`, and `flask`
- The conda environment is activated automatically.
- Upload an `environment.yml` file to create a custom conda environment.
  - When you do this, the container will be re-built