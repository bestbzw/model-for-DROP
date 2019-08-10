{
    "dataset_reader": {
        "type": "drop2",
        "token_indexers": {
            "tokens":{
                "type":"bert-pretrained2",
                "pretrained_model":"/data/package/bert-base-uncased"
            }
        },
        "passage_length_limit": 380,
        "question_length_limit": 50,
        "external_number": [1,100],
        "skip_when_all_empty": ["spans", "addition_subtraction", "counting"],
        "instance_format": "force_add"
    },
    "validation_dataset_reader": {
        "type": "drop2",
        "token_indexers": {
            "tokens":{
                "type":"bert-pretrained2",
                "pretrained_model":"/data/package/bert-base-uncased"
            }
        },
        "passage_length_limit": 400,
        "question_length_limit": 50,
        "external_number": [1,100],
        "skip_when_all_empty": [],
        "instance_format": "force_add"
    },
    "train_data_path": "../../data/drop_dataset/drop_dataset_train.json",
    "validation_data_path": "../../data/drop_dataset/drop_dataset_dev.json",
    "model": {
        "type": "bert5",
        "text_field_embedder": {
            "token_embedders": {
                "tokens": {
                    "type": "bert-pretrained",
                    "pretrained_model":"/data/package/bert-base-uncased",
                    "requires_grad": true,
                    "top_layer_only": true
                }
            },
            allow_unmatched_keys: true
        },
        "encoding_in_dim": 768,
        "encoding_out_dim": 768,
        "modeling_in_dim": 768,
        "modeling_out_dim": 768,
        "external_number": [1,100],
        "dropout_prob": 0.1,
        "regularizer": [
            [
                ".*",
                {
                    "type": "l2",
                    "alpha": 1e-07
                }
            ]
        ],
        "answering_abilities": [
            "span_extraction",
            "addition_subtraction",
            "counting"
        ]
    },
    "iterator": {
        "type": "bucket",
        "sorting_keys": [
            [
                "passage_question",
                "num_tokens"
            ]
        ],
        "batch_size": 5,
        "max_instances_in_memory": 600
    },
    "trainer": {
        "num_epochs": 20,
        "grad_norm": 5,
        "patience": 10,
        "validation_metric": "+f1",
        "cuda_device": [1,0],
        "optimizer": {
            "type": "bert_adam",
            "lr": 3e-5,
            "eps": 1e-07
        },
        "moving_average": {
            "type": "exponential",
            "decay": 0.9999
        }
    }
}
