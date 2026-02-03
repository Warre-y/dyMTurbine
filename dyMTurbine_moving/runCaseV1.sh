#!/bin/bash
cd "${0%/*}" || exit                                # Run from this directory
. ${WM_PROJECT_DIR:?}/bin/tools/RunFunctions        # Tutorial run functions
. ${WM_PROJECT_DIR:?}/bin/tools/CleanFunctions      # Tutorial clean functions
#---------------------------------------------------------------------------------

# clean case folder
chmod +x ./Allclean
./Allclean

runApplication blockMesh

# Select cellSets
runApplication -s 1 topoSet

restore0Dir

# Use cellSets to write zoneID
runApplication setFields

#runApplication decomposePar -cellDist
#srun $(getApplication) -parallel > log.$(getApplication)
# runApplication decomposePar -cellDist
# runParallel  $(getApplication)
runApplication  $(getApplication)
#runApplication reconstructPar -time 0:

# process logs
foamLog log.$(getApplication)

touch case.foam

#------------------------------------------------------------------------------
