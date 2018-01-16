## Minimal Docker container for Data Science Development. Runs Python 3.

---

- Builds on the latest image of CentOS
- Installs Python
- Installs Development Tools (system libraries like `make`, `gcc`, `wget`)
- Installs git version 2.x (because CentOS ships with version 1.8.x and that is obsolete)
- Set up Jenkinsfile and /src/ for packaging
- Upload an `environment.yml` file to create a custom (ex. Python3) `conda` environment.
