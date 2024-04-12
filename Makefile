TARGET := dut.v
TARGET_OUTPUT := controller

all: dut run

dut: $(TARGET)
	iverilog -o $(TARGET_OUTPUT) $(TARGET)

run: 
	vvp $(TARGET_OUTPUT)

clean:
	rm -f $(TARGET_OUTPUT)

