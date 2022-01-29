
<!-- ABOUT THE PROJECT -->
## About The Project

An opinionated Python linter for Transifex Projects

It consists of three parts:
* <a href="https://black.readthedocs.io/en/stable/">black - Code Formater</a>
* <a href="https://flake8.pycqa.org/en/latest/">flake8 - Linter</a>
    * <a href="https://github.com/PyCQA/flake8-bugbear">bugbear - Plugin</a>
* <a href="#isort">isort - Import shorter</a></li>

## How to use

### Lint your branch

```sh
docker run --rm \
    --mount src="$(pwd)",target=/src,type=bind \
    transifex/txlint-py
```


### Integrate with **docker-compose**

1. Add the following in your docker-compose.yaml under `services` :
    ```yaml
    txlint:
        image: transifex/txlint-py
        volumes:
        - ./:/src
    ```

1. Run the txlinter with:
    ```bash
    docker-compose run txlint
    ```

### Integrate with **Jenkins**

Add the following stage in your `Jenkinsfile` :
```
stage('Run pre-commit hooks stage') {
    when {
        anyOf {
            changeRequest()
        }
    }
    steps {
        sh 'docker-compose run txlint'
    }
}