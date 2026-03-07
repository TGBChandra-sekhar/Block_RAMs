# Single Port BRAM (Block RAM) – Verilog Implementation

## Overview

This project implements a **Single Port Block RAM (BRAM)** using **Verilog HDL**.
The design supports parameterized **address width** and **data width**, making it reusable for different memory sizes.

The memory supports **synchronous write and read operations** using a single clock.

This project was simulated using **Xilinx Vivado** and demonstrates basic **FPGA on-chip memory design**.

---

## Features

* Parameterized memory size
* Synchronous read and write
* Single clock operation
* Configurable address and data width
* Simple enable-based write control
* Testbench included for simulation verification

---

## Memory Configuration

| Parameter  | Description                           |
| ---------- | ------------------------------------- |
| ADDR_WIDTH | Number of address bits                |
| DATA_WIDTH | Width of each memory word             |
| DEPTH      | Total memory locations (2^ADDR_WIDTH) |

Example:

ADDR_WIDTH = 8
DATA_WIDTH = 8

Memory Size:

256 locations × 8 bits

---

## Design Architecture

Single Port RAM contains:

* Memory array
* Address input
* Data input
* Data output
* Enable signal
* Clock signal

Operation:

* When **en = 1**, data is written into memory.
* When **en = 0**, memory performs a read operation.

---


## Testbench

The testbench verifies both **write** and **read** operations.

Steps performed in simulation:

1. Initialize signals
2. Write data into memory
3. Disable write
4. Read data from memory
5. Display output in the console

---

## Simulation Output

Example output from simulation console:

```
------ WRITE OPERATION ------
Writing: addr=0 data=0
Writing: addr=1 data=10
Writing: addr=2 data=20
Writing: addr=3 data=30

------ READ OPERATION ------
Reading: addr=0 data=0
Reading: addr=1 data=10
Reading: addr=2 data=20
Reading: addr=3 data=30
```

---

## Project Structure

```
single-port-bram/
│
├──  single_port_bram.v
│
├──  tb_single_port_bram.v
│
├── simulation.log
│
└── README.md
```

---

## Applications

Single Port BRAM is commonly used in:

* FPGA data buffering
* FIFO memory
* Lookup tables
* Image processing
* DSP data storage
* Embedded processor memory

---

## Tools Used

* Verilog HDL
* Xilinx Vivado Simulator
* GitHub for version control
  
---
## Author

**Chandra Sekhar Tanuku**
---
* B.Tech Electronics and Communication Engineering
* Focus Areas: **VLSI Design, FPGA, Digital Communication Systems**
---

## License

This project is open-source and can be used for educational purposes.
