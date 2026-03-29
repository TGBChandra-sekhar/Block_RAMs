# Synchronous FIFO (Sync FIFO)

##  Overview
This project implements a **parameterized Synchronous FIFO (First-In First-Out)** buffer in **Verilog HDL**, where both read and write operations are performed using a **single common clock**.  
The design is suitable for buffering data between modules operating in the **same clock domain**.

---

##  Key Features
- Single-clock synchronous FIFO architecture  
- Parameterizable data width and depth  
- Full and Empty flag generation  
- Safe read and write pointer management  
- Supports continuous back-to-back read/write operations  
- Synthesizable and FPGA-friendly design  

---

##  FIFO Architecture
- **Write Pointer (wptr):** Controls write address increment  
- **Read Pointer (rptr):** Controls read address increment  
- **Memory Array:** Stores FIFO data  
- **Status Flags:**  
  - `full` – Indicates FIFO is full  
  - `empty` – Indicates FIFO is empty  

Both pointers are updated on the **same clock edge**, ensuring simple control logic and reliable operation.

---

##  Interface Description

| Signal | Direction | Description |
|------|----------|-------------|
| `clk` | Input | System clock |
| `rst` | Input | Active-high synchronous reset |
| `wr_en` | Input | Write enable |
| `rd_en` | Input | Read enable |
| `wdata` | Input | Data input |
| `rdata` | Output | Data output |
| `full` | Output | FIFO full indicator |
| `empty` | Output | FIFO empty indicator |

---

##  Parameters

| Parameter | Description |
|---------|-------------|
| `DATA_WIDTH` | Width of FIFO data |
| `DEPTH` | Number of FIFO entries |

---

##  Verification
- Self-checking testbench written in Verilog  
- Verified correct FIFO behavior for:
  - Full and empty conditions  
  - Simultaneous read and write  
  - Boundary conditions  
- Functional simulation performed using:
  - **QuestaSim**
  - **Vivado Simulator**

---

##  Tools Used
- Verilog HDL  
- Xilinx Vivado  
- QuestaSim / ModelSim  

---
```
##  Directory Structure
Sync_FIFO/
├── sync_fifo.v
├── tb_sync_fifo.v
├── simulate.log
├── sync_fifo_waveform.png
└── README.md
```
---

##  Applications
- Data buffering in synchronous digital systems  
- Producer–consumer architectures  
- Communication interfaces  
- Pipelined processing blocks  

---

## Author

**Chandra Sekhar Tanuku**
* B.Tech Electronics and Communication Engineering
* Focus Areas: **VLSI Design, FPGA, Digital Communication Systems**
---
