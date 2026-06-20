#!/bin/bash
# TSMixer 超参数遍历实验脚本
# 固定 seq_len=336 pred_len=96 n_block=4 ff_dim=32

# ===================== 全局固定参数 =====================
MODEL="tsmixer"
SEQ_LEN=336
PRED_LEN=96
N_BLOCK=4
FF_DIM=32
DATA_LIST=("weather" "electricity" "ETTh1")

echo "============================================="
echo "开始第一组实验：固定 learning_rate=0.0001，遍历 dropout"
echo "dropout 取值：0.1 0.2 0.4 0.5"
echo "数据集：weather electricity ETTh1"
echo "============================================="

# 第一组：lr=0.0001，遍历 dropout: 0.1 0.2 0.4 0.5
LR_FIRST=0.0001
DROPOUT_LIST1=("0.1" "0.2" "0.4" "0.5")

for dropout in "${DROPOUT_LIST1[@]}"
do
    for data in "${DATA_LIST[@]}"
    do
        echo -e "\n【运行】数据集: $data | lr: $LR_FIRST | dropout: $dropout"
        python run.py \
            --model $MODEL \
            --data $data \
            --seq_len $SEQ_LEN \
            --pred_len $PRED_LEN \
            --learning_rate $LR_FIRST \
            --n_block $N_BLOCK \
            --dropout $dropout \
            --ff_dim $FF_DIM
    done
done

echo -e "\n============================================="
echo "第一组实验全部完成！"
echo "开始第二组实验：固定 dropout=0.3，遍历 learning_rate"
echo "learning_rate 取值：0.00005 0.0005 0.001 0.005"
echo "数据集：weather electricity ETTh1"
echo "============================================="

# 第二组：dropout=0.3，遍历 lr: 0.00005 0.0005 0.001 0.005
DROPOUT_SECOND=0.3
LR_LIST2=("0.00005" "0.0005" "0.001" "0.005")

for lr in "${LR_LIST2[@]}"
do
    for data in "${DATA_LIST[@]}"
    do
        echo -e "\n【运行】数据集: $data | lr: $lr | dropout: $DROPOUT_SECOND"
        python run.py \
            --model $MODEL \
            --data $data \
            --seq_len $SEQ_LEN \
            --pred_len $PRED_LEN \
            --learning_rate $lr \
            --n_block $N_BLOCK \
            --dropout $DROPOUT_SECOND \
            --ff_dim $FF_DIM
    done
done

echo -e "\n============================================="
echo "所有实验运行完毕！结果已保存至 result.csv"
echo "============================================="

