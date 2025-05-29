# heliometric-stereo-data-pack

Data pack for publication "Heliometric stereo: a new frontier in surface profilometry". An [arXiv preprint is available](https://doi.org/10.48550/arXiv.2501.14833). The doi link to the final publication will be added once available.

The data packs at [doi.org/10.17863/CAM.107537](http://doi.org/10.17863/CAM.107537) and [doi.org/10.17863/CAM.114465](https://doi.org/10.17863/CAM.114465) also support the publication, some, but not all, of the data is reproduced here.

There are three supporting scripts here, two aid in the creation of figures 10 and 11, the third performs the calculation for the speed up of the multi-detector system over the single detector system. 

Experimental datafiles are in `datafiles`, the two ray tracing simulations are under `simulation_results`, which contains both raw data and the reconstructed surfaces. Experimental data is here provided in the form of raw `.mat` files, these are most easily accessed though MATLAB, but other tools exist, e.g. though the (`scipy` python packages)[https://docs.scipy.org/doc/scipy/reference/generated/scipy.io.loadmat.html]. `scan0...mat` files are A-SHeM files, `sc1...mat` files are B-SHeM files, a `.mat` files are provided for the B-SHeM reconstructions, they are clearly labelled.

The 3D reconstruction is not publically available, contact the authors of the paper (Sam Lambrick & Alek Radic) in the case of interest.
