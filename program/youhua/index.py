from unittest import result
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns  # seaborn画出的图更好看，且代码更简单，缺点是可塑性差
from sko.GA import GA

bitcoinValue_FirstDay = 609.39
goldValue_FirstDay = 1324.6
Pbitcoin = pd.read_csv('./bitcoin_final.csv')
bitcoin = pd.read_csv('../dataPreprocess_bitcoin.csv')[19:]
Pgold = pd.read_csv('./goldfinal.csv')
# 重置索引
bitcoin = bitcoin.drop(['id'], axis=1).reset_index(drop=True)
bitcoin.index.name = 'id'
Pbitcoin = Pbitcoin.set_index('id')
# 临时删除
Pbitcoin = Pbitcoin.drop(['lower', 'upper'], axis=1)
N = len(Pbitcoin)
# 合并
bitcoin = bitcoin.rename(columns={'bitcoin': 'real'})
data = pd.merge(bitcoin, Pbitcoin, how='left', on=['Date'])

a = 0.75
k = 0.02

# 初始化
now = [1000, 0]

for i in range(1, N):
    predict = data.iloc[i].predicted_mean
    real = data.iloc[i-1].real
    sd = data.iloc[i].se_mean
    lk = predict-real
    if lk > 0:
        if now[0] > 0:
            now[1] = now[1]+now[0]/(real*(1+k))
            now[0] = 0
            print("买", now[0]+now[1] * data.iloc[i-1].real)
    else:
        if now[1] > 0:
            now[0] = now[0]+now[1]*real*(1-k)
            now[1] = 0
            print("卖", now[0]+now[1] * data.iloc[i-1].real)
