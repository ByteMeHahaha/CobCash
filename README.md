# CobCash

[![Compile and Link](https://github.com/ethanKletschke/CobCash/actions/workflows/CompileAndLink.yml/badge.svg)](https://github.com/ethanKletschke/CobCash/actions/workflows/CompileAndLink.yml)

A fixed-format COBOL app that imitates a transaction at a cashier till.

- Author: Ethan Kletschke
- Version: `1.0.0`
- Developed and Tested On: Windows 11
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
  - [Running the App](#running-the-app)

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
  what I prefer and am used to using for COBOL programming. Future COBOL 
  projects will swap between using fixed and free format.
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

## Features of This Project

- Items, payment, processing, output, and error screens defined in the `SCREEN` 
  section.
- Build and linting scripts for Windows CMD
- File handling with a sequential file
- Comprehensive data structures in the `DATA` division
- Generating a text file receipt with COBOL's Report Writer Control System 
  (RWCS)

## Running the App

To run the app, unzip the `.zip` that will be provided in the latest 
release of this repository, and run the `.exe`. 

GnuCOBOL is not a fully static compiler like GCC. It generates native executables,
but they depend on the GnuCOBOL runtime libraries (DLLs) to run — similar to how
Python or .NET applications require their runtime to be present.  
Because of this, GnuCOBOL DLLs are required when running the application on
Windows. The provided `.zip` should include all necessary DLLs. However, if the
program starts and reports missing DLLs, **please** open a GitHub issue and
include screenshots of the error messages — especially the names of any missing
DLLs — so they can be added.

You can build the application from source, but on Windows this is not recommended
unless you already have a working GnuCOBOL + MinGW setup. Configuring the toolchain
and collecting all required runtime DLLs can be difficult and error-prone.

For this reason, a pre-built GnuCOBOL distribution (such as
[Arnold Trembley's amazing binaries](https://www.arnoldtrembley.com/GnuCOBOL.htm)) 
was used to build the provided binaries, and the release ZIP includes the DLLs 
needed to run the program on Windows.

If you do build from source and encounter missing DLL errors, please report them
via a GitHub issue so they can be documented or included in future releases.
