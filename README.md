# 2019新人编程考核

---

## Linux基础

### 1. 创建目录

- 在/TJPROJ1/MICRO/目录下，建立个人目录（目录名为自己姓名拼音），并进入个人目录，建立本次考核的总目录：NG_xx （xx为自己的姓名全拼）；在该目录下建立考核子目录（如，01.Linux，02.Perl，03.Statistics）。

- **考核目录所在的路径是（）**


### 2. 软链/TJPROJ1/MICRO/wangpeng/NewTest/ linux_file/test.m8到自己的01.Linux目录下：
   
   注：先将/TJPROJ1/MICRO/wangpeng/NewTest/TEST.log拷贝到自己的NG_xxx目录下，将1）-10）的答案按格式写到TEST.log中

- 1）统计文件总行数（）

- 2）文件的共有（）列，并说明每列字段的含义，记录在m8.note.txt

- 3）统计第一列为A0.1_100的行数（）

- 4）提取第一列为A0.1_100且identity>=50的比对结果，定向输出到新的文件，命名为A0.1_100_iden50.m8

- 5）对A0.1_100_iden50.m8按照score值进行升序排序，输出到新文件A0.1_100_iden50.sort.m8

- 6）统计test.m8第一列不重复字段的个数，为（）个，并将所有不重复的字段输出到新文件，命名为uniq_id.list

- 7）软链/TJPROJ1/MICRO/wangpeng/NewTest/ linux_file/seq.len.xls到自己的目录下，并计算第二列的总和，为（）

- 8）根据uniq_id.list，筛选seq.len.xls文件，输出到新文件uniq_id.len.xls

- 9）根据片段长度>100<=500，筛选seq.len.xls文件，并降序输出到新文件sort.seq.len.xls

- 10）将sort.seq.len.xls第一列字段中所有的点（.）替换成’_test_’，输出到新文件sed.sort.seq.len.xls

- 11）将上述所有的运行命令记录在脚本work.sh中


---

## Perl编程

### 3. 编程题目需在02.Perl目录下完成
 
#### 3.1 将/TJPROJ1/MICRO/wangpeng/NewTest/perl_file/下的relative.k.xls和group.list拷贝到个人的02.Perl目录下

 说明：relative.k.xls为80个样本在Kingdom水平的相对丰度；group.list的第一列为样本名称（共20个），第二列为分组情况

- 1）写一个perl脚本，命名为select_mat.pl，根据group.list挑选relative.k.xls，输出文件为select_rela.k.xls，运行方式如下（但不限）
    
    ``` perl select_mat.pl group.list relative.k.xls > select_rela.k.xls ```


- 2）写一个perl脚本，命名为avg_stat.pl，根据分组信息group.list 对relative.k.xls中的数据按照组来算平均值和标准差（输出值”avg:sd”），输出文件为stat_group.rela.xls，运行方式如下（但不限）
    
    ```perl avg_stat.pl group.list relative.k.xls > stat_group.rela.xls ```
   
  输出如下
    
  Taxa | H2JCM | L1DCM
  :-: | :-: | :-: 
  k__Bacteria | 0.07246:0.11776 | 0.03174:0.01916
  k__Eukaryota | 0.00237:0.00098 | 0.00510:0.00129
  k__Archaea | 0.00000:0.00000 | 0.00000:0.00000
  Others | 0.92517:0.11776 | 0.96316:0.01864
 
 
#### 3.2 将/TJPROJ1/MICRO/wangpeng/NewTest/linux_file/下的test.m8和seq.len.xls拷贝到个人的02.Perl目录下

 说明：test.m8为比对结果文件，seq.len.xls为每条序列长度的统计文件
 
 - 写一个perl脚本，命名为screen.m8.pl按identity>=50，e-value<=10 x min_evalue且coverage>=60%对test.m8进行筛选，并输出两个文件，第一个新新文件命名为screen.out.m8，是筛选后的m8文件；第二个为新文件stat.m8.xls，为统计出每条序列比对得到的平均identity和平均coverage结果，运行方式如下（但不限）
   
   ```perl screen.m8.pl test.m8 seq.len.xls screen.out.m8 stat.m8.xls```

    - stat.m8.xls输出可以如下
    
ID | Subj	| Identity	| Coverage| E-value | Min_evalue
:-: | :-: | :-: | :-: | :-: | :-:
A0.1_100| SCI91766.1	| 30.5	| 1.52032520325203	| 3.3e-07| 1.7e-12|
A0.1_100|WP_055270727.1|95.0|0.317073170731707|1.7e-13|1.7e-12|
## 统计绘图

### 4. 统计绘图需在03.Statistics下完成

#### 4.1 将/TJPROJ1/MICRO/wangpeng/NewTest/test_stats下的两个文件” genus.mat.xls”（属丰度表）和” group.list”（样本分组表）拷贝到自己目录下，并回答下列问题

- 1）简述T-test和Wilcox test的异同点（将答案写到TEST.log中）。
    
- 2） 使用T-test或Wilcox test对genus.mat.xls中的每个物种进行组间差异检验，并校正p值得到q值，输出结果命名为“test.out.xls”，结果格式为“genus_id  diff_meanStatistics  p-value  q-value”。
    
- 3）针对2）中检验出的差异物种（如果qvalue无显著性，请按照pvalue筛选），进行箱线图的绘制。
    
    注：所写脚本命名为test.stat.R；绘图脚本命名为boxplot.R，可视化绘图可尝试使用ggplot2。结果文件可参考example文件夹下的test.result.xls和diff.taxa.boxplot.pdf
       
#### 4.2 将/TJPROJ1/MICRO/wangpeng/NewTest/correlation下的属丰度文件“genus.rela.xls”和环境因子文件“env.xls”拷贝到自己目录下，回答以下问题：

- 1）简述spearman相关系数和pearson相关系数的异同（将答案写到TEST.log中）。
    
- 2）对属和环境因子作spearman关联分析，得到相关系数矩阵和p值矩阵，输出文件名为“correlation.xls”和“pvalue.xls”
    
- 3）对相关系数矩阵进行热图绘制，并标注显著性，
    
    注：所写脚本命名为cor.stat.plot.R；计算相关系数时，不要进行p校正；计算相关系数可使用R包psych，热图绘制可使用pheatmap或ComplexHeatmap。结果文件可参考example下的correlation.xls、pvalue.xls和cor.heat.pdf
 
---

**<center> <font color=#1E90FF size=4.5> 将所有写的脚本的权限改成755 </font> </center>**


