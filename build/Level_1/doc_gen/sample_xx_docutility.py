# Written by: Kelvin Abrokwa-Johnson, Scott Stewart, Alex Kappel
# DocUtility class for DRC inheriting from docutility inheriting
# build-assets

import sys

sys.path.append('../../../../build-assets/build_utilities/doc_gen')

import json
import locale
from reportlab.lib.pagesizes import letter
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, PageBreak, Image, Table, TableStyle
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.lib import colors
from reportlab.lib.units import inch
from reportlab.graphics.shapes import Drawing, Rect
from reportlab.graphics.charts.barcharts import VerticalBarChart, HorizontalBarChart
from reportlab.graphics.charts.textlabels import Label
from reportlab.graphics.charts.legends import Legend
from reportlab.rl_config import canvas_basefontname as _baseFontName

from docutility import DocUtility

# Parse JSON and create variables
locale.setlocale( locale.LC_ALL, '' )

s = open('../build_vars.json', 'r')
jsv = json.loads(s.read())
locals().update(jsv)
s.close()

class xx_docutility(DocUtility):
	pass
