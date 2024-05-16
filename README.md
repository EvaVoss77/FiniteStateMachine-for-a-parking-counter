VHDL Implementation of a counter that determines the number of occupied spaces in a parking lot with a single entrance and capacity to accommodate 15 cars. The implementation utilizes finite state machine logic.

# Scenario
The parking lot has two sensors, a and b, at its entrance to determine whether a car is exiting or entering. When an object is in front of a sensor, it outputs a '1', and otherwise, it outputs a '0'. The counter increases when the sensors detect that a car has entered and decreases when they detect that a car has exited. The following figure shows the inputs a and b for the different cases.

![ENTRASALE](https://github.com/EvaVoss77/FiniteStateMachine-for-a-parking-counter/assets/126124561/a9c814bd-c808-4a7b-897b-dac5dfeb08f2)

# Implementation
The implementation consists of two main blocks: a `counter` and a finite state machine `FSM`. Additionally, a block was added to control the FPGA `display` so that it shows the value held by the counter. The block diagram of the program is shown in the following figure, where it can be observed that the `counter` block is connected to the `FSM` via the variables `en` and `up`, which determine whether the counter increases, maintains, or decreases its value.

![EsqAddDisp_page-0001](https://github.com/EvaVoss77/FiniteStateMachine-for-a-parking-counter/assets/126124561/94e945b4-23e8-443c-a6e0-ba70f6a0d663)

## Counter
The operation of the counter is based on Table. The variable `syn_clr` resets the counter when it is set to '1'. The `load` variable sets the counter to a value `d` when it is set to '1' and serves for eventual correction. The variables `en` and `up` determine whether the output value increases (`en`='1' and `up`='1'), decreases (`en`='1' and `up`='0'), or remains the same (`en`='0' and `up`='-').

| syn_clr | load | en | up | q         |
|---------|------|----|----|-----------|
| 1       | $-$  | $-$| $-$| "00...00" |
| 0       | 1    | $-$| $-$| d         |
| 0       | 0    | 1  | 1  | q+1       |
| 0       | 0    | 1  | 0  | q-1       |
| 0       | 0    | 0  | $-$| q         |

## FSM
This block is responsible for detecting whether a car has entered or exited the parking lot. It uses the variables $a$ and $b$ as inputs. The algorithm will consider that a car has entered or exited when the following sequences are met:

| a | 1 | 0 | ... | 0 |
|---|---|---|-----|---|
| b | 1 | 1 | ... | 0 |


| a | 1 | 1 | ... | 0 |
|---|---|---|-----|---|
| b | 1 | 0 | ... | 0 |

Where the ellipses indicate that the last inputs are repeated.

To detect these sequences, a Moore state machine, schematized in Figure, was utilized.

![Labo3 tp3_220915_112420](https://github.com/EvaVoss77/FiniteStateMachine-for-a-parking-counter/assets/126124561/30bf44c4-8dd7-457b-9f12-f96bacffe3c2)

This state machine consists of six states: `oo` (11), `oozo` (1101), `oooz` (1110), `idle`, `salio` (left) and `entro` (right). The transitions between states show the input values as a pair (`a`,`b`). While the input is "11", the machine remains in state `oo`, waiting for the next input to be 01 or 10 to transition to intermediate states `oozo` or `oooz`, respectively. The machine will stay in `oozo` or `oooz` as long as it continues to receive 01 or 10, respectively. If it receives input 11, the machine returns to state `oo`, and if it receives input 00, it goes to the `idle` state. If, while in any of the intermediate states, it receives 00, it transitions to the `salio` or `entro` states. The transitions in red to the `idle` state indicate that upon receiving any other input, the next state will be `idle`.

By default, the outputs will be `en='0'` and `up='0'`, so the counter maintains its value. The only states in which these will change are `entro` and `salio`. When the machine is in the `entro` state, the outputs will be `en='1'` and `up='1'`, so the counter increases its value, while when it is in the `salio` state, they will be `en='1'` and `up='0'`, and the counter will decrement its value.
