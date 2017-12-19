import pandas as pd


smallV_metaG=pd.read_table('inputs/PRJEB4419_smallVirus_metaG/PRJEB4419.txt')
largeV_metaG=pd.read_table('inputs/PRJEB1788_largeVirus_metaG/PRJEB1788.txt')

rule all:
    input: expand("outputs/{subset}/{run_id}.sig",\
                run_id = smallV_metaG['run_accession'],\
                subset = ['PRJEB4419_smallVirus_metaG']),\
            expand("outputs/{subset}/{run_id}.sig",\
                        run_id = largeV_metaG['run_accession'],\
                        subset = ['PRJEB1788_largeVirus_metaG']),


rule compute_sigs:
    input: forward="inputs/{subset}/{run_id}_1.fastq.gz",
           reverse="inputs/{subset}/{run_id}_2.fastq.gz"
    output: "outputs/{subset}/{run_id}.sig"
    conda: "envs/sourmash.yml"
    shell: """
        zcat {input.forward} {input.reverse} | sourmash compute -k 21,31,51 \
                        --scaled 1000 \
                        -o {output} -
    """
