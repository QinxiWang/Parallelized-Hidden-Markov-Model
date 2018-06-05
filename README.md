# Parallelized-Hidden-Markov-Model

Parallelizing the HMM Baum-Welch algorithm using openMP

The data we used is not included in this repo. We obtained our dataset from the KDD Cup 2010 Educational Data Mining Challenge[3]. The goal of the challenge was to predict student performance on particular skills based on their previous performance. The dataset contains 3310 students and 1378 skills. The data is formatted into 4 columns and 8.9 million lines where each line is a particular step in the solving process of a problem for a student. The first column contains a boolean 1 or 2 that determines if the student performed a step in the solving process correctly. The second column is a string that identifies a specific student. The third column is a unique identifier for a particular problem. The last column is an identifier for a particular step in solving that problem. Each step in a problem corresponds to a skill for the student.     

To run the algorithm, obtain the data first and run the script.sh file. We created the -k option to change the number of threads.

Challenge: the inherent dependencies between states in the hidden markov model - each state depends on the previous state, it impose technical challenge on parallelizing parts of the graph model as its fitted in a sequential fashion. We would lose model precision if we spread the model states over separate threads. However, we observed that the computation of transition and emission matrices between each state is independent, as the entries in the individual columns are independent of each other. Thus we can divide the computation work for calculating the individual entries in the matrices into multiple threads for better speedup performance. 

Alternative ways to parallelize HMM:

1. distribute workload over a small number of processors to reduce communication overhead between the processors. As each processor has to synchronize after each state iteration, their approach relies on the characterics that order does not matter in matrices multiplication. The data is then divided into a set of blocks that each process independently, and a master processor would multiply all the matrices that represent individual blocks from all the processors for a unified final result. 
2. applies a general “Cut-And-Stitch” parallel learning framework for training hidden Markov models. In each iteration, the “Cut” step would split the data equally to the number of threads specified, and the model into the same number of blocks that each train on the corresponding subpart of the data. Then in the “Stitch” step, each block would each collect the transition, emission, scoring statistics and other learning parameters from it neighbors, and all block would act together to update the model before entering into the next iteration.

Dataset: http://pslcdatashop.web.cmu.edu/KDDCup/

The original code can be found at: https://github.com/myudelson/hmm-scalable
