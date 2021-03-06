% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/trenaSGM.R
\docType{methods}
\name{summarizeModels,trenaSGM-method}
\alias{summarizeModels,trenaSGM-method}
\alias{summarizeModels}
\title{summarize the gene regulatory models preciously calculated by this trensSGM instance}
\usage{
\S4method{summarizeModels}{trenaSGM}(obj, orderBy, maxTFpredictors,
  models = list())
}
\arguments{
\item{obj}{An object of class trenaSGM}

\item{orderBy}{a characters string, the name of the column in the standard trena model data.frame, typically pcaMax, rfScore, pearsonCoeff}

\item{maxTFpredictors}{an integer, the number of tfs to extract from each model (when present)}

\item{models}{a list of lists of model + regulatoryRegion data.fames, default NA, in which case the list is found in object state data}
}
\value{
A data.frame summarizing tfs by model type, by count (the number of models in which it appears) and rank in each model
}
\description{
summarize the gene regulatory models preciously calculated by this trensSGM instance
}
\examples{
if(interactive()){
  load(system.file(package="trenaSGM", "extdata", "mayo.tcx.RData"))
  genome <- "hg38"
  targetGene <- "TREM2"
  sgm <- trenaSGM(genome, targetGene)
  chromosome <- "chr6"
  upstream <- 2000
  downstream <- 200
  tss <- 41163186

     # strand-aware start and end: trem2 is on the minus strand
  start <- tss - downstream
  end   <- tss + upstream

  build.spec <- list(title="fp.2000up.200down.04",
                     type="footprint.database",
                     chrom=chromosome,
                     start=start,
                     end=end,
                     tss=tss,
                     matrix=mtx,
                     db.host="khaleesi.systemsbiology.net",
                     databases=list("brain_hint_20"),
                     motifDiscovery="builtinFimo",
                     tfMapping="MotifDB",
                     tfPrefilterCorrelation=0.4,
                     solverNames=c("lasso", "lassopv", "pearson", "randomForest", "ridge", "spearman"))


  build.spec.2 <- build.spec
  build.spec.2$title <- "fp.2000up.200down.02"
  build.spec.2$tfPrefilterCorrelation=0.2

  strategies <- list(one=build.spec, two=build.spec.2)
  models <- calculate(sgm)
  tbl.summary <- summarizeModels(sgm, orderBy="rfScore", maxTFpredictors=5)
  }

}
