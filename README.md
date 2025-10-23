# Projects-SV
System Verilog projects
FIFO

# Synchronous FIFO Design and Verification

## Overview
This project implements a **16x32-bit synchronous FIFO** in SystemVerilog with `full` and `empty` flag logic.  
A simple testbench verifies write and read operations using random stimulus.

## Files
- **top.sv** – FIFO design module with read/write tasks and pointer management.  
- **tb_fifo_basic.sv** – Testbench generating clock, reset, random writes, and sequential reads.

## Features
- Synchronous design using single clock.
- Handles reset, full, and empty conditions.
- Randomized test input with `$display`-based output monitoring.
- Supports 32-bit data width, 16-depth FIFO.

## How to Run
```bash
xmvlog top.sv tb_fifo_basic.sv
xmelab tb_fifo_basic
xmsim tb_fifo_basic
