# SparseNetworkLocalization
Sparse network localization using only distance measurements

## 2020-05-22
## ycw@ruc.edu.cn

### Related work. The program is a part of our experiment in the following papers. 

1. Tianyuan Sun, Yongcai Wang, Deying Li, Zhaoquan Gu, Jia Xu:
WCS: Weighted Component Stitching for Sparse Network Localization. IEEE/ACM Trans. Netw. 26(5): 2242-2253 (2018)

2. 	Yongcai Wang, Tianyuan Sun, Guoyao Rao, Deying Li:
Formation Tracking in Sparse Airborne Networks. IEEE J. Sel. Areas Commun. 36(9): 2000-2014 (2018)


#introduction of the program

1. Generate a sparse network with partially measured internode distances. 
![Alt text](./result/network.jpg)


2. Initialized the network realization by AAAP

![Alt text](./result/aaapresult.jpg)

3. Use AAAPos as initialization result to run ARAP

![Alt text](./result/arapresult.jpg)

4. Use AAAP as initalization to run G2O

![Alt text](./result/g2oresult.jpg)

5. The localization performances under different sparsity and ranging noises can be measured. 

