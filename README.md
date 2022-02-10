
<!-- ABOUT THE PROJECT -->
## About The Project

An opinionated linter for Transifex Projects

It consists of the following parts:
* <a href="https://black.readthedocs.io/en/stable/">black - Code Formater</a>
* <a href="https://flake8.pycqa.org/en/latest/">flake8 - Linter</a>
    * <a href="https://github.com/PyCQA/flake8-bugbear">bugbear - Plugin</a>
    * <a href="https://github.com/JBKahn/flake8-debugger">debugger - Plugin</a>
* <a href="#isort">isort - Import shorter</a></li>
* <a href="https://https://github.com/eslint/eslint">eslint - JS linter</a>
## How to use

### Lint specific files

```bash
docker run --rm \
    --mount src="$(pwd)",target=/src,type=bind \
    transifex/txlint-py --files \
    file_1.py /path/to/file_2.py
```

### Lint current branch

```bash
git diff origin/devel..$(git rev-parse HEAD) --name-only | \
    xargs docker run --rm \
        --mount src="$(pwd)",target=/src,type=bind \
        transifex/txlint-py --files
```

### Integrate with **docker-compose**

1. Add the following in your docker-compose.yaml under `services` :
    ```yaml
    txlint:
        image: transifex/txlint-py:0.1.0
        volumes:
        - ./:/src
    ```

1. Lint current branch:
    ```bash
    git diff origin/devel..$(git rev-parse HEAD) --name-only | \
        xargs docker-compose run --rm txlint --files
    ```

### Integrate with **Jenkins**

1. Ideally you would have a `Makefile` containing this entry:
    ```Makefile
    lint:
        git diff origin/devel..$(git rev-parse HEAD) --name-only | \
            xargs docker-compose run --rm txlint -v --files
    ```

1. Add the following stage in your `Jenkinsfile` :
    ```Groovy
    stage('Run linter') {
        when {
            anyOf {
                changeRequest()
            }
        }
        steps {
            sh 'make lint'
        }
    }