請將slow_memory.v、CHIP.v更換

此外，請在 RISCV_pipeline.v 中增加 output port "[31:0] PC"，連接到你的 pc counter

若要debug，請在 ./data_gen 中執行 python data_generate.py
可以修改 data_generate 中的 base, n

