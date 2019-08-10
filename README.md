# model-for-DROP

## train
```
allennlp train bert5.jsonnet -s models --include-package code 
```

## Details
We employ a python library decimal for decimal fixed point and floating point arithmetic. 
The model is trained for 20 epochs with batch size 10 
Implementation is done with allennlp[21], and all models are trained on two GTX 1080tis. 
