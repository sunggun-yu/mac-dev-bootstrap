# Mac Machine Setup

- [About](#about)
- [Before you begin](#before-you-begin)
- [Quick start](#quick-start)
- [Supported Goals](#supported-goals)
- [Supported Package managers](#supported-package-managers)
- [Directory structure and files](#directory-structure-and-files)
  - [goals file](#goals-file)
  - [host variables file](#host-variables-file)
- [Run Package Installation with goals](#run-package-installation-with-goals)
  - [using goals file](#using-goals-file)
  - [using argument](#using-argument)
- [Run Package Installation with tags](#run-package-installation-with-tags)
- [Examples](#examples)

## About

This is Ansible based package management automation by Ansible Playbook (Playbook) and Ansible Hosts (`goal`) with pre-defined package list as variable for `goal`.

## Before you begin

Checkout this or your forked repository into your local machine.

>💡 Recommendation:
>
> Highly recommned to fork this repository into your github account and make your own or team's package list for mac setup.

## Quick start

Simply executing the `make` command from the project root will start package installation for `brew`, `brew-cask`, `npm`, and `pip` of list in the `host_vars/default` directory by default. it will prompt account password to ensure `brew` package installation.

```bash
make
BECOME password: ****** [type-your-pwd]
```

setup and package installation.

## Supported Goals

- [`default`](./host_vars/default/README.md)
- [`aws`](./host_vars/aws/README.md)
- [`gcloud`](./host_vars/gcloud/README.md)
- [`golang`](./host_vars/golang/README.md)
- [`java`](./host_vars/java/README.md)
- [`k8s`](./host_vars/k8s/README.md)
- [`node`](./host_vars/node/README.md)
- [`team-devops`](./host_vars/team-devops/README.md)

## Supported Package managers

- `brew`: Hombrew package. `brew install [package]`
- `cask`: Homebrew Cask package. `brew install --cask [package]`
- `npm`: NPM package. `npm install --global [package]`
- `pip`: PIP package. `pip3 install [package]`

## Directory structure and files

```txt
├── goals.ini       # enabled and available goals list
├── host_vars
│   ├── aws         # packages variables for AWS
│   ├── default     # default package variable
│   ├── gcloud.yaml # packages variables for gcloud
│   ├── golang      # packages variables for golang
│   ├── java        # packages variables for java
│   ├── k8s         # packages variables for Kubernetes
│   ├── node        # packages variables for NodeJS
│   ├── team-devops # packages variables for team-devops.
│   │               #  example for team specific package list
│   └── template    # template of package variable files
│                   #  you can make your own package with this
└── playbook.yml
```

### goals file

(actually this is Ansible Host file)

`goals.ini` file manages the category of package. it has enabled 1 goal `default` by default. so that if you run `make` with no argument, it will just run package setup/installtion for list in `host_vars/default` directory.
you can execute multiple goals by adding other available goals.

```ini
## Ansible inventory file that is named as goals to be friendly for non-Ansible users
default

## Followings are available goals list. please uncommnent or add to enable installation of packages

# default
# aws
# gcloud
# golang
# java
# k8s
# node
# team-devops ## Example of team specific package management
```

### host variables file

each directory/file names under `host_vars` are 1:1 mapping with goal name in the `goal.ini` file.
you can make `host_var` as directory if you have many package list to deal with. or you can make single file like `goal-name.yaml` if you have small list of package.

```txt
└── host_vars
    ├── aws                     # example of directory format for aws
    │   └── brew-package.yaml   # only has brew package list file
    ├── default                 # example of directory format for default
    │   ├── brew-package.yaml   # brew package list
    │   ├── cask-packages.yaml  # brew-cask package list
    │   ├── npm-packages.yml    # npm package list
    │   └── pip-packages.yml    # pip package lit
    └── goal-name.yaml          # example of single file for goal-name goal
```

## Run Package Installation with goals

There are 2 way you can run multiple goals

- pass argument `goals` with comma seperated string when you run `make`
- enalbe `goal` name in the `goal.ini` file

### using goals file

just simply add `goal` name in the `goal.ini` file. this will be easy way if you are maintaining your own or teams package list.
please ensure host variable of directory or file must be in `host_vars` directory and name should match with your goal.

add yours or pre-defined goal in `goal.ini` file:

```ini
default
your-goal-name
k8s
```

and, just run make with no argument:

```bash
make
```

### using argument

there are 2 argument for `make` command

- `goals`: goal names to execute specific goals. comma separated string of goals
- `tags`: tag names to execute specific package type tag. comma separated string of tags

To run multiple `goals`:

```bash
make goals=java,golang,k8s,team-devops
```

>💡 using argument will ignore goals list in the `goal.ini` file

## Run Package Installation with tags

Use `tags` argument when you want to run specific type of package installation.
value for `tags` must be comma seperated string. e.g.: `tags=npm` , `tags=brew,cask,pip`

Global Tags: same as [Supported Package managers](#supported-package-managers)

- `brew`
- `cask`
- `npm`
- `pip`

Goal specific Tags:

- `gcloud` goal
  - `components`: `gcloud components install [package]`

## Examples

- Perform package installation for all goals in my `goal.ini` :

  ```bash
  # add available goals in the goal.ini. then,
  make
  ```

- Perform package installation for `java`,`node` and `k8s` :

  ```bash
  make goals=java,node,k8s
  ```

- Perform `npm` and `pip` package installation:

  ```bash
  make tags=npm,pip
  ```

- Perform `brew` package installation only for `java` and `k8s` goal:

  ```bash
  make goals=java,k8s tags=brew
  ```

- Perform `gcloud` components installation only:

  ```bash
  make goals=gcloud tags=components
  ```
