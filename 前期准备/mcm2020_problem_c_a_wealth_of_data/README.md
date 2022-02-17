# 亚马逊商品评论数据分析

本项目为《2020年美国数学建模竞赛C题：亚马逊商品评论数据分析》的解题思路与代码。

## 题目介绍
亚马逊网上商城为客户提供了对交易进行评分和评价的机会。客户可以提供三种评价内容：
1. 星级。客户可以用1-5的等级来评价他们对商品的满意度，1的满意度最低，5的满意度最高。
2. 评论。客户可以提交评价的标题和正文文本，提供对产品的更多评价和意见。
3. 帮助评分。客户还可以对其他客户提交的评论进行评价（是否有帮助），以辅助他们自己做出产品购买决策。

赛题提供吹风机、婴儿奶嘴、微波炉三种商品的三个评价数据集，公司使用这些数据来了解商品的市场，借助这些信息来改进产品设计。

## 项目步骤

### 1.  数据清洗

首先观察数据集，初步描绘数据集的特征。
以婴儿奶嘴为例，下面是婴儿奶嘴各等级评分的数量折线图、婴儿奶嘴各等级评分数量随时间变化规律折线图。

<div>
<img src=https://images.gitee.com/uploads/images/2020/1126/164019_adc6e0b2_7747099.png alt="婴儿奶嘴各等级评分的数量" width="40%">
<img src=https://images.gitee.com/uploads/images/2020/1126/164146_f5e4c772_7747099.png alt="婴儿奶嘴各等级评分数量随时间变化规律" width="50%"/>
</div>

去除与数据分析无关的字段，如商品品类、商品大类等。
去掉数据集中的无关商品评价，如在婴儿奶嘴商品评价数据集中的枕头、显示器的商品评价。
去除没有认证购买的商品评价；
将数据标记“n”、“y”转换为“0”、“1”，将字符串数据转换成浮点数，便于下一步的统计分析和预测。
将评价标题与正文拼接起来，去除无关的标点符号，将字母统一转换为小写，用spaCy方法将词语转换成它的词根形式，便于后续的文本分析。

### 2.  词云分析

使用WordCloud库将每种商品的正面和负面的评价中出现频率最高的300个单词制作成词云，可以使我们更直观地看到最具代表性的商品评价的内容是什么。

<div>
<img src=https://images.gitee.com/uploads/images/2020/1126/181600_192eb652_7747099.png "高评分吹风机" width="30%"/>
<img src=https://images.gitee.com/uploads/images/2020/1126/192623_164afafb_7747099.png "高评分微波炉" width="30%"/>
<img src=https://images.gitee.com/uploads/images/2020/1126/192739_c7795d9a_7747099.png "高评分奶嘴" width="30%"/>
</div>
<div>
<img src=https://images.gitee.com/uploads/images/2020/1126/181657_7e6997ba_7747099.png alt="低评分吹风机" width="30%"/>
<img src=https://images.gitee.com/uploads/images/2020/1126/192708_16883265_7747099.png alt="低评分微波炉" width="30%"/>
<img src=https://images.gitee.com/uploads/images/2020/1126/192815_2bf61547_7747099.png alt="低评分奶嘴" width="30%"/>
</div>

### 3.  情感分类

> 情感分类是对带有感情色彩的主观性文本进行分析、推理的过程，即分析对说话人的态度，倾向正面，还是反面。

我们将评分大于3的评价标记为正面评价，小于3的标记为负面评价。
首先调用sklearn库的生成TF-IDF词向量的方法将文本向量化，以正/负面作为标签，分别用伯努利朴素贝叶斯分类器、多项式朴素贝叶斯分类器和线性回归模型进行文本情感分析，用精确率、召回率、F1度量、ROC曲线四种指标评价三种模型的拟合效果，其中线性回归模型表现最优。

<div>
<img src=https://images.gitee.com/uploads/images/2020/1126/170022_bce9ba31_7747099.jpeg "分类器比较.png"/ alt="分类器比较" width="40%">
<img src=https://images.gitee.com/uploads/images/2020/1126/170105_7dbcdea1_7747099.png "三种分类器的ROC曲线.png" alt="三种分类器的ROC曲线" width="50%"/>
</div>

我们用训练出的线性回归模型去预测每条商品评价为正面评价的概率，用权重公式（评分数*6+正面概率*70）*（0.7+有用率*0.1+是否购买*0.1+是否是会员*0.1）计算出每条评价的最终情感得分。


### 4.  LDA主题建模

> LDA由Blei, David M.、Ng, Andrew Y.、Jordan于2003年提出，用来推测文档的主题分布。它可以将文档集中每篇文档的主题以概率分布的形式给出，从而通过分析一些文档抽取出它们的主题分布后，便可以根据主题分布进行主题聚类或文本分类。

我们用sklearn库的LatentDirichletAllocation方法进行主题建模。LDA模型的两个重要的调优参数是主题数（topics）和学习衰减参数（learning_decay），使用 sklearn.model_selection 中的 GridSearchCV 方法在topics=[3, 4, 5, 6, 7], learing_decay=[0.5, 0.7, 0.9]的参数范围中进行网格搜索，从所有的参数中找到在验证集上精度最高的参数，这减少了人工调参的工作量。搜索结果为topics=3, learing_decay=0.7。

用这个方法，最终我们找到了每种商品的最差评价（一星）和最好评价（五星）的三类主题词，以婴儿奶嘴为例：

一星评价主题词：

|         | Word 0       | Word 1   | Word 2  | Word 3 | Word 4  | Word 5  | Word 6  | Word 7 | Word 8 | Word 9 | Word 10   | Word 11  | Word 12 | Word 13 | Word 14 |
|---------|--------------|----------|---------|--------|---------|---------|---------|--------|--------|--------|-----------|----------|---------|---------|---------|
| Topic 0 | disappointed | purchase | look    | really | quality | product | picture | week   | order  | fall   | different | arrive   | old     | thing   | return  |
| Topic 1 | mouth        | nipple   | product | way    | suck    | hard    | old     | look   | hate   | small  | bottle    | medicine | child   | say     | smell   |
| Topic 2 | color        | pink     | money   | time   | waste   | right   | away    | hard   | close  | vary   | blue      | wrong    | order   | instead | really  |

五星评价主题词：

|         | Word 0 | Word 1  | Word 2 | Word 3   | Word 4  | Word 5 | Word 6 | Word 7 | Word 8 | Word 9   | Word 10 | Word 11 | Word 12 | Word 13   | Word 14 |
|---------|--------|---------|--------|----------|---------|--------|--------|--------|--------|----------|---------|---------|---------|-----------|---------|
| Topic 0 | baby   | product | nipple | hospital | brand   | bottle | cute   | work   | shape  | soothie  | time    | really  | want    | different | old     |
| Topic 1 | easy   | mouth   | baby   | hold     | old     | little | night  | animal | help   | fall     | lose    | sleep   | wash    | cute      | time    |
| Topic 2 | baby   | gift    | cute   | little   | perfect | shower | look   | bag    | color  | adorable | girl    | size    | nice    | diaper    | order   |

## 结论

结合词云、感情词袋和主题词，我们得出以下商品设计改进建议：

 **1. 对于婴儿奶嘴** 

- 人们似乎更喜欢婴儿使用可爱的物品，因此奶嘴应该设计成可爱的形状，并且使用受欢迎的颜色。
- 制作奶嘴的材料应当是无毒无害的
- 在奶嘴被生产出来之后，销售之前，应该通风散味


 **2. 对于微波炉** 

- 应该就微波炉的大小进行市场调研，人们似乎更喜欢可以刚好塞进灶台角落的微波炉
- 微波炉的硬件质量应该要好
- 设计足够大的火力
- 微波炉的控制程序应该设计得简明清晰并且易于使用
- 提高售后对用户的响应速度和效率


 **3. 对于吹风机**

- 设计一款便于旅行携带的小尺寸的吹风机
- 设计足够大的风力
- 为了用电安全，应当设计安全装置
- 制定合理的市场价格
