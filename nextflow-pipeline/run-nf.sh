export NXF_ANSI_LOG="True"
export NXF_SINGULARITY_CACHEDIR=/home/ubuntu/.singularity/cache

nextflow \
    run nextflow/germline.nf \
    -with-report \
    -with-dag \
    -w ./work \
    -c config/slurm.nf-sigularity.conf \
    --outdir ./results \
    -params-file example_inputs/test.fq2bam.json

exit 0