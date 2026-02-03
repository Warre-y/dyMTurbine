#!/bin/bash
cd "${0%/*}" || exit                                # Run from this directory
. ${WM_PROJECT_DIR:?}/bin/tools/RunFunctions        # Tutorial run functions
. ${WM_PROJECT_DIR:?}/bin/tools/CleanFunctions      # Tutorial clean functions
#---------------------------------------------------------------------------------

# clean case folder
cd dyMTurbine_background || exit
chmod +x ./Allclean
./Allclean
touch case.foam
cd ..

cd dyMTurbine_moving || exit
chmod +x ./Allclean
./Allclean
cd ..

echo "Generating moving mesh..."
cd dyMTurbine_moving || exit
runApplication blockMesh
cd ..

echo "Generating background mesh..."
cd dyMTurbine_background || exit
runApplication blockMesh
cd ..

echo "Merging meshes..."
cd dyMTurbine_background || exit
mergeMeshes . ../dyMTurbine_moving -overwrite

restore0Dir
# Select cellSets
echo "Running topoSet"
runApplication topoSet
#runApplication -s 1 topoSet

runApplication setFields

runApplication checkMesh | grep "BoundingBox"
#runApplication -s 2 topoSet -dict system/topoSetDict_moving

#restore0Dir

# Use cellSets to write zoneID
#runApplication setFields


# Serial
#runApplication  $(getApplication)

# Parallel
runApplication decomposePar -force -cellDist
srun $(getApplication) -parallel > log.$(getApplication)
runApplication reconstructPar -time 0:

# process logs
foamLog log.$(getApplication)


#------------------------------------------------------------------------------
