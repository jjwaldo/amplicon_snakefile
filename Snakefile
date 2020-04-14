#still need to create a conda environment including channels for bioconda conda-forge and biobuilds 
#along with installing fastx_toolkit and flash2 and snakemake-minimal (using bioconda)

rule all:
    input:
        "test.fq"

rule flash2_input:
    input:
        "JH2_dCN_dCC_hTET1CD_320796w_NG5.fastq"
    output:
        "JH02_03_16_20_flash2.extendedFrags.fastq"
    shell:
        "flash2 -M 260 --interleaved-input {input} -o JH02_03_16_20_flash2"


rule bol_splitter:
    input:
        "JH02_03_16_20_flash2.extendedFrags.fastq"
    output:
        "JH_test_bolunmatched.txt"
    shell:
        "cat {input} | fastx_barcode_splitter.pl --bcfile bol.txt --bol --mismatches 1 --prefix JH_test_bol --suffix '.txt'"

rule eol_splitter:
    input:
        "JH02_03_16_20_flash2.extendedFrags.fastq"
    output:
        "JH_test_eolunmatched.txt"
    shell:
        "cat {input} | fastx_barcode_splitter.pl --bcfile eol.txt --eol --mismatches 1 --prefix JH_test_eol --suffix '.txt'"

rule bol_eol_merge:
    input:
        "JH_test_eolunmatched.txt",
        "JH_test_bolunmatched.txt"
    output:
        "test.fq"
    shell:
        "cat {input} > test.fq"
