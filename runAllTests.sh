#!/bin/bash

echo ""
./runJunitTests.sh

echo ""
./runNodeTests.sh

echo ""
./runCurlTests.sh

#echo ""
#./runABTests.sh

echo ""
./runAutoCannonTests.sh
