# Goertzel-Algorithm
Goertzel Algorithm implementation in VHDL

- [ ] Describe the Goertzel Algorithm
- [ ] Perform a literature research (e.g. via IEEExplore) and describe the State ofthe Art (SoA) for Goertzel ASIC and FPGA implementations.  Design a Goertzel Filter according to the specifications:  synthesizable VHDL Code
- [ ] N=135 (number of samples in a data set)  use 12 and 20 bit integer numbers (signed and unsigned datatypes fromieee.numeric_std)  Input data is 12 bit unsigned (offset binary numbers, like ADCs would deliver)  internal data is 20 bit signed (2‘s complement numbers)  apply appropriate scaling
- [ ] Sample frequency is 4 MHz
- [ ] signal frequency to detect is 150 kHz
- [ ] level indicated by a signed output number  Verify your Goertzel Filter design by means of a VHDL testbench:  Use Octave or Matlab to generate stimuli data (12 bit binary offset numbers) and
expected results
- [ ] store them in files that can be read by VHDL-Testbench
- [ ] Test Cases are:  Sine Waves with 150 kHz, 149 kHz, 151 kHz, 5 kHz, 200 kHz
- [ ] Square Waves with 150 kHz, 16 kHz, 10 kHz, 200 kHz
- [ ] Triangle wave with 150 kHz, 149 kHz, 151 kHz, 5 kHz, 200 kHz
- [ ] For all of the above alter phase angles: 0°, 30°, 45°, 90°, 120°
