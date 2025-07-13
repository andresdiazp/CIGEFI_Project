pro p03_altabaja

f10=fltarr(5,67)
openr,1,'f10mens.dat'
cabecera=strarr(6)
readf,1,cabecera
efm=fltarr(3)
amjjaso=fltarr(7)
nd=fltarr(2)
for i=0,66 do begin
 readf,1,anho,efm,amjjaso,nd
 f10(0:2,i)=efm
 f10(3:4,i)=nd
endfor
close,1 

f10=reform(f10,5*67) 

f10=(f10-mean(f10))/stdev(f10) 

alta=where(f10 ge 1) 

baja=where(f10 le -1)

;openw,1,'baja.dat'
;printf,1,baja
;close,1

ncid=ncdf_open('NAMZ850means.nc')

varid1=ncdf_varid(ncid,'lon')
varid2=ncdf_varid(ncid,'lat')
varid3=ncdf_varid(ncid,'level')
varid4=ncdf_varid(ncid,'time')
varid5=ncdf_varid(ncid,'hgt')
ncdf_varget,ncid,varid1,lon
ncdf_varget,ncid,varid2,lat
ncdf_varget,ncid,varid3,lev
ncdf_varget,ncid,varid4,time
ncdf_varget,ncid,varid5,hgt
ncdf_close,ncid

;id=ncdf_open('Z850mens.nc')
;ncdf_varget,id,4,hgt
;ncdf_close,id

Z=fltarr(144,29,12,67)
Z=reform(hgt,144,29,12,67)
Zinv=fltarr(144,29,5,67)
Zinv(0:143,0:28,0:2,0:66)=Z(0:143,0:28,0:2,0:66)
Zinv(0:143,0:28,3:4,0:66)=Z(0:143,0:28,10:11,0:66)
Zinv=reform(Zinv,144*29,5*67)

Zalta=Zinv(0:4175,alta) 

;print,Zalta

;Zbaja=Zinv(0:4175,baja) 

;openw,1,'Zbaja.dat'
;printf,1,Zbaja
;close,1

pcalta=pcomp(Zalta,/double,nvariables=1,coefficients=eofalta,variances=varalta,/covariance)
openw,1,'pcalta.dat'
printf,1,pcalta,format='(f0)'    ; escribimos en una sola columna
close,1
openw,1,'varalta.dat'
printf,1,varalta,format='(f0)'
close,1
openw,1,'eofalta.dat'
printf,1,eofalta
close,1

;pcbaja=pcomp(Zbaja,/double,nvariables=1,coefficients=eofbaja,variances=varbaja)
;openw,1,'pcbaja.dat'
;printf,1,pcbaja,format='(f0)'    ; escribimos en una sola columna
;close,1
;openw,1,'varbaja.dat'
;printf,1,varbaja,format='(f0)'
;close,1
;openw,1,'eofbaja.dat'
;printf,1,eofbaja
;close,1

end

