% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dmri.tracking.R
\name{v.track}
\alias{v.track}
\title{Deterministic tracking algorithm -- DiST}
\usage{
v.track(
  v.obj,
  max.line = 100,
  nproj = 1,
  elim = T,
  elim.thres = 1,
  thres.ang = 0.5235988
)
}
\arguments{
\item{v.obj}{An list type object which contains the following components:
\itemize{
 \item{vec:} A matrix containing the estimated peak directions.
 \item{loc:} A matrix containing the 'braingrid' coordinates of the corresponding estimated peak direction.
 \item{map:} A vector containing the voxel indicator of corresponding estimated peak direction.
 \item{rmap:} A vector specifying the location in 'map' of each voxel.
 \item{n.fiber:} A vector specifying the number of peaks at each voxel.
 \item{n.fiber2:} A vector specifying the number of peaks corresponding to 'map'.
 \item{braingrid:} A array specifying the normalized voxel coordinates.
 \item{xgrid.sp,ygrid.sp,zgrid.sp: } A numeric value specifying the voxel size (mm) in x, y, z-axis, respectively. (e.g. Voxel size in HCP dMRI: 1.25mm * 1.25mm * 1.25mm)
 \item Example can be found in main page of \href{https://github.com/vic-dragon/dmri.tracking}{github-repository}
}}

\item{max.line}{A integer value specifying the maximum number of voxels that the reconstructed fibers can go through. The value can depend on the size of ROI.}

\item{nproj}{A integer value specifying the number of neighborhood voxels if the algorithm cannot find any viable direction nearby.}

\item{elim}{logical. If TRUE, 'sorted.update.ind' returns whether the reconstructed fiber is greater than 'elim.thres'}

\item{elim.thres}{A numeric value specifying the lower limit length of reconstructed fibers.}

\item{thres.ang}{A numeric value specifying the threshold to determine whether the destination voxel have a viable direction (default value: pi/6). i.e.,
the algorithm will be proceeded, if the angular difference of the diffusion direction between the previous voxel and the destination voxel is smaller than 'thres.ang'.}
}
\value{
Result of deterministic tracking algorithm
\itemize{
 \item{v.obj:} Input of \code{\link{v.track}}
 \item{track1, track2:} A list containing the reconstructed fiber information
 \itemize{
  \item{inloc:} The voxel coordinates that the reconstructed fiber went through
  \item{dir:} The diffusion direction that used to reconstruct fiber
  \item{iinds:} The indicator of voxel that the reconstructed fiber went through
  \item{change:} logical, If TRUE, that voxel pass the angular difference threshold (thres.ang)
  \item{pvox:} The passed voxel
  \item{pdir:} The passed direction
  \item{pdis:} The length of fiber between the passed information and the previous one.
  \item{ppdis:} The distance of the voxel between the passed one and the previous one.
 }
 \item{n.iinds:} Number of voxels the reconstructed fiber went through
 \item{n.use.iind:} Number of times that each estimated direction is used.
 \item{lens:} The reconstructed fiber lengths.
 \item{sorted.iinds:} The ordered reconstructed fibers
 \item{sorted.update.ind:} Whether the reconstructed fiber is greater than elim.thres
}
}
\description{
v.track is used to apply the deterministic tracking algorithm -- DiST (Wong et al 2017)
It can be used to carry out the neuronal fiber reconstruction based on the peak detection results with local fiber estimation.
Peak detection algorithm can be found in example_HCP_analysis.py from \href{https://github.com/vic-dragon/BJS/tree/master/example_scripts/}{github-repository}
}
\examples{
#Load an example output from the peak detection algorithm
load(system.file("extdata", "peakresult.rda", package = "dmri.tracking"))

str(peak.result)  #Output from the peak detection algorithm

#Apply Tracking algorithm
result = v.track(v.obj = peak.result, max.line=500)


#Plot tracking result.
\donttest{
library(rgl)
open3d()
for (iind in (result$sorted.iinds[result$sorted.update.ind])){
  cat(iind,"\n")
  tractography(result$tracks1[[iind]]$inloc, result$tracks1[[iind]]$dir)
  tractography(result$tracks2[[iind]]$inloc, result$tracks2[[iind]]$dir)
}
}
#An example to prepare v.obj is available in https://github.com/vic-dragon/dmri.tracking

}
\references{
R. K. W. Wong, T. C. M. Lee, D. Paul, J. Peng and for the Alzheimer's Disease Neuroimaging Initiative. (2016)
"Fiber Direction Estimation, Smoothing and Tracking in Diffusion MRI". The Annals of Applied Statistics, 10(3), 1137-1156.
}
\seealso{
\code{\link{tractography}} for plotting tractography based on the tracking result from \code{\link{v.track}} in \code{\link{dmri.tracking}} package.
}
\author{
Raymond Wong, Seungyong Hwang (Maintainer: \email{syhwang@ucdavis.edu})
}
