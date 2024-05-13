Work here developing basic nextflow workflow to run mnp_filter.

From mnp_filter/cwl/mnp_filter.cwl

```
id: mnp_filter
baseCommand:
  - /usr/local/bin/python
  - /opt/mnp_filter/src/mnp_filter.py
inputs:
  - id: input
    type: File
    inputBinding:
      position: 0
      prefix: '--input'
    label: VCF file
  - id: tumor_bam
    type: File
    inputBinding:
      position: 0
      prefix: '--bam'
    label: tumor bam
    secondaryFiles:
      - .bai
outputs:
  - id: filtered_VCF
    type: File
    outputBinding:
      glob: MNP_combined.vcf
label: MNP_filter
arguments:
  - position: 0
    prefix: '--output'
    valueFrom: MNP_combined.vcf
requirements:
  - class: ResourceRequirement
    ramMin: 4000
  - class: DockerRequirement
    dockerPull: 'dinglab2/mnp_filter:20191211'
  - class: InlineJavascriptRequirement
```

# Demo data

## Case A

Picking random case from recent gdan analysis.  Looking for an unexceptional run.

Use batch 33.MILD_161. Picking at random (100th line) from /storage1/fs1/dinglab/Active/Projects/CPTAC3/Analysis/CromwellRunner/TinDaisy/33.MILD_161/dat/analysis_summary.stored.dat
     1  # run_name  MILD-B595
     2  case    MILD-B595
     3  disease Bronchus_and_lung
     4  result_path /storage1/fs1/m.wyczalkowski/Active/cromwell-data/cromwell-workdir/cromwell-executions/tindaisy2.6.2.cwl/9e9c3d7e-a45e-4720-9c18-f9cc2525e851/call-snp_indel_proximity_filter/execution/output/ProximityFiltered.vcf
     5  file_format VCF
     6  tumor_name  MILD-B595.WXS.T.hg38
     7  tumor_uuid  d4d5de18-256d-41b2-9e05-c1e702ae1a4e
     8  normal_name MILD-B595.WXS.N.hg38
     9  normal_uuid 564fbd6d-64fb-4045-b5b4-7df668c7335f
    10  cromwell_workflow_id    9e9c3d7e-a45e-4720-9c18-f9cc2525e851

YAML file: /storage1/fs1/dinglab/Active/Projects/CPTAC3/Analysis/CromwellRunner/TinDaisy/33.MILD_161/logs/stashed/9e9c3d7e-a45e-4720-9c18-f9cc2525e851/MILD-B595.yaml
normal_bam: /storage1/fs1/m.wyczalkowski/Active/Primary/CPTAC3.share/GDAN-GDC/GDC_import/data/564fbd6d-64fb-4045-b5b4-7df668c7335f/bc7af678-cbdb-41c5-88d6-de00eab38794_wxs_gdc_realn.bam
tumor_bam: /storage1/fs1/m.wyczalkowski/Active/Primary/CPTAC3.share/GDAN-GDC/GDC_import/data/d4d5de18-256d-41b2-9e05-c1e702ae1a4e/db367e08-8bd2-42dc-90d3-60c53e3ea75c_wxs_gdc_realn.bam
reference_fasta: /storage1/fs1/dinglab/Active/Resources/References/GRCh38.d1.vd1/GRCh38.d1.vd1.fa

-> this data has been deleted

## Case B

Reviewing BamMap and TinDaisy runs, seeing what runs may have data not yet deleted.  MILD appears to have existing WGS files.  Eyeballing,
Analysis summary: /rdcw/fs1/dinglab/Active/Projects/CPTAC3/Analysis/CromwellRunner/TinDaisy/37.DLBCL_72/dat/analysis_summary.stored.dat
BamMap: /rdcw/fs2/home1/Active/home/m.wyczalkowski/Projects/GDAN/GDAN.catalog/Catalog3/WUSTL-BamMap/CTSP_DLBCL.BamMap-wide.tsv

Case: CTSP-B2ID
Analysis summary:
     1  # run_name  CTSP-B2ID
     2  case    CTSP-B2ID
     3  disease unknown
     4  result_path /storage1/fs1/dinglab/Active/Projects/m.wyczalkowski/cromwell-data/cromwell-workdir/cromwell-executions/tindaisy2.6.2.cwl/722d9b49-6eb5-4ed8-a245-f12a3f89a4ce/call-snp_indel_proximity_filter/execution/output/ProximityFiltered.vcf
     5  file_format VCF
     6  tumor_name  CTSP-B2ID.WGS.F
     7  tumor_uuid  c091d0df-6c94-4dd2-a363-6c9a8ff826c2
     8  normal_name CTSP-B2ID.WGS.N
     9  normal_uuid 1db5d2f3-2660-4fb7-8afb-d244f63376db
    10  cromwell_workflow_id    722d9b49-6eb5-4ed8-a245-f12a3f89a4ce

YAML: /storage1/fs1/dinglab/Active/Projects/CPTAC3/Analysis/CromwellRunner/TinDaisy/37.DLBCL_72/logs/stashed/722d9b49-6eb5-4ed8-a245-f12a3f89a4ce/CTSP-B2ID.yaml
VCF: /storage1/fs1/dinglab/Active/Projects/m.wyczalkowski/cromwell-data/cromwell-workdir/cromwell-executions/tindaisy2.6.2.cwl/722d9b49-6eb5-4ed8-a245-f12a3f89a4ce/call-snp_indel_proximity_filter/execution/output/ProximityFiltered.vcf

normal_bam: /storage1/fs1/m.wyczalkowski/Active/Primary/CPTAC3.share/GDAN-GDC/GDC_import/data/1db5d2f3-2660-4fb7-8afb-d244f63376db/CTSP-B2ID-NB1-A-1-0-D-A889-36.WholeGenome.RP-1329.bam
tumor_bam: /storage1/fs1/m.wyczalkowski/Active/Primary/CPTAC3.share/GDAN-GDC/GDC_import/data/c091d0df-6c94-4dd2-a363-6c9a8ff826c2/CTSP-B2ID-TTP1-A-1-0-D-A889-36.WholeGenome.RP-1329.bam
reference_fasta: /storage1/fs1/dinglab/Active/Resources/References/GRCh38.d1.vd1/GRCh38.d1.vd1.fa

BAM files exist.  VCF exists

compressed_results.tar.gz file expanded to,
RUN_ROOT="/storage1/fs1/dinglab/Active/Projects/m.wyczalkowski/cromwell-data/cromwell-workdir/cromwell-executions/tindaisy2.6.2.cwl/722d9b49-6eb5-4ed8-a245-f12a3f89a4ce/analysis"



