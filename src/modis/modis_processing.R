library(rgdal)
library(gdalUtils)
library(raster)
in.dir = "./output/MODIS/MOD13A1.006/"
in.hdf.files= list.files(in.dir,pattern = "*.hdf$",recursive = T,full.names = T)

out.dir = "./output/"
in.shp = readOGR("./data/indiashp-master/states/KA_state.shp")

scale.factor = 0.0001
for (ii in in.hdf.files) {
  in.file = get_subdatasets(ii)
  for(jj in in.file){
    b.len = length(unlist(strsplit(basename(jj)," ")))
    b.name = unlist(strsplit(basename(jj)," "))[b.len]
    if(b.name == "NDVI"){
      in.ras = raster(jj)
      out.name = substr(names(in.ras),9,41)
      out.file = sprintf("%s%s/%s.tif",out.dir,b.name,out.name)
      if(!file.exists(out.file)){
        s.ras= in.ras*scale.factor^2
        out.ras = projectRaster(s.ras,crs='+proj=longlat +datum=WGS84')
        cr.ras = crop(out.ras,in.shp,snap = "out")
        ms.ras = mask(cr.ras,in.shp)
        writeRaster(ms.ras,out.file)
      }
    }else if(b.name == "EVI"){
      in.ras = raster(jj)
      out.name = substr(names(in.ras),9,41)
      out.file = sprintf("%s%s/%s.tif",out.dir,b.name,out.name)
      if(!file.exists(out.file)){
        s.ras= in.ras*scale.factor^2
        out.ras = projectRaster(s.ras,crs='+proj=longlat +datum=WGS84')
        cr.ras = crop(out.ras,in.shp,snap = "out")
        ms.ras = mask(cr.ras,in.shp)
        writeRaster(ms.ras,out.file)
      }
    }else if(b.name == "reliability"){
      in.ras = raster(jj)
      out.name = substr(names(in.ras),9,41)
      band = "QA"
      out.file = sprintf("%s%s/%s.tif",out.dir,band,out.name)
      if(!file.exists(out.file)){
        s.ras= in.ras
        out.ras = projectRaster(s.ras,crs='+proj=longlat +datum=WGS84')
        cr.ras = crop(out.ras,in.shp,snap = "out")
        ms.ras = mask(cr.ras,in.shp)
        writeRaster(ms.ras,out.file)
      }
    }
  }
  print(substr(basename(ii),10,16))
}

