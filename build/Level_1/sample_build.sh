# install python
# if you make any changes to the python build-env or settings you should update the build-assets repo!

curl -s -o use-python https://repository-cloudbees.forge.cloudbees.com/distributions/ci-addons/python/use-python 
#wget -q https://repository-cloudbees.forge.cloudbees.com/distributions/ci-addons/python/use-python
PYTHON_VERSION=2.7.2 . ./use-python
virtualenv -q build-assets/jenkins-env/buildenv
source ./build-assets/jenkins-env/buildenv/bin/activate

#validate Level 0 projects 
build-assets/jenkins-env/csv-validator/csv-validator-cmd/target/appassembler/bin/validate  data-set/products/Level_0/projects.tsv data-set/inputs/schemas/Level_0/projects.csvs

#validate Level 0 transactions
build-assets/jenkins-env/csv-validator/csv-validator-cmd/target/appassembler/bin/validate  data-set/products/Level_0/transactions.tsv data-set/inputs/schemas/Level_0/transactions.csvs

#validate Level 0 locations
build-assets/jenkins-env/csv-validator/csv-validator-cmd/target/appassembler/bin/validate  data-set/products/Level_0/locations.tsv data-set/inputs/schemas/Level_0/locations.csvs

#get build version and product name
cd data-set/build/Level_1

version="$(python -c 'import sys; sys.path.append("../../../build-assets/build_utilities"); from buildutility import BuilderClass; x = BuilderClass(); print x.retrieve_version()')"
dataset="$(python -c 'import sys; sys.path.append("../../../build-assets/build_utilities"); from buildutility import BuilderClass; x = BuilderClass(); print x.retrieve_dataset()')"


ext=".zip"
v="_v_"
outfile=$dataset$v$version$ext
outdir=$dataset$v$version
cd ../../..

#create level 1 directories 
rm -rf data-set/products/Level_1
rm -rf data-set/scratch/temp

mkdir data-set/products/Level_1
mkdir data-set/products/Level_1/research_release
mkdir data-set/scratch/temp
mkdir data-set/scratch/temp/Level_1 
mkdir data-set/scratch/temp/Level_1/research_release
mkdir data-set/scratch/temp/Level_1/research_release/data
mkdir data-set/scratch/temp/Level_1/research_release/metadata
mkdir data-set/scratch/temp/Level_1/research_release/docs

#copy all product files
cp data-set/products/Level_0/*.tsv data-set/scratch/temp/Level_1/research_release/data

#copy all metadata files
cp data-set/inputs/metadata/*.tsv data-set/scratch/temp/Level_1/research_release/metadata

#copy all doc files
cp data-set/inputs/docs/*.* data-set/scratch/temp/Level_1/research_release/docs

#build the release
cd data-set/build/Level_1
python builder.py

if [ "$?" = "1" ]; then
	echo "ERROR: Builder failed, exiting"
	exit 1
fi

cd ../../..

#generate the README
cd data-set/build/Level_1/doc_gen
python doc_gen.py

#copy README to release folder
cd ../../../..
mv data-set/products/Level_1/*.pdf data-set/scratch/temp/Level_1/research_release/


#if [ "$?" = "1" ]; then
#	echo "ERROR: Document generator failed, exiting"
#	exit 1
#fi


#validate Level 1 projects 
build-assets/jenkins-env/csv-validator/csv-validator-cmd/target/appassembler/bin/validate  data-set/scratch/temp/Level_1/research_release/data/projects.tsv data-set/inputs/schemas/Level_1/projects.csvs

#validate Level 1 transactions
build-assets/jenkins-env/csv-validator/csv-validator-cmd/target/appassembler/bin/validate  data-set/scratch/temp/Level_1/research_release/data/transactions.tsv data-set/inputs/schemas/Level_1/transactions.csvs

#validate Level 1 locations
build-assets/jenkins-env/csv-validator/csv-validator-cmd/target/appassembler/bin/validate  data-set/scratch/temp/Level_1/research_release/data/locations.tsv data-set/inputs/schemas/Level_1/locations.csvs


#zip it all up
cd data-set/scratch/temp/Level_1/
mv research_release $outdir
zip -r $outfile *
cd ../../../..
cp data-set/scratch/temp/Level_1/*.zip data-set/products/Level_1/research_release



