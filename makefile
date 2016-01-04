#
TARGET = scwpa

#
HWLIBS_ROOT = ${SOCEDS_DEST_ROOT}/ip/altera/hps/altera_hps/hwlib
ALT_DEVICE_FAMILY = soc_cv_av
CROSS_COMPILE = arm-linux-gnueabihf-
CFLAGS   += $(INCS:%=-I%) -I$(HWLIBS_ROOT)/include -I$(HWLIBS_ROOT)/include/$(ALT_DEVICE_FAMILY) -D$(ALT_DEVICE_FAMILY)
CPPFLAGS += $(INCS:%=-I%) -I$(HWLIBS_ROOT)/include -I$(HWLIBS_ROOT)/include/$(ALT_DEVICE_FAMILY) -D$(ALT_DEVICE_FAMILY)
LDFLAGS  += $(INCS:%=-I%)
LDFLAGS =  -g -Wall  
CC = $(CROSS_COMPILE)gcc
ARCH= arm

build: $(TARGET)
$(TARGET): main.o 
	$(CC) $(LDFLAGS)   $^ -o $@  
%.o : %.c
	$(CC) $(CFLAGS) -c $< -o $@

.PHONY: clean
clean:
	rm -f $(TARGET) *.a *.o *~