#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

process deepvariant {

    input:
    path inputFASTQ_1
    path inputFASTQ_2
    path inputRef
    path inputKnownSitesVCF

    output:
    path "${inputFASTQ_1.baseName}.pb.bam"
    path "${inputFASTQ_1.baseName}.pb.bam.bai"
    path "${inputFASTQ_1.baseName}.pb.BQSR-REPORT.txt"
    path "${inputFASTQ_1.baseName}.deepvariant.vcf"

    script:
    def knownSitesStub = inputKnownSitesVCF ? "--knownSites ${inputKnownSitesVCF}" : ''
    def recalStub = inputKnownSitesVCF ? "--out-recal-file ${inputFASTQ_1.baseName}.pb.BQSR-REPORT.txt" : ''

    """
    pbrun deepvariant_germline \
    --in-fq ${inputFASTQ_1} ${inputFASTQ_2} \
    --ref ${inputRef} \
    --out-bam ${inputFASTQ_1.baseName}.pb.bam \
    --out-variants "${inputFASTQ_1.baseName}.deepvariant.vcf" \
    ${knownSitesStub} \
    ${recalStub} --low-memory
    """
}

workflow Parabricks_Germline {
    deepvariant(
        inputFASTQ_1=params.inputFASTQ_1,
        inputFASTQ_2=params.inputFASTQ_2,
        inputRef=params.inputRef,
        inputKnownSitesVCF=params.inputKnownSitesVCF
    )
}

workflow {
    Parabricks_Germline()
}