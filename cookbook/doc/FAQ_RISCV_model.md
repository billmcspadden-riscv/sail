# Frequently Asked Questions about the Sail RISC-V Golden Model

- [Q: Is there support for multi-HART or multi-Core simulation?](#is-there-support-for-multi-hart-multi-core-simulation)
- [Q: What is the meaning of life, the universe and everything?](#q-what-is-the-meaning-of-life-the-universe-and-everything)
- [Q: What does the answer to "What is the meaning of life, the universe and everything" mean?](#q-what-does-the-answer-to-"what-is-the-meaning-of-life-the-universe-and-everything"-mean)


## Q: Is there support for multi-HART or multi-Core simulation?

A: There is no inherent support for multi-HART or multi-Core within the existing RISC-V Sail model. 
There are future plans for adding this kind of simulation.  It is needed in order to simulate 
(in a meaningful way) the atomic memory operations and to evaluate memory consistency
and coherency.

[comment]: <> ( The following is from email between Bill McSpadden and Martin Berger )
[comment]: <> ( Subject: RISC-V Sail model questions, round 1: Multi-core, MTIMER, MMIO, main loop)
[comment]: <> ( Date: Feb 15, 2022, 7:20AM)

The model isn't directly about testing. Testing is a separate
activity. The point of the model is to be as clear as possible. and we
should keep testing and the model separate.

## Q: What are .ml files?  What are their purpose?

A: These are OCaml files. They are to the ocaml emulator what the .c
files are to the c emulator. I question the need for an OCaml emulator
,see also https://github.com/riscv/sail-riscv/issues/138

## Q: 


[comment]: <> ( The following is some sample questions based on HGttG,Hitchhikers Guide to the Galax)

## Q: What is the meaning of life, the universe and everything?

A: 42

## Q: What does the answer to "What is the meaning of life, the universe and everything" mean?

A: One must construct an experimental, organic computer to compute the meaning.
Project 'Earth' is one such computer.  Timeframe for an expected answer is... soon.

