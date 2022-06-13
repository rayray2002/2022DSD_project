分工：
    黃柏睿： 幾乎全部（無奈呀，一個禮拜沒睡覺了）
    徐明晧： ALU control signal設計

How to run:
    RTL:
        ncverilog Final_tb.v CHIP.v slow_memory.v +access+r +define+${test_mode}

    Gate level:
        ncverilog Final_tb.v CHIP_syn.v slow_memory.v tsmc13.v +access+r +define+${test_mode} +define
        There sometimes are some Timing violation Warning at start no matter the cycle time setting, it doesn't effect thr result.

    Baseline:
        test_mode="noHazard"
        test_mode="hasHazard"

    BrPred:
        test_mode="BrPred"

    L2Cache:
        test_mode="L2Cache"

    compression:
        test_mode="compression"
        test_mode="decompression"

    Final:
        test_mode="DECOMPRESS"
        test_mode="COMPRESS"