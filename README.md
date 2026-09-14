# CobCash

[![Compile and Link](https://github.com/ethanKletschke/CobCash/actions/workflows/CompileAndLink.yml/badge.svg)](https://github.com/ethanKletschke/CobCash/actions/workflows/CompileAndLink.yml)

A fixed-format COBOL app that imitates a transaction at a cashier till.

- Author: Ethan Kletschke
- Version: `1.2.0`
- Developed and Tested On: Windows 11 and Linux
- Targeted Platform: Windows 10 and above
- License: MIT
- Project Metadata File: [`project.yaml`](./meta/project.yaml)

---

- [CobCash](#cobcash)
  - [About the App](#about-the-app)
  - [Disclaimers](#disclaimers)
    - [About This Project](#about-this-project)
    - [Known Limitations and Bugs](#known-limitations-and-bugs)
  - [Features of This Project](#features-of-this-project)
  - [Running CobCash](#running-cobcash)
    - [Via the Latest GitHub Release](#via-the-latest-github-release)
    - [Compiling from Source](#compiling-from-source)
    - [Through a Docker Image](#through-a-docker-image)
    - [Notes](#notes)

---

## About the App

This program is a mockup of a cashier till application. You input the
cardholder's name, their 5-digit card PIN, amount owed (to pay), and the
amount paid via card. The program then validates the input values, displays
a processing screen for two seconds, and displays a payment summary. The app
then generates a receipt in the form of a text file (`Receipt.txt`).

## Disclaimers

### About This Project

- All COBOL source code intentionally follows _**fixed format**_, as this is
  what I used to prefer using for COBOL programming. Future COBOL
  projects will utilise free format
- The `meta` folder contains project metadata files that are not used for
  running the app.

### Known Limitations and Bugs

- GnuCOBOL’s implementation of the COBOL `SCREEN` section is somewhat finicky
  with user input.
  - The decimal points (`.`) in the numeric inputs are "glued" in place, and
    cannot be overwritten unless backspace is pressed (but this leads to another
    bug).
  - There is a chance that user input can overflow into different fields if the
    entered number is longer than the target field.
  - It is recommended to use the arrow keys to navigate to different fields.
  - Furthermore, if you press backspace in the numeric inputs, it'll remove
    the placeholder characters (i.e. `0` and `.`) and make input even more
    confusing.
      - To fix this, just use the arrow keys to navigate out of that
        field. This will refresh the formatting of that field.
- The receipt is not accessible on Docker without first mounting a volume to the
  CobCash container (see [here](#through-a-docker-image)).

## Features of This Project

- Items, payment, processing, output, and error screens defined in the `SCREEN`
  section.
- Build and linting scripts for Windows CMD and Bash
- File handling with a sequential file
- Comprehensive data structures in the `DATA` division
- Generating a text file receipt with COBOL's Report Writer Control System
  (RWCS)
- Verified to work across Linux, Windows, and through a Docker image

## Running CobCash

### Via the Latest GitHub Release

To run the app, unzip the `.zip` that will be provided in the latest
release of this repository, and run the `.exe`.

### Compiling from Source

If you have `cobc` and GnuCOBOL's runtime on your system, you can
clone the app and compile it from source.

This is done by:

1. Cloning the app with `git clone`
2. Navigating into the cloned project folder
3. Navigating into `scripts`
4. Running `build.cmd`

For Linux users, run the following in the project root folder:

```bash
# In case "bin" doesn't exist
mkdir bin
cobc -I ./src -x ./src/main.cbl ./src/**.cbl -o ./bin/CobCash -w -q
./bin/CobCash
```

**NOTE**: The app has been tested on Linux and works correctly. Just ensure that
you install GnuCOBOL with the following command before running the app:

```bash
sudo apt install gnucobol3
```

### Through a Docker Image

To build the Docker image via the repository's `Dockerfile`, run the following
commands in the root folder of the project:

```bash
# Create a volume to access the receipt
docker volume create cobcash-data

# Build the Dockerfile
docker build -t cobcash:1.2 .
```

Then to run it:

```bash
docker run --rm -it --mount source=cobcash-data,target=/app cobcash:1.2
```

Note: Running the image directly through Docker Desktop's container UI will not
work, as the application requires an interactive TTY terminal. Run the container
from the terminal as described above.

### Notes

GnuCOBOL is not a fully static compiler like GCC. It generates native executables,
but they depend on the GnuCOBOL runtime libraries (DLLs) to run — similar to how
Python or .NET applications require their runtime to be present.
Because of this, GnuCOBOL DLLs are required when running the application on
Windows. The provided `.zip` should include all necessary DLLs. However, if the
program starts and reports missing DLLs, **please** open a GitHub issue and
include screenshots of the error messages — especially the names of any missing
DLLs — so they can be added.

You can build the application from source on Linux or Windows, but this is not
recommended on Windows systems unless you already have a working GnuCOBOL +
MinGW setup. Configuring the toolchain and collecting all required runtime DLLs
can be difficult and error-prone.

For this reason, a pre-built GnuCOBOL distribution (specifically one of
[Arnold Trembley's amazing binaries](https://www.arnoldtrembley.com/GnuCOBOL.htm))
was used to build the provided binaries, and the release ZIP includes the DLLs
needed to run the program on Windows.

If you do build from source and encounter missing DLL errors, please report them
via a GitHub issue so they can be documented or included in future releases.
