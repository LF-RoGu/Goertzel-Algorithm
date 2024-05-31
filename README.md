# Goertzel Algorithm VHDL Implementation

This repository contains the VHDL implementation of the Goertzel Algorithm designed to detect a 150 kHz signal in a data set sampled at 4 MHz. The design is modular, synthesizable, and handles input and output data efficiently.

## Authors
> Name: Luis Fernando Rodriguez Gutierrez.
> 
> Matriculation Number: 7219085.

> Name: Sheikh Muhammad Adib
>
> Matriculation Number: 7219310

> Name: 
>
> Matriculation Number: 

> Name:
>
> Matriculation Number: 

## Shared Folder [Link](https://fhdoprod.sharepoint.com/:f:/r/sites/Stud-Microelectronic/Shared%20Documents/General?csf=1&web=1&e=UawF4C)
- Content
  - Milestone
  - Minute Meeting
  - Task Distribution
  - Design

## Project Overview

The Goertzel Algorithm is implemented with the following specifications:
- Number of samples (N): 135
- Input data: 12-bit unsigned (offset binary numbers)
- Internal data: 20-bit signed (2’s complement numbers)
- Sample frequency: 4 MHz
- Signal frequency to detect: 150 kHz
- Output: 20-bit signed level indication

## Modules

### Module A: Input Interface Module
- **Function**: Handles the input data stream from the ADC, converts 12-bit unsigned input data to 20-bit signed data.
- **Tasks**:
  - Accept 12-bit unsigned input samples.
  - Convert the 12-bit unsigned samples to 20-bit signed samples (2’s complement).
  - Pass the converted samples to the Goertzel Core Module.

### Module B: Goertzel Core Module
- **Function**: Implements the Goertzel algorithm to detect the presence and level of the 150 kHz signal within the input data.
- **Tasks**:
  - Initialize algorithm parameters.
  - Implement the Goertzel recurrence relation to process each sample.
  - Calculate the magnitude squared of the resulting complex number.
  - Pass the computed result to the Output and Scaling Module.

### Module C: Output and Scaling Module
- **Function**: Scales the Goertzel output to fit the desired output range and format, and provides the final signed output number.
- **Tasks**:
  - Accept the result from the Goertzel Core Module.
  - Apply necessary scaling to ensure the output fits within the 20-bit signed range.
  - Handle any overflow conditions.
  - Output the final 20-bit signed result.

### Module D: Control Unit Module
- **Function**: Coordinates the operation of the Input Interface, Goertzel Core, and Output and Scaling Modules, ensuring proper data flow and timing.
- **Tasks**:
  - Generate control signals for data sampling and processing.
  - Ensure proper sequencing of operations.
  - Manage the start and stop conditions for processing each data set.

### Module E: Testbench Module
- **Function**: Simulates the entire system to verify functionality and performance.
- **Tasks**:
  - Provide simulated input data to the Input Interface Module.
  - Capture and analyze the output from the Output and Scaling Module.
  - Verify the correctness of the overall design through various test scenarios.

## Getting Started

### Prerequisites
- VHDL Simulator (e.g., ModelSim, Vivado)
- FPGA Development Board (optional for synthesis and real-world testing)

### Setup
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/goertzel-vhdl.git
   cd goertzel-vhdl
