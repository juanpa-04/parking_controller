TARGET := test/dut_tb.v
TARGET_OUTPUT := bin/controller
HDL_DIR := hdl/
TEST_DIR := test/
SAVE_FILE := waveforms.gtkw
VCD := results.vcd

all: dut run graph

dut: $(TARGET)
	iverilog -o $(TARGET_OUTPUT) $(TARGET) -I$(HDL_DIR) -I$(TEST_DIR)

run: $(TARGET_OUTPUT)
	vvp $(TARGET_OUTPUT)

graph: 
	gtkwave bin/$(VCD) $(SAVE_FILE)

clean:
	rm -f $(TARGET_OUTPUT)
	rm -f bin/$(VCD)

