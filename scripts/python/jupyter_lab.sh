#!/usr/bin/env sh

cd ~/back/lang/python/startup/wander

export PYTHONSTARTUP=~/back/lang/python/startup/main.py

# cria o venv apenas se ainda não existir
if [ ! -d "wander_venv" ]; then
    python -m venv wander_venv
    . wander_venv/bin/activate
    pip install --upgrade pip
    pip install jupyterlab ipykernel
    python -m ipykernel install --user --name=wander_venv --display-name "Python (wander)"
else
    . wander_venv/bin/activate
fi

PYTHONSTARTUP=$PYTHONSTARTUP jupyter lab
