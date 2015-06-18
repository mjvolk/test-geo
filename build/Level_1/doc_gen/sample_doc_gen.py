# Written by: Kelvin Abrokwa-Johnson
#
# Adjusting the readme generator to fit the DRC geocoded data

from cd_docutility import cd_docutility

readme = cd_docutility('../../../scratch/temp/Level_1/research_release/data/projects.tsv', 
						'../../../scratch/temp/Level_1/research_release/data/locations.tsv',
						'../../../scratch/temp/Level_1/research_release/data/transactions.tsv')

readme.append_document_title()

readme.append_contact_information()

readme.append_coverage_info()

readme.append_glossary()

readme.append_files_table()

readme.append_overview()

readme.append_GIS()

readme.append_tabular()

readme.append_caveats()

readme.append_precision_code_table()

readme.append_precision_code_chart()

readme.append_precision_code_sector_chart()

readme.append_year_count_chart()

readme.append_sources_table()

readme.append_license()

readme.build()
