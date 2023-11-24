import serial

serial_data = serial.Serial("COM9",11520)	#change COM6 (Check in which COM port your FPGA is connected) and baud rate
dat = serial_data.read(8)				#It will read 1 byte of data from FPGA
print(dat.hex())						#It will print received data in HEX

serial_data.close()					    #Close USB UART