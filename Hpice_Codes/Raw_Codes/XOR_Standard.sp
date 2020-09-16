.option nomod
.include ./32nm_bulk.pm
.param Vdd=1
.subckt inverter 1 a b

.option post accurate nomod
.include ./32nm_bulk.pm

M1 b a 1 1 pmos l=32n w=66n *Ap

M2 b a 0 0 nmos l=32n w=33n *An

.ends

X_invertera 1 a ab inverter
X_inverterb 1 b bb inverter

M1 2 a  1 1 pmos l=32n w=132n 
M2 c bb 2 2 pmos l=32n w=132n  
M3 3 ab 1 1 pmos l=32n w=132n 
M4 c b  3 3 pmos l=32n w=132n  


M5 c a  4 4 nmos l=32n w=66n 
M6 4 b  0 0 nmos l=32n w=66n 
M7 c ab 5 5 nmos l=32n w=66n 
M8 5 bb 0 0 nmos l=32n w=66n 

.PRINT I(VDD)
.PRINT POWER
.measure tRise trig v(c) val='0.1' fall=1 targ v(c) val='0.9' rise=1
.measure tFall trig v(c) val='0.9' fall=1 targ v(c) val='0.1' rise=1
.measure tpHLa trig v(a) val='0.5' rise=1 targ v(c) val='0.5' fall=1
.measure tpLHa trig v(a) val='0.5' fall=1 targ v(c) val='0.5' rise=1

.measure	tpda PARAM=('(tpHLa+tpLHa)/2')

.measure tpHLb trig v(b) val='0.5' rise=1 targ v(c) val='0.5' fall=1
.measure tpLHb trig v(b) val='0.5' fall=1 targ v(c) val='0.5' rise=1

.measure	tpdb PARAM=('(tpHLb+tpLHb)/2')


vdd 1 0 dc 0.95V
vinb b 0 pulse(0.95 0 0 10p 10p 95p 200p)
vina a 0 pulse(0.95 0 50p 10p 10p 95p 200p)
.tran 200p 600p

.end


