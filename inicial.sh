#!/bin/bash

NOME_VM="$1"

gcloud compute instances add-metadata $NOME_VM --zone us-east1-b --metadata-from-file=sysprep-specialize-script-ps1=./scripts-powershell/script.ps1
sleep 6m
gcloud compute reset-windows-password $NOME_VM --quiet --zone us-east1-b > pass.txt