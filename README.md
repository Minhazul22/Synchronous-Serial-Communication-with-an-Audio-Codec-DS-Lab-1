# Synchronous Serial Communication with an Audio Codec (FPGA / VHDL)


This project implements a **synchronous serial audio communication interface** between an FPGA and an external **PCM3006 audio codec**. The system is developed in **VHDL**, simulated and verified in **AMD Xilinx Vivado**, and deployed on a **Xilinx Artix-7 FPGA (ModSys 2.0 board)**.

---

## 🎓 Academic Context

This project was developed as part of a laboratory course at:

**Hochschule für Angewandte Wissenschaften Hamburg (HAW Hamburg)**  
Course: *Digitale Systeme / Digital Systems Laboratory*  
Instructor: **Prof. Dr.-Ing. Lutz Leutelt**

The implementation presented in this repository is an **independent student solution**, based on the lab assignment requirements.

---


## 📌 Objectives

- Develop a **serial communication interface** to an external digital module (audio codec)
- Design and implement a **parallel-to-serial converter (VHDL)**
- Use **finite state machines (FSM)** for timing control
- Understand **audio sampling synchronization**
- Perform **simulation, synthesis, and FPGA testing**
- Analyze timing behavior using an **oscilloscope**

---

## 🧠 System Overview

The FPGA communicates with the **PCM3006 audio codec** using a synchronous serial protocol. The system operates with three derived clock signals:

- **SYSCLK** – Oversampling clock (256 × sampling rate)
- **BCK (Bit Clock)** – Serial data clock (32 × sampling rate)
- **LRC (Left/Right Clock)** – Sampling clock (~48 kHz)

All clocks are generated from a **100 MHz system clock** using frequency division.

---

## 🔧 Architecture

The design consists of the following modules:

- **Frequency Divider (`CODEC_CLK_GEN`)**
  - Generates SYSCLK, BCK, and LRC

- **Finite State Machine (`AUDIO_CDC_FSM`)**
  - Controls timing of data transfer and sampling

- **Serial-to-Parallel Converter (`SER_TO_PAR_LR`)**
  - Converts incoming serial data into 16-bit samples

- **Parallel-to-Serial Converter (`PAR_TO_SER_LR`)**
  - Converts 16-bit parallel data into serial output  
  - ✅ *Main module implemented in this project*

- **Audio Processing Module**
  - Currently forwards input directly to output

---

## 🔄 Data Flow

1. Analog signal enters codec via **LINE IN**
2. Codec converts signal → digital serial data
3. FPGA:
   - Receives serial input (`DIN`)
   - Converts to parallel samples
   - Processes or forwards data
   - Converts back to serial (`DOUT`)
4. Codec converts signal back → analog output (**LINE OUT**)

---

## 🧪 Simulation & Verification

- Full system simulation using provided **testbench**
- Custom test cases for **parallel-to-serial converter**
- Waveform analysis in Vivado to verify:
  - Bit shifting correctness
  - Channel synchronization (Left/Right)
  - Timing behavior

---

## ⚙️ Hardware Implementation

- **FPGA:** Xilinx Artix-7 (XC7A100T)
- **Board:** ModSys 2.0
- **Toolchain:** AMD Xilinx Vivado
- **Audio Codec:** PCM3006

### Setup

- FPGA programmed via JTAG
- Audio codec connected via expansion board
- Input signal generated using function generator
- Signals analyzed using oscilloscope

---

## 📊 Experiments

### Analog Signal Test
- Input sinusoidal signals (1 kHz – 30 kHz)
- Observe output signal behavior and distortion

### Digital Signal Analysis
- Capture DIN/DOUT with BCK and LRC
- Decode 16-bit samples for left and right channels

### Timing Verification
- Measure:
  - Bit clock period
  - Setup and hold times
  - Signal delays

### System Delay
- Measure delay between LINE IN and LINE OUT
- Analyze contributions from FPGA and codec

---

## 📈 Results

- Successful serial communication with audio codec
- Correct synchronization of sampling and bit transfer
- Accurate analog signal reconstruction
- Timing verified using oscilloscope

---

## 📎 Notes

- Sampling frequency is approximate (~48 kHz) due to clock division limits
- Parallel-to-serial converter uses a **single shift register for both channels**
- Output signal initially matches input (except quantization effects)

---

## 🚀 Getting Started

1. Open project in **Vivado**
2. Run simulation using provided testbench
3. Implement and verify `PAR_TO_SER_LR.vhd`
4. Synthesize and program FPGA
5. Test using function generator and oscilloscope

---

## 📚 Learning Outcomes

- VHDL-based hardware design
- Serial communication protocols
- FSM-based timing control
- FPGA development workflow
- Real-world signal measurement and debugging
