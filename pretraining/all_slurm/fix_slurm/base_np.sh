#!/bin/sh
{
python train.py /checkpoint/omerlevy/mandar_data/bookwiki_aml_cased --total-num-update 2400000 --max-update 2400000  --save-interval 1 --arch cased_bert_hf --task  span_bert --optimizer adam --lr-scheduler polynomial_decay --lr 0.00025  --min-lr 1e-09  --criterion no_nsp_bert_loss  --max-tokens 4096 --tokens-per-sample 512 --weight-decay 0.01  --skip-invalid-size-inputs-valid-test --log-format json --log-interval 2000 --save-interval-updates 50000 --keep-interval-updates 50000 --update-freq 1 --seed 1 --save-dir /checkpoint/omerlevy/fix_models/base_np --fp16 --warmup-updates 10000 --schemes [\"ner_span\"] --distributed-port 12580 --distributed-world-size 32 --span-lower 1 --span-upper 10 --validate-interval 1  --clip-norm 1.0 --geometric-p 0.2 --adam-eps 1e-6 --short-seq-prob 0.0 --replacement-method span --return-only-spans --clamp-attention --tag-bitmap-file-prefix /checkpoint/omerlevy/mandar_data/bookwiki_aml_cased/np_map_ --no-nsp --no-sample-size-normalization
kill -9 $$
} & 
child_pid=$!
trap "echo 'TERM Signal received';" TERM
trap "echo 'Signal received'; if [ "$SLURM_PROCID" -eq "0" ]; then sbatch fix_slurm/base_np.slrm; fi; kill -9 $child_pid; " USR1
while true; do     sleep 1; done
