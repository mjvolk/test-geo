# Written by: Nathan Owen, Alex Kappel
# xx_builder class inherits from BuilderClass which is located in build utility within 
# the build-assets repository

from xx_buildutility import countryname_builder


builder = nepal_builder(projects_tsv = '../../scratch/temp/Level_1/research_release/data/projects.tsv',
						locations_tsv = '../../scratch/temp/Level_1/research_release/data/locations.tsv',
						transactions_tsv = '../../scratch/temp/Level_1/research_release/data/transactions.tsv',
						sector_trans_crosswalk_tsv = '../../scratch/temp/Level_1/research_release/metadata/sector_trans_crosswalk.tsv',
						donor_trans_crosswalk_tsv = '../../scratch/temp/Level_1/research_release/metadata/donor_trans_crosswalk.tsv',
						deflator_values_tsv= '../../scratch/temp/Level_1/research_release/metadata/deflator_values.tsv',
						status_trans_crosswalk_tsv= '../../scratch/temp/Level_1/research_release/metadata/status_trans_crosswalk.tsv',
						geonames_tsv = '../../scratch/temp/Level_1/research_release/metadata/geonames.tsv')

builder.build_geocoded_dataset()