# How to deploy and manage own data cener

[![Apache-2.0 License](https://img.shields.io/badge/license-Apache--2.0-blue)](LICENSE-2.0.txt)

## Abstract

This document explains the how to deploy and manipulate the data center platform by using Kubernetes.

## Declines

Currently, this documents only supports Japanease becasue of my less English ability.
I would be grateful if you could help me to trancelate to other language ;).

## Description

Under construction

## Versioning policy

This software version indicates with 3 numeric number, `X.Y.Z` .
In order from `X` , it indicates `Measure version`, `Miner version` and `Maintenance version`.
These version only has the meaning in tags, not branches, commits.
If there is a questions or you pazzled, please ask to the maintener.

`Measure version` number increment indicates it had a big changes to the software, 
so there is no warranty of backward compatibility. 
For example, some main functions may become no longer available, or you may cannot migrate 
the configuration files from previous version as it is. 
This version number increment also means that this software policies, license,
libraries or runtimes were changed or upgraded.

`Miner version` number increment indicates it had some sub functions addition to the software 
and there still has a backward compatibility from previous version.

`Maintenance version` number increment indicates that it had some security upgrade or patching
to the software. All functions of this software are still available from previous version.
This number also indicates some modification to the documents of this software.

Sometimes it will be appended letters after the version number. 
(e.g. 'X.Y.Z.rc'. Not hyphen, always separated by single dot)
Theses letters indicates that this software is on some special status.
The statuses will be explained here if they will be added.

## License

Apache-2.0 License is applied to the sources (in most cases, they are put under the docs/source directory) 
and the documents made from the sources.