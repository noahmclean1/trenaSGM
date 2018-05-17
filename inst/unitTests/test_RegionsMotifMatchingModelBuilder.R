library(RUnit)
library(trenaSGM)
#------------------------------------------------------------------------------------------------------------------------
if(!exists("mtx"))
   load(system.file(package="trenaSGM", "extdata", "mayo.tcx.RData"))
#------------------------------------------------------------------------------------------------------------------------
runTests <- function()
{
   test_constructor()
   test_build.trem2.2200bp.motifDB.model()
   test_build.trem2.2200bp.TFClass.model()

} # runTests
#------------------------------------------------------------------------------------------------------------------------
test_constructor <- function()
{
   printf("--- test_constructor")

   genome <- "hg38"
   targetGene <- "TREM2"
   chromosome <- "chr6"
   tss <- 41163186
      # strand-aware start and end: trem2 is on the minus strand
   tbl.regions <- data.frame(chrom=chromosome, start=tss-200, end=tss+2000, stringsAsFactors=FALSE)

   build.spec <- list(title="trem2.rmm.2000up.200down",
                      type="regions.motifMatching",
                      tss=tss,
                      regions=tbl.regions,
                      matrix=mtx,
                      pfms=query2(MotifDb, "sapiens", "jaspar2018"),
                      motifDiscovery="matchPWM",
                      tfMapping="MotifDB",
                      tfPrefilterCorrelation=0.4,
                      orderByColumn="rfScore",
                      solverNames=c("lasso", "lassopv", "pearson", "randomForest", "ridge", "spearman"))

   builder <- RegionsMotifMatchingModelBuilder(genome, targetGene,  build.spec, quiet=TRUE)

   checkEquals("RegionsMotifMatchingModelBuilder" %in% is(builder))

} # test_constructor
#------------------------------------------------------------------------------------------------------------------------
test_build.trem2.2200bp.motifDB.model <- function()
{
   printf("--- test_build.trem2.2200bp.motifDb.model")

   genome <- "hg38"
   targetGene <- "TREM2"
   chromosome <- "chr6"
   tss <- 41163186
      # strand-aware start and end: trem2 is on the minus strand
   tbl.regions <- data.frame(chrom=chromosome, start=tss-200, end=tss+2000, stringsAsFactors=FALSE)

   build.spec <- list(title="trem2.rmm.2000up.200down",
                      type="regions.motifMatching",
                      tss=tss,
                      regions=tbl.regions,
                      matrix=mtx,
                      pfms=query2(MotifDb, "sapiens", "jaspar2018"),
                      matchThreshold=90,
                      motifDiscovery="matchPWM",
                      tfMapping="MotifDB",
                      tfPrefilterCorrelation=0.4,
                      orderByColumn="rfScore",
                      solverNames=c("lasso", "lassopv", "pearson", "randomForest", "ridge", "spearman"))


   builder <- RegionsMotifMatchingModelBuilder(genome, targetGene,  build.spec, quiet=TRUE)
   x <- build(builder)
   browser()
   checkEquals(names(x), c("model", "regulatoryRegions"))
   tbl.regRegions <- x$regulatoryRegions
   tbl.model <- x$model
   expected.tfs <- c("SPI1", "STAT3", "RUNX1", "NFATC2", "FLI1")
   checkEquals(tbl.model$gene, expected.tfs)
   checkTrue(all(expected.tfs %in% tbl.regRegions$geneSymbol))
   checkTrue(all(tbl.regRegions$chrom == chromosome))
   checkTrue(all(tbl.regRegions$fmotifStart >= min(tbl.regions$start)))
   checkTrue(all(tbl.regRegions$motifEnd <= max(tbl.regions$end)))

} # test_build.trem2.2200bp.motifDB.model
#------------------------------------------------------------------------------------------------------------------------
test_build.trem2.2200bp.TFClass.model <- function()
{
   printf("--- test_build.trem2.2200bp.TFClass.model")

   genome <- "hg38"
   targetGene <- "TREM2"
   chromosome <- "chr6"
   tss <- 41163186
      # strand-aware start and end: trem2 is on the minus strand
   tbl.regions <- data.frame(chrom=chromosome, start=tss-200, end=tss+2000, stringsAsFactors=FALSE)

   build.spec <- list(title="trem2.rmm.2000up.200down",
                      type="regions.motifMatching",
                      tss=tss,
                      regions=tbl.regions,
                      matrix=mtx,
                      pfms=query2(MotifDb, "sapiens", "jaspar2018"),
                      matchThreshold=90,
                      motifDiscovery="matchPWM",
                      tfMapping="TFClass",
                      tfPrefilterCorrelation=0.4,
                      orderByColumn="rfScore",
                      solverNames=c("lasso", "lassopv", "pearson", "randomForest", "ridge", "spearman"))


   builder <- RegionsMotifMatchingModelBuilder(genome, targetGene,  build.spec, quiet=TRUE)
   x <- build(builder)
   browser()
   checkEquals(names(x), c("model", "regulatoryRegions"))
   tbl.regRegions <- x$regulatoryRegions
   tbl.model <- x$model
   expected.tfs <- c("SPI1", "STAT3", "RUNX1", "NFATC2", "FLI1")
   checkEquals(tbl.model$gene, expected.tfs)
   checkTrue(all(expected.tfs %in% tbl.regRegions$geneSymbol))
   checkTrue(all(tbl.regRegions$chrom == chromosome))
   checkTrue(all(tbl.regRegions$fmotifStart >= min(tbl.regions$start)))
   checkTrue(all(tbl.regRegions$motifEnd <= max(tbl.regions$end)))

} # test_build.trem2.2200bp.motifDB.model
#------------------------------------------------------------------------------------------------------------------------