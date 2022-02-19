from unittest import result
import pandas as pd
import matplotlib as plt
import numpy as np
import seaborn as sns  # seaborn画出的图更好看，且代码更简单，缺点是可塑性差
from statsmodels.graphics.tsaplots import plot_acf  # 自相关图
from statsmodels.tsa.stattools import adfuller as ADF  # 平稳性检测
from statsmodels.graphics.tsaplots import plot_pacf  # 偏自相关图
from statsmodels.stats.diagnostic import acorr_ljungbox  # 白噪声检验
from statsmodels.tsa.arima.model import ARIMA
from statsmodels.tsa.statespace import mlemodel

import warnings
warnings.filterwarnings('ignore')

bitcoin = pd.read_csv('../BCHAIN-MKPRU.csv')
bitcoin.Date = pd.to_datetime(bitcoin.Date)

result = pd.DataFrame(
    columns=['Date', 'predicted_mean', 'se_mean', 'lower', 'upper'])
train = bitcoin.set_index('Date')
for i in range(20, 1827):  # 1827
    try:
        model = ARIMA(train[0:i], order=(2, 1, 2)).fit().get_forecast()
        result.loc[i-20] = [model.conf_int(alpha=0.05).index,
                            model.predicted_mean,
                            model.se_mean,
                            model.conf_int(
                                alpha=0.05).iloc[0]['lower bitcoin'],
                            model.conf_int(alpha=0.05).iloc[0]['upper bitcoin']]
    except:
        print('**********************************************************')

print(result)
