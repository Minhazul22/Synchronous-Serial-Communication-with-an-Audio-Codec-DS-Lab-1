# FPGA Audio CODEC Interface — Synchronous Serial Communication

A VHDL-based FPGA laboratory project implementing synchronous serial audio data transfer between a Xilinx Artix-7 FPGA and a PCM3006 audio codec.

The project focuses on clock generation, serial/parallel data conversion, finite-state-machine-based timing control, simulation, and hardware-level signal verification.

## Project at a Glance

| Item | Details |
|---|---|
| Design language | VHDL |
| FPGA platform | Xilinx Artix-7 (XC7A100T) |
| Development environment | AMD Xilinx Vivado |
| Audio codec | PCM3006 |
| Board | ModSys 2.0 |
| Interface focus | Synchronous serial audio |
| Academic context | Digital Systems Laboratory, HAW Hamburg |

## Objectives

- Design and verify a synchronous serial interface between an FPGA and an external audio codec.
- Generate the clock signals required by the codec interface.
- Convert serial audio data to parallel samples and parallel samples back to serial data.
- Use finite state machine (FSM) control to coordinate transfers and left/right channel timing.
- Inspect simulated waveforms and use laboratory measurement equipment to investigate timing and signal behavior.

## System Overview

The FPGA exchanges digital audio data with the PCM3006 codec. The codec handles conversion between analog audio and digital samples; the FPGA-side logic coordinates clocks and serial data movement.

The documented clock signals are:

- **SYSCLK** — codec system/oversampling clock, intended to run at 256 times the sampling rate.
- **BCK** — bit clock for serial data transfer, intended to run at 32 times the sampling rate.
- **LRC** — left/right channel and sampling reference clock, approximately 48 kHz in this design.

The clocks are derived from a 100 MHz system clock using frequency division. Actual frequencies should be confirmed against the implementation and measured waveforms.

## Architecture

The existing design documentation identifies these functional blocks:

- **`CODEC_CLK_GEN`** — frequency divider that generates SYSCLK, BCK, and LRC.
- **`AUDIO_CDC_FSM`** — FSM that coordinates data-transfer timing.
- **`SER_TO_PAR_LR`** — converts incoming serial data into 16-bit samples.
- **`PAR_TO_SER_LR`** — converts 16-bit parallel samples into serial output; identified in the lab documentation as the main implemented module.
- **Audio processing / pass-through path** — forwards input samples to the output in the documented configuration.

### Data path

1. The codec samples an analog input and supplies digital serial data to the FPGA.
2. The FPGA receives and assembles serial data into parallel samples.
3. The design forwards or processes the samples.
4. The FPGA serializes the output samples for the codec.
5. The codec converts the digital output back to an analog signal.

## Verification Approach

The project documentation describes simulation and bench-level checks, including:

- Simulating the provided system testbench and custom tests for the parallel-to-serial converter.
- Inspecting waveforms for bit shifting and left/right channel synchronization.
- Observing DIN and DOUT alongside BCK and LRC.
- Measuring clock periods, timing relationships, and the delay between analog input and output using an oscilloscope.

**Results note:** This README summarizes the verification activities described for the project. Add captured waveforms, measured values, and test outcomes to the repository when the corresponding evidence is available.

## Hardware Setup

The documented setup uses:

- An Artix-7 FPGA on the ModSys 2.0 board
- A PCM3006 audio codec connected through the expansion hardware
- A function generator for the input signal
- An oscilloscope for signal and timing measurements
- Vivado for simulation, synthesis, and FPGA programming

Follow the original lab instructions and board-specific pin constraints when reproducing the setup. Hardware results depend on the exact board connections, constraints, clock configuration, and codec setup.

## Getting Started

1. Clone or download this repository.
2. Open the project in a compatible version of AMD Xilinx Vivado.
3. Review the VHDL sources, constraints, and supplied testbench.
4. Run the simulation and inspect the clock and serial-data waveforms.
5. Synthesize and implement the design for the target FPGA.
6. Program the board and perform hardware measurements only after checking the lab setup and pin assignments.

Exact commands and project-opening steps depend on the files and Vivado version included with the project.

## Limitations and Design Notes

- The sampling frequency is documented as approximately 48 kHz because the clock is derived by integer frequency division; verify the actual value from the implemented divider and measurements.
- The documented parallel-to-serial converter uses a single shift register for both channels. Review the RTL and timing carefully when evaluating channel handling.
- The audio path is described as pass-through, so output differences may include codec conversion effects, quantization, and analog hardware behavior.

## Skills Demonstrated

- VHDL RTL design and digital hardware reasoning
- Synchronous serial communication
- Clock division and timing relationships
- FSM-based control
- Serial-to-parallel and parallel-to-serial conversion
- FPGA simulation and implementation workflow
- Waveform inspection and hardware measurement

## Repository Contents

Browse the source files, testbench, constraints, and any available lab materials in this repository. File names and reproduction instructions should be updated here if the project structure changes.

## Academic Context

Developed as part of the Digital Systems Laboratory at Hochschule für Angewandte Wissenschaften Hamburg (HAW Hamburg). This repository represents a student laboratory implementation based on the assignment requirements.

Before redistributing course handouts, instructor-provided source files, or other course materials, check the university's sharing rules. Do not include material you are not permitted to publish.
