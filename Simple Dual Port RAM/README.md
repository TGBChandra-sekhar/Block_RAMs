# Simple Dual-Port RAM (Verilog Implementation)

## Overview

This project implements a **parameterized Simple Dual-Port RAM** using **Verilog HDL**.
The memory supports **one write port and one read port**, allowing **simultaneous read and write operations** on the same clock.

The design is written in a **synthesizable style** that allows **Block RAM (BRAM) inference** in FPGA tools such as **Xilinx Vivado**.

---

## Features

* Parameterized **address width** and **data width**
* **Separate read and write ports**
* **Simultaneous read and write capability**
* **Synchronous memory operation**
* Compatible with **FPGA BRAM inference**
* Includes a **testbench for simulation**

---

## Memory Configuration

| Parameter    | Description                           |
| ------------ | ------------------------------------- |
| `ADDR_WIDTH` | Number of address bits                |
| `DATA_WIDTH` | Width of each memory word             |
| `DEPTH`      | Total memory locations (2^ADDR_WIDTH) |

Example configuration:

ADDR_WIDTH = 8
DATA_WIDTH = 8

Memory Size = **256 × 8 bits**

---

## Architecture

A **Simple Dual-Port RAM** contains:

* One **write port**
* One **read port**
* Shared memory array
* Single clock domain

Operation:

* **Write operation:**
  When `we = 1`, data is written into memory at `waddr`.

* **Read operation:**
  Data at `raddr` is read and appears on `dout` on the next clock cycle.

```

---

## Testbench Overview

The testbench performs the following steps:

1. Initialize clock and signals
2. Write multiple values into memory
3. Disable write enable
4. Read values from memory
5. Print results in simulation console

---

## Example Simulation Output

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
simple-dual-port-ram/
│
├── simple_dual_port_ram.v
│
├── tb_simple_dual_port_ram.v
│
├── simulation.log
│
└── README.md
```

---

## Applications

Simple Dual-Port RAM is commonly used in:

* FIFO buffers
* Streaming data systems
* DSP pipelines
* Data buffering
* FPGA communication interfaces

---

## Tools Used

* Verilog HDL
* Xilinx Vivado Simulator
* GitHub for version control

---
## Author

**Chandra Sekhar Tanuku**
* B.Tech Electronics and Communication Engineering
* Focus Areas: **VLSI Design, FPGA, Digital Communication Systems**
---
