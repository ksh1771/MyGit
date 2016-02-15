
H
Command: %s
53*	vivadotcl2 
place_design2default:defaultZ4-113
œ
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
	xc7vx485t2default:defaultZ17-347
Œ
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
	xc7vx485t2default:defaultZ17-349
g
,Running DRC as a precondition to command %s
22*	vivadotcl2 
place_design2default:defaultZ4-22
G
Running DRC with %s threads
24*drc2
22default:defaultZ23-27
M
DRC finished with %s
79*	vivadotcl2
0 Errors2default:defaultZ4-198
\
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199
L

Starting %s Task
103*constraints2
Placer2default:defaultZ18-103
t
BMultithreading enabled for place_design using a maximum of %s CPUs12*	placeflow2
22default:defaultZ30-611
m

Phase %s%s
101*constraints2
1 2default:default2)
Placer Initialization2default:defaultZ18-101
t

Phase %s%s
101*constraints2
1.1 2default:default2.
Placer Initialization Core2default:defaultZ18-101
‹
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0062default:default2
1226.4342default:default2
0.0002default:defaultZ17-268
x

Phase %s%s
101*constraints2
1.1.1 2default:default20
Mandatory Logic Optimization2default:defaultZ18-101
^
1Inserted %s IBUFs to IO ports without IO buffers.100*opt2
02default:defaultZ31-140
^
1Inserted %s OBUFs to IO ports without IO buffers.101*opt2
02default:defaultZ31-141
C
Pushed %s inverter(s).
98*opt2
02default:defaultZ31-138
‹
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0062default:default2
1226.4342default:default2
0.0002default:defaultZ17-268
K
?Phase 1.1.1 Mandatory Logic Optimization | Checksum: 1881217e9
*common
Š

%s
*constraints2s
_Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.188 . Memory (MB): peak = 1226.434 ; gain = 0.0002default:default
ƒ

Phase %s%s
101*constraints2
1.1.2 2default:default2;
'Build Super Logic Region (SLR) Database2default:defaultZ18-101
V
JPhase 1.1.2 Build Super Logic Region (SLR) Database | Checksum: 1881217e9
*common
Š

%s
*constraints2s
_Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.280 . Memory (MB): peak = 1226.434 ; gain = 0.0002default:default
k

Phase %s%s
101*constraints2
1.1.3 2default:default2#
Add Constraints2default:defaultZ18-101
>
2Phase 1.1.3 Add Constraints | Checksum: 1881217e9
*common
Š

%s
*constraints2s
_Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.281 . Memory (MB): peak = 1226.434 ; gain = 0.0002default:default
h

Phase %s%s
101*constraints2
1.1.4 2default:default2 
Build Macros2default:defaultZ18-101
;
/Phase 1.1.4 Build Macros | Checksum: 222411c81
*common
Š

%s
*constraints2s
_Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.763 . Memory (MB): peak = 1226.434 ; gain = 0.0002default:default
|

Phase %s%s
101*constraints2
1.1.5 2default:default24
 Implementation Feasibility check2default:defaultZ18-101
O
CPhase 1.1.5 Implementation Feasibility check | Checksum: 222411c81
*common
†

%s
*constraints2o
[Time (s): cpu = 00:00:01 ; elapsed = 00:00:01 . Memory (MB): peak = 1226.434 ; gain = 0.0002default:default
k

Phase %s%s
101*constraints2
1.1.6 2default:default2#
Pre-Place Cells2default:defaultZ18-101
>
2Phase 1.1.6 Pre-Place Cells | Checksum: 16ebfe382
*common
†

%s
*constraints2o
[Time (s): cpu = 00:00:01 ; elapsed = 00:00:01 . Memory (MB): peak = 1226.434 ; gain = 0.0002default:default
Ž

Phase %s%s
101*constraints2
1.1.7 2default:default2F
2IO Placement/ Clock Placement/ Build Placer Device2default:defaultZ18-101
¾
6Sub-optimal placement for a BUFG-BUFG cascade pair. %s120*place2ë
†This is normally an ERROR but the CLOCK_DEDICATED_ROUTE constraint is set to FALSE allowing your design to continue. The use of this override is highly discouraged as it may lead to very poor timing results. It is recommended that this error condition be corrected in the design.

	<MSGMETA::BEGIN::BLOCK>bufgmux_1<MSGMETA::END> (BUFGCTRL.O) is provisionally placed by clockplacer on BUFGCTRL_X0Y28
	<MSGMETA::BEGIN::BLOCK>bufgmux_2<MSGMETA::END> (BUFGCTRL.I1) is provisionally placed by clockplacer on BUFGCTRL_X0Y26
"ô
	bufgmux_12šThis is normally an ERROR but the CLOCK_DEDICATED_ROUTE constraint is set to FALSE allowing your design to continue. The use of this override is highly discouraged as it may lead to very poor timing results. It is recommended that this error condition be corrected in the design.

	:H (BUFGCTRL.O) is provisionally placed by clockplacer on BUFGCTRL_X0Y28
	"W
	bufgmux_2:H (BUFGCTRL.I1) is provisionally placed by clockplacer on BUFGCTRL_X0Y26
2default:default8Z30-120
¾
6Sub-optimal placement for a BUFG-BUFG cascade pair. %s120*place2ë
†This is normally an ERROR but the CLOCK_DEDICATED_ROUTE constraint is set to FALSE allowing your design to continue. The use of this override is highly discouraged as it may lead to very poor timing results. It is recommended that this error condition be corrected in the design.

	<MSGMETA::BEGIN::BLOCK>bufgmux_0<MSGMETA::END> (BUFGCTRL.O) is provisionally placed by clockplacer on BUFGCTRL_X0Y30
	<MSGMETA::BEGIN::BLOCK>bufgmux_2<MSGMETA::END> (BUFGCTRL.I0) is provisionally placed by clockplacer on BUFGCTRL_X0Y26
"ô
	bufgmux_02šThis is normally an ERROR but the CLOCK_DEDICATED_ROUTE constraint is set to FALSE allowing your design to continue. The use of this override is highly discouraged as it may lead to very poor timing results. It is recommended that this error condition be corrected in the design.

	:H (BUFGCTRL.O) is provisionally placed by clockplacer on BUFGCTRL_X0Y30
	"W
	bufgmux_2:H (BUFGCTRL.I0) is provisionally placed by clockplacer on BUFGCTRL_X0Y26
2default:default8Z30-120
a
UPhase 1.1.7 IO Placement/ Clock Placement/ Build Placer Device | Checksum: 18cc27496
*common
†

%s
*constraints2o
[Time (s): cpu = 00:00:06 ; elapsed = 00:00:04 . Memory (MB): peak = 1226.434 ; gain = 0.0002default:default
v

Phase %s%s
101*constraints2
1.1.8 2default:default2.
Build Placer Netlist Model2default:defaultZ18-101
o

Phase %s%s
101*constraints2
1.1.8.1 2default:default2%
Place Init Design2default:defaultZ18-101
p

Phase %s%s
101*constraints2

1.1.8.1.1 2default:default2$
Build Clock Data2default:defaultZ18-101
C
7Phase 1.1.8.1.1 Build Clock Data | Checksum: 1e6805571
*common
†

%s
*constraints2o
[Time (s): cpu = 00:00:40 ; elapsed = 00:00:24 . Memory (MB): peak = 1226.434 ; gain = 0.0002default:default
B
6Phase 1.1.8.1 Place Init Design | Checksum: 1e2007cb2
*common
†

%s
*constraints2o
[Time (s): cpu = 00:00:41 ; elapsed = 00:00:25 . Memory (MB): peak = 1226.434 ; gain = 0.0002default:default
I
=Phase 1.1.8 Build Placer Netlist Model | Checksum: 1e2007cb2
*common
†

%s
*constraints2o
[Time (s): cpu = 00:00:41 ; elapsed = 00:00:25 . Memory (MB): peak = 1226.434 ; gain = 0.0002default:default
s

Phase %s%s
101*constraints2
1.1.9 2default:default2+
Constrain Clocks/Macros2default:defaultZ18-101
~

Phase %s%s
101*constraints2
1.1.9.1 2default:default24
 Constrain Global/Regional Clocks2default:defaultZ18-101
Q
EPhase 1.1.9.1 Constrain Global/Regional Clocks | Checksum: 2372f6023
*common
†

%s
*constraints2o
[Time (s): cpu = 00:00:41 ; elapsed = 00:00:25 . Memory (MB): peak = 1226.434 ; gain = 0.0002default:default
F
:Phase 1.1.9 Constrain Clocks/Macros | Checksum: 2372f6023
*common
†

%s
*constraints2o
[Time (s): cpu = 00:00:41 ; elapsed = 00:00:25 . Memory (MB): peak = 1226.434 ; gain = 0.0002default:default
G
;Phase 1.1 Placer Initialization Core | Checksum: 2372f6023
*common
†

%s
*constraints2o
[Time (s): cpu = 00:00:41 ; elapsed = 00:00:25 . Memory (MB): peak = 1226.434 ; gain = 0.0002default:default
@
4Phase 1 Placer Initialization | Checksum: 2372f6023
*common
†

%s
*constraints2o
[Time (s): cpu = 00:00:41 ; elapsed = 00:00:25 . Memory (MB): peak = 1226.434 ; gain = 0.0002default:default
h

Phase %s%s
101*constraints2
2 2default:default2$
Global Placement2default:defaultZ18-101
;
/Phase 2 Global Placement | Checksum: 269fbb1e6
*common
†

%s
*constraints2o
[Time (s): cpu = 00:00:56 ; elapsed = 00:00:36 . Memory (MB): peak = 1226.434 ; gain = 0.0002default:default
h

Phase %s%s
101*constraints2
3 2default:default2$
Detail Placement2default:defaultZ18-101
t

Phase %s%s
101*constraints2
3.1 2default:default2.
Commit Multi Column Macros2default:defaultZ18-101
G
;Phase 3.1 Commit Multi Column Macros | Checksum: 269fbb1e6
*common
†

%s
*constraints2o
[Time (s): cpu = 00:00:57 ; elapsed = 00:00:37 . Memory (MB): peak = 1226.434 ; gain = 0.0002default:default
v

Phase %s%s
101*constraints2
3.2 2default:default20
Commit Most Macros & LUTRAMs2default:defaultZ18-101
I
=Phase 3.2 Commit Most Macros & LUTRAMs | Checksum: 2e653c98d
*common
†

%s
*constraints2o
[Time (s): cpu = 00:01:00 ; elapsed = 00:00:39 . Memory (MB): peak = 1226.434 ; gain = 0.0002default:default
p

Phase %s%s
101*constraints2
3.3 2default:default2*
Area Swap Optimization2default:defaultZ18-101
C
7Phase 3.3 Area Swap Optimization | Checksum: 2fd00af40
*common
†

%s
*constraints2o
[Time (s): cpu = 00:01:00 ; elapsed = 00:00:39 . Memory (MB): peak = 1226.434 ; gain = 0.0002default:default
o

Phase %s%s
101*constraints2
3.4 2default:default2)
Timing Path Optimizer2default:defaultZ18-101
B
6Phase 3.4 Timing Path Optimizer | Checksum: 2562e5f07
*common
†

%s
*constraints2o
[Time (s): cpu = 00:01:03 ; elapsed = 00:00:41 . Memory (MB): peak = 1226.434 ; gain = 0.0002default:default
z

Phase %s%s
101*constraints2
3.5 2default:default24
 Commit Small Macros & Core Logic2default:defaultZ18-101
M
APhase 3.5 Commit Small Macros & Core Logic | Checksum: 1e73cd218
*common
†

%s
*constraints2o
[Time (s): cpu = 00:01:05 ; elapsed = 00:00:43 . Memory (MB): peak = 1226.434 ; gain = 0.0002default:default
l

Phase %s%s
101*constraints2
3.6 2default:default2&
Re-assign LUT pins2default:defaultZ18-101
?
3Phase 3.6 Re-assign LUT pins | Checksum: 1e73cd218
*common
†

%s
*constraints2o
[Time (s): cpu = 00:01:05 ; elapsed = 00:00:43 . Memory (MB): peak = 1226.434 ; gain = 0.0002default:default
;
/Phase 3 Detail Placement | Checksum: 1e73cd218
*common
†

%s
*constraints2o
[Time (s): cpu = 00:01:05 ; elapsed = 00:00:43 . Memory (MB): peak = 1226.434 ; gain = 0.0002default:default
€

Phase %s%s
101*constraints2
4 2default:default2<
(Post Placement Optimization and Clean-Up2default:defaultZ18-101
m

Phase %s%s
101*constraints2
4.1 2default:default2'
PCOPT Shape updates2default:defaultZ18-101
@
4Phase 4.1 PCOPT Shape updates | Checksum: 15c5221fa
*common
†

%s
*constraints2o
[Time (s): cpu = 00:01:05 ; elapsed = 00:00:43 . Memory (MB): peak = 1226.434 ; gain = 0.0002default:default
u

Phase %s%s
101*constraints2
4.2 2default:default2/
Post Placement Optimization2default:defaultZ18-101
~

Phase %s%s
101*constraints2
4.2.1 2default:default26
"Post Placement Timing Optimization2default:defaultZ18-101
t

Phase %s%s
101*constraints2
4.2.1.1 2default:default2*
Restore Best Placement2default:defaultZ18-101
G
;Phase 4.2.1.1 Restore Best Placement | Checksum: 24bba2d6e
*common
†

%s
*constraints2o
[Time (s): cpu = 00:02:31 ; elapsed = 00:02:09 . Memory (MB): peak = 1226.434 ; gain = 0.0002default:default
Q
EPhase 4.2.1 Post Placement Timing Optimization | Checksum: 24bba2d6e
*common
†

%s
*constraints2o
[Time (s): cpu = 00:02:31 ; elapsed = 00:02:09 . Memory (MB): peak = 1226.434 ; gain = 0.0002default:default
H
<Phase 4.2 Post Placement Optimization | Checksum: 24bba2d6e
*common
†

%s
*constraints2o
[Time (s): cpu = 00:02:31 ; elapsed = 00:02:09 . Memory (MB): peak = 1226.434 ; gain = 0.0002default:default
p

Phase %s%s
101*constraints2
4.3 2default:default2*
Post Placement Cleanup2default:defaultZ18-101
C
7Phase 4.3 Post Placement Cleanup | Checksum: 24bba2d6e
*common
†

%s
*constraints2o
[Time (s): cpu = 00:02:31 ; elapsed = 00:02:09 . Memory (MB): peak = 1226.434 ; gain = 0.0002default:default
j

Phase %s%s
101*constraints2
4.4 2default:default2$
Placer Reporting2default:defaultZ18-101
p

Phase %s%s
101*constraints2
4.4.1 2default:default2(
Congestion Reporting2default:defaultZ18-101
C
7Phase 4.4.1 Congestion Reporting | Checksum: 24bba2d6e
*common
†

%s
*constraints2o
[Time (s): cpu = 00:02:31 ; elapsed = 00:02:09 . Memory (MB): peak = 1226.434 ; gain = 0.0002default:default
p

Phase %s%s
101*constraints2
4.4.2 2default:default2(
Dump Critical Paths 2default:defaultZ18-101
C
7Phase 4.4.2 Dump Critical Paths  | Checksum: 24bba2d6e
*common
†

%s
*constraints2o
[Time (s): cpu = 00:02:32 ; elapsed = 00:02:09 . Memory (MB): peak = 1226.434 ; gain = 0.0002default:default
g

Phase %s%s
101*constraints2
4.4.3 2default:default2
Restore STA2default:defaultZ18-101
:
.Phase 4.4.3 Restore STA | Checksum: 24bba2d6e
*common
†

%s
*constraints2o
[Time (s): cpu = 00:02:32 ; elapsed = 00:02:10 . Memory (MB): peak = 1226.434 ; gain = 0.0002default:default
k

Phase %s%s
101*constraints2
4.4.4 2default:default2#
Print Final WNS2default:defaultZ18-101
o
!Post Placement Timing Summary %s
2*	placeflow22
| WNS=-4.001 | TNS=-6923.589|
2default:defaultZ30-100
>
2Phase 4.4.4 Print Final WNS | Checksum: 24bba2d6e
*common
†

%s
*constraints2o
[Time (s): cpu = 00:02:40 ; elapsed = 00:02:14 . Memory (MB): peak = 1226.434 ; gain = 0.0002default:default
=
1Phase 4.4 Placer Reporting | Checksum: 2a7b898fa
*common
†

%s
*constraints2o
[Time (s): cpu = 00:02:40 ; elapsed = 00:02:14 . Memory (MB): peak = 1226.434 ; gain = 0.0002default:default
q

Phase %s%s
101*constraints2
4.5 2default:default2+
Final Placement Cleanup2default:defaultZ18-101
D
8Phase 4.5 Final Placement Cleanup | Checksum: 3591411b2
*common
†

%s
*constraints2o
[Time (s): cpu = 00:02:40 ; elapsed = 00:02:14 . Memory (MB): peak = 1226.434 ; gain = 0.0002default:default
S
GPhase 4 Post Placement Optimization and Clean-Up | Checksum: 3591411b2
*common
†

%s
*constraints2o
[Time (s): cpu = 00:02:40 ; elapsed = 00:02:14 . Memory (MB): peak = 1226.434 ; gain = 0.0002default:default
5
)Ending Placer Task | Checksum: 2a60fb44d
*common
†

%s
*constraints2o
[Time (s): cpu = 00:00:00 ; elapsed = 00:02:14 . Memory (MB): peak = 1226.434 ; gain = 0.0002default:default
Q
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83
½
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
392default:default2
32default:default2
02default:default2
02default:defaultZ4-41
U
%s completed successfully
29*	vivadotcl2 
place_design2default:defaultZ4-42
û
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
place_design: 2default:default2
00:02:402default:default2
00:02:172default:default2
1226.4342default:default2
0.0002default:defaultZ17-268
^

DEBUG : %s144*timing29
%Generate clock report | CPU: 1 secs 
2default:defaultZ38-163
€
treport_utilization: Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.151 . Memory (MB): peak = 1226.434 ; gain = 0.000
*common
j

DEBUG : %s134*designutils2@
,Generate Control Sets report | CPU: 0 secs 
2default:defaultZ20-134
4
Writing XDEF routing.
211*designutilsZ20-211
A
#Writing XDEF routing logical nets.
209*designutilsZ20-209
A
#Writing XDEF routing special nets.
210*designutilsZ20-210
†
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2)
Write XDEF Complete: 2default:default2
00:00:012default:default2 
00:00:00.6512default:default2
1226.4342default:default2
0.0002default:defaultZ17-268


End Record