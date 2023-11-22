#!/usr/bin/env nix-shell
#!nix-shell --pure -p verilator -i bash

verilator --lint-only -Wall ./hdl/backstabber_v1_0.v