# Python Workflow
The Python workflow is supported by a few different tools:

 + asdf - For actually installing and managing Python versions
 + direnv - For auto-loading Python virtual environments (venv's)

## Installing Python
Assuming the `Brewfile` has been bootstrapped and installed, use asdf to install
the Python plugin:

```sh
asdf plugin-add python
```

Then install a specific Python version:

```sh
asdf install python 3.12.1
```

See installed version:

```sh
asdf list python
```

## Working in a Python project
From the top directory of a Python project, set the desired Python version:

```sh
asdf local python 3.12.1
```

This creates a `.tool-versions` file, and should change the current Python.
To confirm this is true:

```sh
asdf which python
python --version
which python
```

To create a virtual environment for the project:

```sh
python -m venv env
```

This creates an `env` directory, which you likely want to add to `.gitignore`.

To setup auto-environment loading, create the `.envrc` file:

```sh
echo "source env/bin/activate" > .envrc
```

Then allow `direnv` to use the file with:

```sh
direnv allow .
```

If everything is now working properly, `which python` should point to `./env/bin/python`,
and still match the version specified from `asdf`. Now, any library installs will be just
for this project, and not global.

Have fun, but never forget that Ruby is better! 😉
