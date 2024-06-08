# Trojan Tool Hardware

This directory contains all the FPGA logic used to create the hardware for the Trojan Tool.

## Steps to use this Repo
* Run `build_design.sh`. This will generate the Vivado project and create the bitstream.
* Save the important artifacts by running `save_artifacts.sh`.

---
## Trojan Tool Register Map

The Trojan Tool is highly configurable. You can use the Trojan Tool in different ways:
1. Using the Trojan Tool ISA. You can use the pseudocode commands/instructions pre-defined in the Trojan Tool ISA.
2. Hack Trojan Tool. You can create your own pseudo commands and play with the coherence system. This gives you ultimate control over the coherence protocol, but be aware that this may break the protocol if you do not take care and use unsupported coherence operations.
	- You can configure almost all properties of a coherence protocol and combine various settings to experiment with the coherence protocol (on the go).

|       Reg       |          Name          | Description                                                                                                                                                                       |
| :-------------: | :--------------------: | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|      0x00       |      **Control**       | Controls the functions of the IP                                                                                                                                                  |
|      0x04       |       **Status**       | Status of the IP                                                                                                                                                                  |
|      0x08       |       **Delay**        | Sets the delay to reply to CCI snoop requests                                                                                                                                     |
|      0x0C       |      **ACSNOOP**       | Snoop request filter. When active, in Ctrl Reg, the IP will only reply to the selected AC                                                                                         |
|      0x10       |     **Base ADDR**      | Address filter, base address.                                                                                                                                                     |
|      0x14       |     **Mem. Size**      | Address filter, size of the memory region to filter.                                                                                                                              |
|      0x18       |      **ARSNOOP**       | Define the type of read snoop.                                                                                                                                                    |
|      0x1C       |      **L_ARADDR**      | Low 32 bits of ARADDR.                                                                                                                                                            |
|      0x20       |      **H_ARADDR**      | High 8 bits of ARADDR. The remaining bits are ignored.                                                                                                                            |
|      0x24       |      **AWSNOOP**       | Define the type of write snoop.                                                                                                                                                   |
|      0x28       |      **L_AWADDR**      | Low 32 bits of AWADDR.                                                                                                                                                            |
|      0x2C       |      **H_AWADDR**      | High 8 bits of AWADDR. The remaining bits are ignored.                                                                                                                            |
|      0x30       |      **Reserved**      | Reserved                                                                                                                                                                          |
|      0x34       |      **Reserved**      | Reserved                                                                                                                                                                          |
|      0x38       |      **Reserved**      | Reserved                                                                                                                                                                          |
|      0x3C       |      **Reserved**      | Reserved                                                                                                                                                                          |
|      0x40       |       **DATA0**        | Data at base {H_ARADDR,L_ARADDR}, if read operation, or at base {H_AWADDR,L_AWADDR}, if write operation                                                                           |
| 0x40 + 0x04 * n |       **DATAn**        | Data at Base + 0x4 * n                                                                                                                                                            |
|      0x80       |   **START_PATTERN0**   | Pattern Where the Coherent Trojan Should Start their actions, element 0.                                                                                                          |
| 0x80 + 0x04 * n |   **START_PATTERNn**   | Pattern Where the Coherent Trojan Should Start their actions, Base + 0x4 * n                                                                                                      |
|      0xC0       | **Start_Pattern_Size** | The size of the pattern in words, it could range from 1 word up to 16 (i.e., cache line)                                                                                          |
|      0xC4       |     **Word_Index**     | Define the words to be tamper with in a CL. This registers uses 16 bits, one bit per word. When the bit is 1, the word will be tampered with the data written to DATAX registers. |
|      0xC8       |    **END_PATTERN0**    | Pattern Where the Coherent Trojan Should Stop their actions, element 0.                                                                                                           |
| 0xC8 + 0x04 * n |    **END_PATTERNn**    | Pattern Where the Coherent Trojan Should Stop their actions, Base + 0x4 * n                                                                                                       |
|      0x108      |  **End_Pattern_Size**  | The size of the pattern in words, it could range from 1 word up to 16 (i.e., cache line)                                                                                          |
|      0x10C      |   **Deanon_Address**   | The Physical address corresponding to the deanonimize code/data.                                                                                                                  |

---
###  Control Reg Bitmap

|  bit  | N bits |    Name     | Description                                                                                                                                 |
| :---: | :----: | :---------: | ------------------------------------------------------------------------------------------------------------------------------------------- |
|   0   |   1    |   **EN**    | Enable the IP                                                                                                                               |
|  4:1  |   4    |  **TEST**   | Chooses the type of tests to be performed, [see](#Tests).                                                                                   |
|  8:5  |   4    |  **FUNC**   | Chooses the functions of the IP, [see](#Functions)                                                                                          |
| 13:9  |   5    | **CRRESP**  | The response the IP will send to a snoop request.                                                                                           |
|  14   |   1    |  **ACFLT**  | Snoop Request Filter. If `high` the IP will only respond to AC equal to value on **ACSNOOP reg**                                            |
|  15   |   1    | **ADDRFLT** | Address Filter. If `high` the IP will only respond to AC to the address range **ADDR reg + Size reg**                                       |
|  16   |   1    |  **OSHEN**  | Enable or disable the one shot delay of the snoop response, [see](#Functions )                                                              |
|  17   |   1    |  **CONEN**  | Enable or disable the continuous delay of the snoop response, [see](#Functions )                                                            |
|  18   |   1    |  **ADLEN**  | Enable or disable the **A**ctive **D**ata **L**eak, [see](#Functions )                                                                      |
|  19   |   1    |  **ADTEN**  | Enable or disable the **A**ctive **D**ata **T**ampering, [see](#Functions )                                                                 |
|  20   |   1    |  **PDTEN**  | Enable or disable the **P**assive **D**ata **T**ampering, [see](#Functions )                                                                |
|  21   |   1    |  **MONEN**  | Enable or disable the **Mon**itor of transactions                                                                                           |
| 25:22 |   4    |   **CMD**   | Send the command for the devil control to execute, [see](#Commands )                                                                        |
|  26   |   1    | **STENDEN** | Enable or disable the Coherent Trojan capability to perform actions between two trigger patterns.  **St**art pattern and a **En**d pattern. |
| 31:27 |   14   |  **RESV**   | Reserved                                                                                                                                    |

### Status Reg Bitmap

| bit  | N Bits |     Name     | Description                                                                                                                                           |     |
| :--: | :----: | :----------: | ----------------------------------------------------------------------------------------------------------------------------------------------------- | --- |
|  0   |   1    |   OSH_END    | The One-Shot delay has been applied to one snoop. Cleared by SW, writing 1.                                                                           |     |
|  1   |   1    |     BUSY     | The devil is busy doing a reply.                                                                                                                      |     |
| 2:17 |   16   | DEANON_COUNT | Counts the number of successfulll matches (i.e., deanonimizitions), up to 65535. This field is cleaned when the IP is disabled, i.e., control.en = 0. |     |


---
### Tests

| value  |   Name   | Description                                 |
|:------:|:--------:| ------------------------------------------- |
| 0b0000 |   Fuzz   | Fuzzing. Combination of several test inputs |
| 0b0001 | DELAY_CR | Reply with Delay `crvalid`                  |
| 0b0010 | DELAY_CD | Reply with Delay `cdvalid`                  |
| 0b0011 | DELAY_CL | Reply with Delay `cdlast`                   |
| 0bxxxx | Reserved | Reserved                                    |

### Functions

| value  |   Name   | Description                                                                                                               |
| :----: | :------: | ------------------------------------------------------------------------------------------------------------------------- |
| 0b0000 |   OSH    | One-Shot Delay. The IP just delyas one time the snoop response. The delay is defined by **DELAY reg** value               |
| 0b0001 |   CON    | Continuous Delay. The IP is constantly delaying the snoop requests while the **CONEN bit** is active                      |
| 0b0010 |   ADL    | **A**ctive **D**ata **L**eak. The IP issues a snoop request to read an address when the **ADLEN bit** is active           |
| 0b0011 |   ADT    | **A**ctive **D**ata **T**ampering. The IP issues a snoop request to write to an address when the **ADTEN bit** is active  |
| 0b0100 |   PDT    | **P**assive **D**ata **T**ampering. The IP responds to a snoop requests with wrong data while the **PDTEN bit** is active |
| 0b0101 |   DMY    | **D**u**m**m**y**. The IP does a dummy reply (acts as a empty cache line, i.e., "don't have the cache line")              |
| 0bxxxx | Reserved | Reserved                                                                                                                  |

### Commands

| value  |     Name      | Description                                                                             |
| :----: | :-----------: | --------------------------------------------------------------------------------------- |
| 0b0000 | CMD_LEAK_KEY  | Upon an event/trigger detection, the IP will steal a cryptographic key.                 |
| 0b0001 |  CMD_POISON   | Upon an event/trigger detection, the IP will tamper with a data structure.              |
| 0b0010 | CMD_TAMPER_CL | Upon an event/trigger detection, the IP will tamper with a Cache Line.                  |
| 0b0011 | CMD_DELAY_CR  | Upon an event/trigger detection, the IP will delay reply (reg **Delay**) amount of time |
| 0b0100 |  CMD_DEANON   | Upon an event/trigger detection, the IP will output the deanonimize address             |
| 0bxxxx |   Reserved    | Reserved                                                                                |

---
