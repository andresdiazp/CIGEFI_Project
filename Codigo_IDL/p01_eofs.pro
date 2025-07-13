pro p01_eofs

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

;id=ncdf_open('NAMZ850means.nc')
;ncdf_varget,id,4,hgt
;ncdf_close,id

help,hgt

Z=fltarr(144,29,12,67)
Z=reform(hgt,144,29,12,67)
Zinv=fltarr(144,29,5,67)
Zinv(0:143,0:28,0:2,0:66)=Z(0:143,0:28,0:2,0:66)
Zinv(0:143,0:28,3:4,0:66)=Z(0:143,0:28,10:11,0:66)
Zinv=reform(Zinv,144*29,5*67)
help,Zinv
pc=pcomp(Zinv,/double,nvariables=1,coefficients=eof,variances=var)
openw,1,'pc.dat'
printf,1,pc,format='(f0)'    ; escribimos en una sola columna
close,1
openw,1,'var.dat'
printf,1,var,format='(f0)'
close,1
openw,1,'eof.dat'
printf,1,eof
close,1
end

