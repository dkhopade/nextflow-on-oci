export NXF_ANSI_LOG="True"
export NXF_SINGULARITY_CACHEDIR=/home/ubuntu/.singularity/cache

nextflow \
    run nf-core/rnaseq \
    -with-report \
    -w ./work \
    --input ./samplesheet_test.csv \
    -c test.config \
    -c nextflow.config \
    --outdir ./results \
    -profile singularity

exit 0