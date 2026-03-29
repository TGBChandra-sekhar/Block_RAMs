# True Dual-Port RAM (Verilog Implementation)

## Overview
This project implements a **parameterized True Dual-Port RAM** using **Verilog HDL**.

The memory supports **two fully independent ports (Port A and Port B)**.  
Each port can **independently perform read or write operations**, allowing **simultaneous access** to the same memory from two different clock domains.

The design is written in a **synthesizable style** that allows **Block RAM (BRAM) inference** in FPGA tools such as **Xilinx Vivado**.

---

## Features
- Two **fully independent ports**
- Each port supports **read and write**
- **Independent clocks** for Port A and Port B
- Parameterized **address width** and **data width**
- **Simultaneous read/write operations**
- Synchronous memory behavior
- Compatible with **FPGA BRAM inference**
- Includes a **parameterized testbench**

---

## Memory Configuration

| Parameter | Description |
|---------|-------------|
| `ADDR_WIDTH` | Number of address bits |
| `DATA_WIDTH` | Width of each memory word |
| `DEPTH` | Total memory locations (2^ADDR_WIDTH) |

Example configuration:

ADDR_WIDTH = 10  
DATA_WIDTH = 8  

Memory Size = **1024 × 8 bits**

---

## Architecture

A **True Dual-Port RAM** consists of:

- **Port A**
  - Clock
  - Write enable
  - Address
  - Write data
  - Read data

- **Port B**
  - Clock
  - Write enable
  - Address
  - Write data
  - Read data

Both ports access a **shared memory array** and operate **independently**, even on **different clocks**.

---

## Operation

- **Write Operation**  
  When `we_a` or `we_b` is asserted, the corresponding port writes data into memory at the given address.

- **Read Operation**  
  Data is read synchronously and appears on the output **after the rising edge of the respective clock**.

- **Simultaneous Access**  
  Both ports can read, write, or perform read/write operations at the same time.

---
## Testbench Overview

**The testbench verifies:**
  - Port A write operation
  - Port B read operation
  - Simultaneous read/write on both ports
  - Independent clock operation
  - Correct memory behavior
---
## Example Simulation Output
```
PORT_A WRITE OPERATION
Writing: ADDR=0 DATA=0
Writing: ADDR=1 DATA=5
Writing: ADDR=2 DATA=10

PORT_B READ OPERATION
Reading: ADDR=0 DATA=0
Reading: ADDR=1 DATA=5
Reading: ADDR=2 DATA=10

SIMULTANEOUS OPERATION
ADDR_A=5 WRITE_DATA_A=25 | ADDR_B=5 READ_DATA_B=25
```
---
## Project Structure
```
true-dual-port-ram/
│
├── true_dual_port_ram.v
│
├── tb_true_dual_port_ram.v
│
├── simulation.log
│
└── README.md
```
---
## Notes
  - Memory contents are undefined at power-up unless written.
  - Read operations are synchronous.
  -This behavior matches real FPGA BRAM hardware.

---
## Applications
  - Shared memory systems
  - Multi-core processors
  - Dual-channel DMA buffers
  - High-throughput DSP systems
  - FPGA interconnect fabrics

---
## Tools Used
  - Verilog HDL
  - Xilinx Vivado
  - GitHub

---
##  Author
**Chandra Sekhar Tanuku**
* B.Tech Electronics and Communication Engineering
* Focus Areas: **VLSI Design, FPGA, Digital Communication Systems**
---
