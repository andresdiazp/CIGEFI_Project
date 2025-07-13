pro p04_correlacion

pc=fltarr(315)
openr,1,'pc.dat'
for i=0,314 do begin
 readf,1,pcinv
 pc(i)=pcinv
endfor
close,1

pc=(pc-mean(pc))/stdev(pc)

id=ncdf_open('T850mens.nc')
ncdf_varget,id,4,air
ncdf_close,id
;T=fltarr(144,28,12,63)
T=reform(air,144,28,12,63)
Tinv=fltarr(144,28,5,63)
Tinv(0:143,0:27,0:2,0:62)=T(0:143,0:27,0:2,0:62)
Tinv(0:143,0:27,3:4,0:62)=T(0:143,0:27,10:11,0:62)
Tinv=reform(Tinv,144*28,5*63)

r=fltarr(4032)   

dat=fltarr(315)  

for i=0,4031 do begin

 dat(0:314)=Tinv(i,0:314)

 res=c_correlate(pc,dat,0)

 r(i)=res

endfor 

openw,1,'corr_NAM-T.dat'
printf,1,r,format='(f0)'    ; escribimos en una sola columna
close,1
end
