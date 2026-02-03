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

touch case.foam

#------------------------------------------------------------------------------
