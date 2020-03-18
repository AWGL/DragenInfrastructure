import argparse
import csv

"""

Program to make the variables files


"""

parser = argparse.ArgumentParser(description='make variables for dragen')
parser.add_argument('--samplesheet', type=str, nargs=1, required=True,
				help='the path to sample sheet')
parser.add_argument('--outputdir', type=str, nargs=1, required=True,
				help='Where to put output.')
parser.add_argument('--seqid', type=str, nargs=1, required=True,
				help='The sequencing id.')
args = parser.parse_args()

samplesheet = args.samplesheet[0]
seqid =  args.seqid[0]
outputdir = args.outputdir[0]


# read csv
with open(samplesheet, 'r') as csvfile:
	spamreader = csv.reader(csvfile, delimiter=',')

	start = False

	list_of_row_dicts = []

	for row in spamreader:


		# skip blank rows
		if row[0] == '':

			continue

		# if we have got to sample bit of sample sheet
		if start == True:

			row_dict = {}

			for key, value in zip(keys, row):

				# deal with description field
				if key == 'Description':

					value = value.split(';')

					for var in value:

						var = var.split('=')

						if 'variables' not in row_dict:

							row_dict['variables'] = {}

						row_dict['variables'][var[0]] = var[1]

				row_dict[key] = value

			list_of_row_dicts.append(row_dict)



		if row[0] == 'Sample_ID':

			keys = row
			start = True



for row_dict in list_of_row_dicts:

	sample_id = row_dict['Sample_ID']
	worksheet = row_dict['Sample_Plate']
	variables = row_dict['variables']

	f = open(outputdir + '/' + sample_id + '.variables', 'w')

	f.write('SampleId=' + str(sample_id) + '\n')
	f.write('WorkListId=' + str(worksheet) + '\n')
	f.write('seqId=' + str(seqid) + '\n')


	for key in variables:

		f.write(str(key) + '=' + str(variables[key]) + '\n')






