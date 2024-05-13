// Based on script here: https://www.nextflow.io/docs/latest/overview.html

params.vcf = "/storage1/fs1/dinglab/Active/Projects/m.wyczalkowski/cromwell-data/cromwell-workdir/cromwell-executions/tindaisy2.6.2.cwl/722d9b49-6eb5-4ed8-a245-f12a3f89a4ce/call-snp_indel_proximity_filter/execution/output/ProximityFiltered.vcf"
params.script = "/storage1/fs1/m.wyczalkowski/Active/ProjectStorage/GDAN/Work/2024.nextflow-dev/mnp_filter-nextflow/mnp_filter-dev/src/mnp_filter.py"

// these two work, but are placeholder trash
//params.tumor_bam = "/storage1/fs1/dinglab/Active/Primary/GDAN-GDC/GDC_import/data/9bfb1c81-6e6e-42bf-8c35-44449177631d/3bb4acb0-4e6c-428c-917b-5ab66bb152da_wxs_gdc_realn.bam" // testing this just for the path.  It is trash - but it proceeds
//params.tumor_bai = "/storage1/fs1/dinglab/Active/Primary/GDAN-GDC/GDC_import/data/9bfb1c81-6e6e-42bf-8c35-44449177631d/3bb4acb0-4e6c-428c-917b-5ab66bb152da_wxs_gdc_realn.bam.bai" // testing this just for the path.  It is trash

// believed correct: params.tumor_bam = "/storage1/fs1/m.wyczalkowski/Active/Primary/CPTAC3.share/GDAN-GDC/GDC_import/data/c091d0df-6c94-4dd2-a363-6c9a8ff826c2/CTSP-B2ID-TTP1-A-1-0-D-A889-36.WholeGenome.RP-1329.bam"
params.tumor_bam = "/storage1/fs1/m.wyczalkowski/Active/Primary/CPTAC3.share/GDAN-GDC/GDC_import/data/c091d0df-6c94-4dd2-a363-6c9a8ff826c2/CTSP-B2ID-TTP1-A-1-0-D-A889-36.WholeGenome.RP-1329.bam"
params.tumor_bai = "/storage1/fs1/m.wyczalkowski/Active/Primary/CPTAC3.share/GDAN-GDC/GDC_import/data/c091d0df-6c94-4dd2-a363-6c9a8ff826c2/CTSP-B2ID-TTP1-A-1-0-D-A889-36.WholeGenome.RP-1329.bam.bai"

// Random BAMs
//storage1/fs1/m.wyczalkowski/Active/Primary/CPTAC3.share/GDAN-GDC/GDC_import/data/3beb3be8-2db9-4828-9e42-9a326543ec19/CTSP-B3LK-NB1-A-1-0-D-A877-36.WholeGenome.RP-2372.bam
//storage1/fs1/dinglab/Active/Primary/GDAN-GDC/GDC_import/data/9bfb1c81-6e6e-42bf-8c35-44449177631d/3bb4acb0-4e6c-428c-917b-5ab66bb152da_wxs_gdc_realn.bam


log.info """\
    mnp_filter.nf
    ===================================
    input.vcf: ${params.vcf}
    tumor.bam: ${params.tumor_bam}
    tumor.bai: ${params.tumor_bai}
    output:    MNP_combined.vcf
    """
    .stripIndent(true)


// .bai file may be an issue?
process run_mnp_filter {
  input:
  path "input.vcf"
  path "tumor.bam"
  path "tumor.bai"
  path "mnp_filter.py"

  output:
  path "MNP_combined.vcf"

  """
  /usr/local/bin/python mnp_filter.py --input input.vcf --bam tumor.bam --output MNP_combined.vcf
  """
}

workflow {
  run_mnp_filter(params.vcf, params.tumor_bam, params.tumor_bai, params.script)
}

