
<!-- ABOUT THE PROJECT -->
## About The Project

An opinionated linter for Transifex Projects

It consists of the following parts:
* <a href="https://black.readthedocs.io/en/stable/">black - Python Code Formater</a>
* <a href="https://flake8.pycqa.org/en/latest/">flake8 - Linter</a>
    * <a href="https://github.com/PyCQA/flake8-bugbear">bugbear - Plugin</a>
    * <a href="https://github.com/JBKahn/flake8-debugger">debugger - Plugin</a>
* <a href="#isort">isort - Import shorter</a></li>
* <a href="https://github.com/pre-commit/mirrors-eslint">ESLint - JS Code Formater</a>

## How to use

### Lint specific files

```bash
docker run --rm \
    --user ${USER_ID}:${GROUP_ID} \
    --mount src="$(pwd)",target=/src,type=bind \
    transifex/txlint --files \
    file_1.py /path/to/file_2.py
```

### Lint current branch

```bash
git diff origin/devel..$(git rev-parse HEAD) --name-only | \
    xargs docker run --rm \
        --user $(id -u):$(id -g) \
        --mount src="$(pwd)",target=/src,type=bind \
        transifex/txlint --files
```

### Makefile integration

```Makefile
pre-commit:
    git diff origin/devel..$(git rev-parse HEAD) --name-only | \
        xargs docker run --rm \
            --user $$(id -u):$$(id -g) \
            --mount src="$(pwd)",target=/src,type=bind \
            transifex/txlint --files
```


### Integrate with **Jenkins**

1. Ideally you would have a `Makefile` containing the previous example:
1. Add the following stage in your `Jenkinsfile` :
    ```Groovy
    stage('Run linter') {
        when {
            anyOf {
                changeRequest()
            }
        }
        steps {
            sh 'make pre-commit'
        }
    }