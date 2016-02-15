
#ifndef TDC_CALIB_CAPTURE_LITE_H
#define TDC_CALIB_CAPTURE_LITE_H


/****************** Include Files ********************/
#include "xil_types.h"
#include "xstatus.h"

#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG0_OFFSET 0
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG1_OFFSET 4
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG2_OFFSET 8
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG3_OFFSET 12
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG4_OFFSET 16
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG5_OFFSET 20
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG6_OFFSET 24
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG7_OFFSET 28
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG8_OFFSET 32
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG9_OFFSET 36
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG10_OFFSET 40
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG11_OFFSET 44
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG12_OFFSET 48
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG13_OFFSET 52
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG14_OFFSET 56
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG15_OFFSET 60
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG16_OFFSET 64
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG17_OFFSET 68
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG18_OFFSET 72
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG19_OFFSET 76
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG20_OFFSET 80
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG21_OFFSET 84
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG22_OFFSET 88
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG23_OFFSET 92
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG24_OFFSET 96
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG25_OFFSET 100
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG26_OFFSET 104
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG27_OFFSET 108
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG28_OFFSET 112
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG29_OFFSET 116
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG30_OFFSET 120
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG31_OFFSET 124
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG32_OFFSET 128
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG33_OFFSET 132
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG34_OFFSET 136
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG35_OFFSET 140
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG36_OFFSET 144
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG37_OFFSET 148
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG38_OFFSET 152
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG39_OFFSET 156
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG40_OFFSET 160
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG41_OFFSET 164
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG42_OFFSET 168
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG43_OFFSET 172
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG44_OFFSET 176
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG45_OFFSET 180
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG46_OFFSET 184
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG47_OFFSET 188
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG48_OFFSET 192
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG49_OFFSET 196
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG50_OFFSET 200
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG51_OFFSET 204
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG52_OFFSET 208
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG53_OFFSET 212
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG54_OFFSET 216
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG55_OFFSET 220
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG56_OFFSET 224
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG57_OFFSET 228
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG58_OFFSET 232
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG59_OFFSET 236
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG60_OFFSET 240
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG61_OFFSET 244
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG62_OFFSET 248
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG63_OFFSET 252
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG64_OFFSET 256
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG65_OFFSET 260
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG66_OFFSET 264
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG67_OFFSET 268
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG68_OFFSET 272
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG69_OFFSET 276
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG70_OFFSET 280
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG71_OFFSET 284
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG72_OFFSET 288
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG73_OFFSET 292
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG74_OFFSET 296
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG75_OFFSET 300
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG76_OFFSET 304
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG77_OFFSET 308
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG78_OFFSET 312
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG79_OFFSET 316
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG80_OFFSET 320
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG81_OFFSET 324
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG82_OFFSET 328
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG83_OFFSET 332
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG84_OFFSET 336
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG85_OFFSET 340
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG86_OFFSET 344
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG87_OFFSET 348
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG88_OFFSET 352
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG89_OFFSET 356
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG90_OFFSET 360
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG91_OFFSET 364
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG92_OFFSET 368
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG93_OFFSET 372
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG94_OFFSET 376
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG95_OFFSET 380
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG96_OFFSET 384
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG97_OFFSET 388
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG98_OFFSET 392
#define TDC_CALIB_CAPTURE_LITE_S00_AXI_SLV_REG99_OFFSET 396


/**************************** Type Definitions *****************************/
/**
 *
 * Write a value to a TDC_CALIB_CAPTURE_LITE register. A 32 bit write is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is written.
 *
 * @param   BaseAddress is the base address of the TDC_CALIB_CAPTURE_LITEdevice.
 * @param   RegOffset is the register offset from the base to write to.
 * @param   Data is the data written to the register.
 *
 * @return  None.
 *
 * @note
 * C-style signature:
 * 	void TDC_CALIB_CAPTURE_LITE_mWriteReg(u32 BaseAddress, unsigned RegOffset, u32 Data)
 *
 */
#define TDC_CALIB_CAPTURE_LITE_mWriteReg(BaseAddress, RegOffset, Data) \
  	Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))

/**
 *
 * Read a value from a TDC_CALIB_CAPTURE_LITE register. A 32 bit read is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is read from the register. The most significant data
 * will be read as 0.
 *
 * @param   BaseAddress is the base address of the TDC_CALIB_CAPTURE_LITE device.
 * @param   RegOffset is the register offset from the base to write to.
 *
 * @return  Data is the data from the register.
 *
 * @note
 * C-style signature:
 * 	u32 TDC_CALIB_CAPTURE_LITE_mReadReg(u32 BaseAddress, unsigned RegOffset)
 *
 */
#define TDC_CALIB_CAPTURE_LITE_mReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))

/************************** Function Prototypes ****************************/
/**
 *
 * Run a self-test on the driver/device. Note this may be a destructive test if
 * resets of the device are performed.
 *
 * If the hardware system is not built correctly, this function may never
 * return to the caller.
 *
 * @param   baseaddr_p is the base address of the TDC_CALIB_CAPTURE_LITE instance to be worked on.
 *
 * @return
 *
 *    - XST_SUCCESS   if all self-test code passed
 *    - XST_FAILURE   if any self-test code failed
 *
 * @note    Caching must be turned off for this function to work.
 * @note    Self test may fail if data memory and device are not on the same bus.
 *
 */
XStatus TDC_CALIB_CAPTURE_LITE_Reg_SelfTest(void * baseaddr_p);

#endif // TDC_CALIB_CAPTURE_LITE_H
