pro p02_dibujo



eof1=fltarr(144,29)

openr,1,'eof.dat'

readf,1,eof1

close,1



datos=fltarr(145,29)

datos(0:143,0:28)=eof1

datos(144,0:28)=eof1(0,0:28)



lon=indgen(145)*2.5

lat=87.5-indgen(29)*2.5

;device,/install_colormap

;device,true_color=24

device,decomposed=0

loadct,39
ncolors=220

!p.background=255

window,xsize=800,ysize=800,retain=2

map_set,90,0,/stereo,limit=[20,0,90,360],/noborder

niv=[-1,-0.8,-0.6,-0.4,-0.2,0.2,0.4,0.6,0.8,1]

col=[30,45,60,85,255,190,200,210,220]

contour,datos,lon,lat,/cell_fill,levels=niv,c_colors=col,/overplot
colorbar = REPLICATE(1B,20) # BIndGen(256)
TV,BytScl(colorbar, Top=ncolors-1)
map_continents,color=0

mapa=tvrd(true=1)
write_jpeg,'eof.jpg',mapa,true=1

end
