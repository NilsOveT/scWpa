#include <stdio.h>
#include <unistd.h>
#include <fcntl.h> 
#include <sys/mman.h> 
#include <stdint.h>
#include <string.h>
#include <time.h>
#include <math.h>
#include "hwlib.h" 
#include "soc_cv_av/socal/socal.h"
#include "soc_cv_av/socal/hps.h" 
#include "soc_cv_av/socal/alt_gpio.h"
#include "hps_0.h"


#define REG_BASE 0xFF200000
#define REG_SPAN 0x00200000
#define REG_MASK ( REG_SPAN - 1 )

void* virtual_base;
void* result_addr;
void* datahps_addr;
void* sndfpgacount_addr;
void* sndhpscount_addr;
int inpCount;
int endCount;
int i;
int j;
int count;
int st;
int fd;
char* str1;
uint32_t data[410000];
uint32_t output[164000];
uint32_t fasit[164000];
time_t start,end;
double dif;

int main (){
	if( ( fd = open( "/dev/mem", ( O_RDWR | O_SYNC ) ) ) == -1 ) {
		printf( "ERROR: could not open \"/dev/mem\"...\n" );
		return( 1 );
	}
	virtual_base=mmap(NULL,REG_SPAN,(PROT_READ|PROT_WRITE),MAP_SHARED,fd,REG_BASE);
	if( virtual_base == MAP_FAILED ) {
			printf( "ERROR: mmap() failed...\n" );
			close( fd );
			return( 1 );
		}
	
		
result_addr=virtual_base + ( ( unsigned long  )( RESULT_BASE ) & ( unsigned long)( REG_MASK ) );
datahps_addr=virtual_base + ( ( unsigned long  )( DATAHPS_BASE ) & ( unsigned long)( REG_MASK ) );
sndfpgacount_addr=virtual_base + ( ( unsigned long  )( SNDFPGA_BASE ) & ( unsigned long)( REG_MASK ) );
sndhpscount_addr=virtual_base + ( ( unsigned long  )( SNDHPS_BASE ) & ( unsigned long)( REG_MASK ) );

while(1){
	if(st == 1){
		if(22 == *(uint32_t *)sndfpgacount_addr){
			*(uint32_t *)datahps_addr = data[inpCount*20];
			*(uint32_t *)sndhpscount_addr = 0;
			count = 0;
			//printf("%d.%d: %x \n", inpCount, count, data[inpCount*20 + count]);
			
		}
		
		if(20 == *(uint32_t *)sndfpgacount_addr){
			*(uint32_t *)sndhpscount_addr = 21;
			st = 2;
		}
	
		if(count == *(uint32_t *)sndfpgacount_addr){
			
			if(count == 19){
				//st = 3;
				count = 0;
				//i = i + 1;
				inpCount = inpCount + 1;
				
				//*(uint32_t *)datahps_addr = data[inpCount*20];
				*(uint32_t *)sndhpscount_addr = 20;
				//printf("%d.%d: %x \n", inpCount, count, data[inpCount*20 + count]);
				
			}
			else{
				count = count + 1;
				*(uint32_t *)datahps_addr = data[inpCount*20 + count];
				*(uint32_t *)sndhpscount_addr = count;
				//printf("%d.%d: %x \n", inpCount, count, data[inpCount*20 + count]);
				//scanf("%s", &str1);
			}
		}
	}
		
	
	

	else if(st == 2){
		*(uint32_t *)sndhpscount_addr = count;
		if(count == *(uint32_t *)sndfpgacount_addr){
			output[endCount*8 + count] = *(uint32_t *)result_addr;
			//printf("%d.%d: %x \n", endCount, count, output[endCount*8 + count]);
			count = count + 1;
		}
		if(count >= 8){
			count = 25;
			endCount = endCount + 1;
			i = i + 1;
			*(uint32_t *)sndhpscount_addr = 22;
			st = 1;
			if (i == 2000){
				time (&end);
				i = 0;
				str1 = "True";
				for (i = 0; i < 20; i = i + 1){
					for (j = 0; j < 8; j = j + 1){
						if (output[i*8 + j] == fasit[i*10 + j]){}
						else{
							printf ("%d.%d: Output: %x, Fasit: %x \n", i, j, output[i*8 + j], fasit[i*10 + j]);
							str1 = "False \n";}
					}
				}
				printf(str1);
				dif = difftime (end,start);
				printf("Time: %g \n", dif);
				return(1);
			}
		}
	}
	
	
	
	else {
		FILE *data_input;
		data_input = fopen("jobunit.raw", "r");
		if (!data_input){
			return(1);
		}
		fread(data, 4, 410000,data_input);
		fclose(data_input);
		
		data_input = fopen("jobresult.raw", "r");
		if (!data_input){
			return(1);
		}
		fread(fasit, 4, 164000,data_input);
		fclose(data_input);
		
		for (i = 0; i < 410000; i = i + 1){
			if (count < 10){
				count = count +1;}
			else{
				data[i]=((((data[i]) << 8) & 0x00FF0000 ) | (((data[i]) >> 8) & 0x0000FF00 ) | (((data[i]) << 24) & 0xFF000000 ) | (((data[i]) >> 24) & 0x000000FF ));
				if (count < 19){count = count + 1;}
				else{count = 0;}
			}
		}
		
		for (i = 0; i < 164000; i = i + 1){
			
				fasit[i]=((((fasit[i]) << 8) & 0x00FF0000 ) | (((fasit[i]) >> 8) & 0x0000FF00 ) | (((fasit[i]) << 24) & 0xFF000000 ) | (((fasit[i]) >> 24) & 0x000000FF ));
				
		}
		
		time (&start);
		inpCount = 0;
		count = 25;
		st = 1;
		i = 0;
		*(uint32_t *)sndhpscount_addr = 22;
	}
}
return 0;




}