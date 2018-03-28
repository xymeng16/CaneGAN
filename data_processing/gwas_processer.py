import csv

gwas_path = 'E:\BioData\GWAS\gwas_catalog_v1.0-associations_e91_r2018-02-28.tsv'
gwas_cancer_only_path = 'E:\BioData\GWAS\gwas_cancer_only.tsv'

def gwas_cancer_row_filter(input_csv):
    reader = csv.reader(input_csv, delimiter='\t')
    total_count = 0
    cancer_container = []
    for row in reader:
        total_count = total_count + 1
        if total_count == 1:
            cancer_container.append(row)
            continue
        if row[7].find('cancer') != -1:
            cancer_container.append(row)
    #     # print ','.join(row)
    return total_count, cancer_container

def gwas_cancer_row_writer(output_csv, cancer_container):
    writer = csv.writer(output_csv, delimiter='\t')
    for row in cancer_container:
        writer.writerow(row)

with open(gwas_path, 'r') as input_csv:
    total_count, cancer_container = gwas_cancer_row_filter(input_csv)

print cancer_container.__len__()
print cancer_container[0]

with open(gwas_cancer_only_path, 'w+') as output_cancer_only_csv:
    gwas_cancer_row_writer(output_cancer_only_csv, cancer_container)