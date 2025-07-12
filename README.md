# NJOY vs FRENDY Cross Section Comparison

This repository provides a framework for comparing evaluated nuclear data processed by two major nuclear data processing systems: **[NJOY](https://github.com/njoy/NJOY2016)** and **[FRENDY](https://rpg.jaea.go.jp/main/en/program_frendy/)**.

## 📘 Overview

The goal of this project is to:
- Process ENDF-formatted nuclear data files using both NJOY and FRENDY.
- Extract and visualize ACE-format cross section data.
- Perform a systematic comparison between the two outputs.
- Identify discrepancies and evaluate consistency across different energy groups and reactions.

## 🔧 Installation (Linux / Ubuntu)

### 📋 Prerequisites
### NJOY2016
Ensure the following packages are installed:
```bash
sudo apt update
sudo apt install git cmake gfortran build-essential

####To download and compile NJOY2016:

git clone https://github.com/njoy/NJOY2016.git
cd NJOY2016
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ../
make -j$(nproc)
```
### FRENDY
Ensure the following packages are installed:
```bash
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install tcsh build-essential gcc libboost-all-dev liblapack-dev libblas-dev libeigen3-dev
wget https://rpg.jaea.go.jp/download/frendy/frendy_20241030.tar.gz
tar -xvzf frendy_YYYYMMDD.tar.gz
cd frendy_YYYYMMDD/frendy
csh ./compile_all.csh
cd sample/run
csh ./run_frendy.csh
```
