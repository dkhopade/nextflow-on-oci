nextflow \
    run nf-core/rnaseq \
    -with-report \
    -w ./work \
    --input ./samplesheet_test.csv \
    -resume \
    -c test.config \
    -c nextflow.config \
    --outdir ./results \
    -profile slurm

exit 0