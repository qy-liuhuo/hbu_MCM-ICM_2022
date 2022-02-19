import pandas as pd
import matplotlib as plt
import numpy as np
import seaborn as sns  # seaborn画出的图更好看，且代码更简单，缺点是可塑性差
from statsmodels.graphics.tsaplots import plot_acf  # 自相关图
from statsmodels.tsa.stattools import adfuller as ADF  # 平稳性检测
from statsmodels.graphics.tsaplots import plot_pacf  # 偏自相关图
from statsmodels.stats.diagnostic import acorr_ljungbox  # 白噪声检验
from statsmodels.tsa.arima.model import ARIMA
import statsmodels

import warnings
warnings.filterwarnings('ignore')

bitcoin = pd.read_csv('../BCHAIN-MKPRU.csv')
bitcoin.Date = pd.to_datetime(bitcoin.Date)

time = []
p = []
war = []
train = bitcoin.set_index('Date')
for i in range(20, 1827):
    try:
        model = ARIMA(train[0:i], order=(2, 1, 2)).fit()
        predictions_f_ms = model.predict(i, i+1, dynamic=True, typ='levels')
    except:
        # 用前一天代替
        p.append(bitcoin.bitcoin[i-1])
        time.append(bitcoin.index(i))
        war.append(i)
        continue
    p.append(predictions_f_ms[0])
    time.append(predictions_f_ms.index[0])

re = pd.DataFrame()
re['Date'] = time
re['Value'] = p
re.to_csv("bitcoin.csv")
