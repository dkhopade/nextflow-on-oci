# Parabricks NextFlow Workflows

Clone the repo in a desired folder:
```
git clone https://github.com/clara-parabricks-workflows/parabricks-nextflow.git
```

Ensure the data is available (locally or shared) for the paths provided in `example_inputs/test.fq2bam.json` and `example_inputs/test.germline.json` files.
Like below:
```
ubuntu@node-controller:~/next-flow-pipelines/parabricks-nextflow$ cat example_inputs/test.fq2bam.json
{
    "inputFASTQ_1" : "/home/ubuntu/next-flow-pipelines/parabricks-nextflow/data/parabricks_sample/Data/sample_1.fq.gz",
    "inputFASTQ_2" : "/home/ubuntu/next-flow-pipelines/parabricks-nextflow/data/parabricks_sample/Data/sample_2.fq.gz",
    "inputRef" : "/home/ubuntu/next-flow-pipelines/parabricks-nextflow/data/parabricks_sample/Ref/Homo_sapiens_assembly38.fasta",
    "inputKnownSitesVCF" : "/home/ubuntu/next-flow-pipelines/parabricks-nextflow/data/parabricks_sample/Ref/Homo_sapiens_assembly38.known_indels.vcf.gz"
}
ubuntu@node-controller:~/next-flow-pipelines/parabricks-nextflow$ cat example_inputs/test.germline.json
{
    "inputBAM" : "/home/ubuntu/next-flow-pipelines/parabricks-nextflow/data/parabricks_sample/Data/germline-data/sample_1.fq.pb.bam",
    "inputBAI" : "/home/ubuntu/next-flow-pipelines/parabricks-nextflow/data/parabricks_sample/Data/germline-data/sample_1.fq.pb.bam.bai",
    "inputBQSR" : "/home/ubuntu/next-flow-pipelines/parabricks-nextflow/data/parabricks_sample/Data/germline-data/sample_1.fq.pb.BQSR-REPORT.txt",
    "inputRef" : "/home/ubuntu/next-flow-pipelines/parabricks-nextflow/data/parabricks_sample/Data/germline-data/Homo_sapiens_assembly38.fasta"
}
```
Generally when you run the first pipeline `fq2bam`, it produces the data that will be used by next pipeline `germline`, so you can follow that path as well.
To understand these pipelines, follow their respective `.nf` files in the folders as below:
```
cat nextflow/fq2bam.nf
cat nextflow/germline.nf
```

Next step is to make sure the nextflow configuration files are setup correctly, such as what container to use and the runtime like docker or singularity.
```
ubuntu@node-controller:~/next-flow-pipelines/parabricks-nextflow$ cat config/local.nf.conf
process {
  container = 'nvcr.io/nvidia/clara/clara-parabricks:4.3.0-1'
  maxForks = 1
  containerOptions = { workflow.containerEngine == "singularity" ? '--nv':
    ( workflow.containerEngine == "docker" ? '--gpus all': null ) }
}

docker.enabled = true
```
Note in the above pipeline, its configured to run using all the GPUs available on the compute node (not a controller node). 

## Finally run the pipeline
This is basic command to run this pipeline; you can adjust the parameters such as output & work folders etc.
```
nextflow \
    run nextflow/fq2bam.nf \
    -c config/local.nf.conf \
    -params-file example_inputs/test.fq2bam.json
```
