% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/trenaSGM.R
\docType{methods}
\name{calculate,trenaSGM-method}
\alias{calculate,trenaSGM-method}
\alias{calculate}
\title{create regulatory model of the gene, following all the specified options}
\usage{
\S4method{calculate}{trenaSGM}(obj, strategies)
}
\arguments{
\item{obj}{An object of class trenaSGM}

\item{strategies}{a list of lists, specifying all the options to build one or more models}
}
\value{
A list with a bunch of tables...
}
\description{
create regulatory model of the gene, following all the specified options
}
\examples{
if(interactive()){
  pfms <- query2(MotifDb, c("sapiens", "jaspar2018"))
  load(system.file(package="trenaSGM", "extdata", "mayo.tcx.RData"))
  sgm <- trenaSGM("hg38", "TREM2", mtx, pfms,
                  strategies=list(footprints="5000.5000.remapped"),
                  tfCorrelation=0.3)
  calculate(sgm)
  }

}
