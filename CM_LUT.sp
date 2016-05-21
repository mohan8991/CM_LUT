************************************************************************************
************************************************************************************
**                                                                                **
**                               CM_LUT.sp                                  **
**                                                                                **
************************************************************************************
************************************************************************************
************************************************************************************
** Author: Mohan Krishna Gopi Krishna
** Email: mohankrishna.gopikrishna@knights.ucf.edu
************************************************************************************
** This SPICE file demonstrates the operation of a Look Up Table (LUT)  with CNFET
************************************************************************************
***************************************************
***               Libraries                     ***
***************************************************
.lib './CNFET_lib/CNFET.lib' CNFET
.hdl './mtj_libs_encoded/needsmtj_1_0_0b.va'

.op
.option post

***************************************************
*For optimal accuracy, convergence, and runtime
***************************************************
.options POST
.options AUTOSTOP
.option INGOLD=2     *DCON=1												*INGOLD to represent the values in engineering format. DCON								
.options GSHUNT=1e-12 														*Adds conductance from each node to ground. TO resolve Timestep too small problem
.options RMIN=1e-15 														*sets a minimum timestep required, smaller than this value will report a internal timestep too small error
.options ABSTOL=1e-5  ABSVDC=1e-4 
.options RELTOL=1e-2  RELVDC=1e-2 
.options NUMDGT=4     PIVOT=13												*Does not affect the acuracy of the simulation, controls the printout acuracy. PIVOT used for faster simulation

.option post=1
.option probe=0
.option runlvl=6
.option ingold=2
.option accurate=1
.option method=bdf
.option bdfrtol=1e-8
.option bdfatol=1e-9
*.option numdgt=10
.option brief
.option measfile=1
.option lis_new=1
.option vaopts=str('-G')
.save

.param   TEMP=27
**********************************************************************
***                    Parameters/Definitions                      ***
**********************************************************************
*Some CNFET parameters:
.param Ccsd=0      CoupleRatio=0
.param m_cnt=1     Efo=0.6     
.param Wg=0        Cb=40e-12
.param Lg=32e-9    Lgef=100e-9
.param Vfn=0       Vfp=0
.param m=19        n=0        
.param Hox=4e-9    Kox=16 

*Some MTJ parameters
.param pi='4*atan(1)'
.param kB='1.3806503e-23'
.param Temperature='25'
.param Ms='700'
.param alpha='0.028'
.param W='25e-9'
.param L='pi*25e-9'
.param Tm='1.4e-9'
.param Ea='56*kB*(300)*1e7'
.param Volume='W*L*Tm*1e6'
.param Ka='(Ea/Volume)'
.param P_L='0.8'
.param P_R='0.3'
.param Lambda_L='2'
.param Lambda_R='2'

.param P='0.1*pi/180'
.param AP='179.9*pi/180'
.param PinL='0.0*pi/180'
**********************************************************************
***                     Initial Conditions                         ***
**********************************************************************

.ic V(th11) AP                        
.ic V(ph11) PinL
.ic V(th12) P
.ic V(ph12) PinL
.ic V(th13) AP					   
.ic V(ph13) PinL
.ic V(th14) P
.ic V(ph14) PinL
.ic V(th15) AP
.ic V(ph15) PinL
.ic V(th16) P						
.ic V(ph16) PinL
.ic V(th17) AP                        
.ic V(ph17) PinL
.ic V(th18) P
.ic V(ph18) PinL
.ic V(th19) AP					   
.ic V(ph19) PinL
.ic V(th110) P
.ic V(ph110) PinL
.ic V(th111) AP
.ic V(ph111) PinL
.ic V(th112) P						
.ic V(ph112) PinL
.ic V(th113) AP                        
.ic V(ph113) PinL
.ic V(th114) P
.ic V(ph114) PinL
.ic V(th115) AP					   
.ic V(ph115) PinL
.ic V(th116) P
.ic V(ph116) PinL

.ic V(th120) AP						*Reference
.ic V(ph120) PinL
.ic V(th117) P
.ic V(ph117) PinL
.ic V(th118) AP
.ic V(ph118) PinL
.ic V(th119) P
.ic V(ph119) PinL


***************************************************
*Supplies and voltage params:
.param vdd=1.2
.param vdd2='vdd/2'
.param tr=10p
.param tf=10p

vdd vdd 0 'vdd'
**********************************************************************
***                           Netlist                              ***
**********************************************************************
V_HAX hax 0 '0.0'
V_HAY hay 0 '0.0'
V_HAZ haz 0 '0.0'

Vclk clk 0 pulse (0 vdd 0.5ns 1ps 1ps 500ps 1ns)

Va A 0 pulse (0 vdd 1ns 1ps 1ps 5ns 10ns)
Vb B 0 pulse (0 vdd 1ns 1ps 1ps 5ns 10ns)
Vc C 0 pulse (0 vdd 1ns 1ps 1ps 5ns 10ns)
Vd D 0 pulse (0 vdd 1ns 1ps 1ps 5ns 10ns)

*Write Pulses
Vbl BL 0 vdd

Vw1 WL1 0 vdd
Vwl2 WL2 0 0
Vwl3 WL3 0 0
Vwl4 WL4 0 0
Vwl5 WL5 0 0
Vwl6 WL6 0 0
Vwl7 WL7 0 0
Vwl8 WL8 0 0
Vwl9 WL9 0 0
Vwl10 WL10 0 0
Vwl11 WL11 0 0
Vwl12 WL12 0 0
Vwl13 WL13 0 0
Vwl14 WL14 0 0
Vwl15 WL15 0 0
Vwl16 WL16 0 0

Vwe WE 0 vdd *pulse (vdd 0 5ns 1p 1p 5ns 10ns)

.SUBCKT INV_X1_CNFET A ZN VSS VDD 
*.PININFO A:I ZN:O VDD:P VSS:G 
*.EQN ZN=!A
XM_i_0 ZN A VSS VSS NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9 
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

XM_i_1 ZN A VDD VDD PCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9  
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5
.ENDS 

.SUBCKT TR_INV_CNFET WL IN OP VSS VDD 
XM_i_0 WLbar WL VSS VSS NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9 
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

XM_i_1 WLbar WL VDD VDD PCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9  
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

XM_i_2 OP WL IN VSS NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9 
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

XM_i_3 OP WLbar IN VDD PCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9  
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5
.ENDS 

Xinv1 A Abar 0 vdd INV_X1_CNFET 
Xinv2 B Bbar 0 vdd INV_X1_CNFET
Xinv3 C Cbar 0 vdd INV_X1_CNFET
Xinv4 D Dbar 0 vdd INV_X1_CNFET

*Write inverters
Xinv6 WE WEbar 0 vdd INV_X1_CNFET
Xinv7 BL BLbar 0 vdd INV_X1_CNFET

*NCNFET
XCNTn1 Qbar Q SL1 0 NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9 
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

XCNTn2 Q Qbar SLref 0 NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9 
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

XCNTn3 MTret1 clk 0 0 NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9 
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

XCNTnwr MTret WEbar MTret1 0 NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9 
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5


*PCNFET
XCNTp1 Qbar clk vdd vdd PCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9  
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

XCNTp2 Qbar Q vdd vdd PCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9  
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

XCNTp3 Q Qbar vdd vdd PCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9  
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

XCNTp4 Q clk vdd vdd PCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9  
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5


*Select Tree

XCNTn4 SL1 Abar SL2 0 NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9 
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

XCNTn5 SL1 A SL3 0 NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9 
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

XCNTn6 SL2 Bbar SL4 0 NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9 
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

XCNTn7 SL2 B SL5 0 NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9 
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

XCNTn8 SL3 Bbar SL6 0 NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9 
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

XCNTn9 SL3 B SL7 0 NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9 
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

XCNTn10 SL4 Cbar SL8 0 NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9 
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

XCNTn11 SL4 C SL9 0 NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9 
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

XCNTn12 SL5 Cbar SL10 0 NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9 
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

XCNTn13 SL5 C SL11 0 NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9 
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

XCNTn14 SL6 Cbar SL12 0 NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9 
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

XCNTn15 SL6 C SL13 0 NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9 
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

XCNTn16 SL7 Cbar SL14 0 NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9 
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

XCNTn17 SL7 C SL15 0 NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9 
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

XCNTn18 SL8 Dbar MT1 0 NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9 
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

XCNTn19 SL8 D MT2 0 NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9 
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

XCNTn20 SL9 Dbar MT3 0 NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9 
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

XCNTn21 SL9 D MT4 0 NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9 
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

XCNTn22 SL10 Dbar MT5 0 NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9 
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

XCNTn23 SL10 D MT6 0 NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9 
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

XCNTn24 SL11 Dbar MT7 0 NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9 
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

XCNTn25 SL11 D MT8 0 NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9 
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

XCNTn26 SL12 Dbar MT9 0 NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9 
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

XCNTn27 SL12 D MT10 0 NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9 
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

XCNTn28 SL13 Dbar MT11 0 NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9 
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

XCNTn29 SL13 D MT12 0 NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9 
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

XCNTn30 SL14 Dbar MT13 0 NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9 
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

XCNTn31 SL14 D MT14 0 NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9 
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

XCNTn32 SL15 Dbar MT15 0 NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9 
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

XCNTn33 SL15 D MT16 0 NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9 
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

*Reference Tree

XCNTn34 SLref vdd SLref1 0 NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9 
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

XCNTn35 SLref1 vdd SLref2 0 NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9 
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

XCNTn36 SLref2 vdd SLref3 0 NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9 
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

XCNTn37 SLref3 vdd MTref 0 NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9 
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=19  n2=0  tubes=5

*Write Circuit
Xwl1 WL1 BL MT1 0 vdd TR_INV_CNFET
Xwl2 WL2 BL MT2 0 vdd TR_INV_CNFET
Xwl3 WL3 BL MT3 0 vdd TR_INV_CNFET
Xwl4 WL4 BL MT4 0 vdd TR_INV_CNFET
Xwl5 WL5 BL MT5 0 vdd TR_INV_CNFET
Xwl6 WL6 BL MT6 0 vdd TR_INV_CNFET
Xwl7 WL7 BL MT7 0 vdd TR_INV_CNFET
Xwl8 WL8 BL MT8 0 vdd TR_INV_CNFET
Xwl9 WL9 BL MT9 0 vdd TR_INV_CNFET
Xwl10 WL10 BL MT10 0 vdd TR_INV_CNFET
Xwl11 WL11 BL MT11 0 vdd TR_INV_CNFET
Xwl12 WL12 BL MT12 0 vdd TR_INV_CNFET
Xwl13 WL13 BL MT13 0 vdd TR_INV_CNFET
Xwl14 WL14 BL MT14 0 vdd TR_INV_CNFET
Xwl15 WL15 BL MT15 0 vdd TR_INV_CNFET
Xwl16 WL16 BL MT16 0 vdd TR_INV_CNFET

Xwe WE BLbar MTret 0 vdd TR_INV_CNFET

XMTJ1 MT1 MTret hax hay haz th11 ph11 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'
+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

XMTJ2 MT2 MTret hax hay haz th12 ph12 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'			
+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

XMTJ3 MT3 MTret hax hay haz th13 ph13 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'				
+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

XMTJ4 MT4 MTret hax hay haz th14 ph14 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'				
+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

XMTJ5 MT5 MTret hax hay haz th15 ph15 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'				
+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

XMTJ6 MT6 MTret hax hay haz th16 ph16 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'				
+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

XMTJ7 MT7 MTret hax hay haz th17 ph17 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'				
+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

XMTJ8 MT8 MTret hax hay haz th18 ph18 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'				
+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

XMTJ9 MT9 MTret hax hay haz th19 ph19 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'				
+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

XMTJ10 MT10 MTret hax hay haz th110 ph110 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'				
+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

XMTJ11 MT11 MTret hax hay haz th111 ph111 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'				
+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

XMTJ12 MT12 MTret hax hay haz th112 ph112 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'				
+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

XMTJ13 MT13 MTret hax hay haz th113 ph113 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'				
+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

XMTJ14 MT14 MTret hax hay haz th114 ph114 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'				
+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

XMTJ15 MT15 MTret hax hay haz th115 ph115 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'				
+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

XMTJ16 MT16 MTret hax hay haz th116 ph116 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'				*Bit 16
+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

*Reference

XMTJ20 MTref MTref1 hax hay haz th120 ph120 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'				*Reference
+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

XMTJ17 MTref1 MTret hax hay haz th117 ph117 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'				*Reference
+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

XMTJ18 MTref MTref2 hax hay haz th118 ph118 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'				*Reference
+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'

XMTJ19 MTref2 MTret hax hay haz th119 ph119 PMAMTJ Ku2='K' W='W' P_L='P_L' P_R='P_R'				*Reference
+ L='L' Tm='Tm' Ms='Ms' Lambda=0 alpha='alpha' Lambda_L='Lambda_L'
+ Lambda_R='Lambda_R' LLG_Temp='0.0' thermScale='0.0'


**********************************************************************
***                           Analysis                             ***
**********************************************************************

.tran 1p 2.5n 

.option runlvl=6

.print tran v(MT1,MTret)

*.MEASURE TRAN pow AVG POWER FROM=0.5n TO=1.5n



.end