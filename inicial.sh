#!/bin/bash

sleep 6m
gcloud compute reset-windows-password gc2d-bmgdb-9 --quiet --zone us-east1-b > pass.txt