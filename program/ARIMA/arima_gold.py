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
import statsmodels

import warnings
warnings.filterwarnings('ignore')

gold = pd.read_csv('../LBMA-GOLD.csv')
gold.Date = pd.to_datetime(gold.Date)

# start
start = pd.to_datetime(a['Time_Day'].min())
# end
end = pd.to_datetime(a['Time_Day'].max())
dates = pd.date_range(start=start, end=end, freq='D')

# 生成连续数据
data_continue = pd.DataFrame(index=range(len(dates)))
data_continue['Time_Day'] = dates
data_continue = pd.merge(data_continue, data, on='Time_Day', how='left')


time = []
p = []
war = []
train = gold.set_index('Date')
gold = gold.set_index('Date')
# 1255
for i in range(20, 1255):
    try:
        model = ARIMA(train[0:i], order=(3, 1, 4)).fit()
        predictions_f_ms = model.predict(i, i+1, dynamic=True, typ='levels')
    except:
        print(i)
        # 用前一天的代替
        p.append(gold.gold[i-1])
        time.append(gold.index[i])
        war.append(i)
        continue
    time.append(gold.index[i-1])
    p.append(predictions_f_ms.iloc[0])


re = pd.DataFrame()
re['Date'] = time
re['Value'] = p
re.to_csv("./gold.csv")
print("successful")
