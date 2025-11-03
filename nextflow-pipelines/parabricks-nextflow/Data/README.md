## Download data
Download the sample data provided by pipeline creators from NVIDIA Parabricks:
```
wget -O parabricks_sample.tar.gz "https://s3.amazonaws.com/parabricks.sample/parabricks_sample.tar.gz"
```

## Extract data and stored in appropriate folders
```
tar xvf parabricks_sample.tar.gz
```
This will extract the data and references in 2 separate folders:
`Data`
`Ref`

Once you run first pipeline `fq2bam`, it creates an output that will be used by `germline`.
