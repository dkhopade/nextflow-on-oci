nextflow \
    run nextflow/fq2bam.nf \
    -c config/local.nf.conf \
    -params-file example_inputs/test.fq2bam.json

exit 0