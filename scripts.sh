echo "running away"
(for k in 1 2 4 8 12 16
do
  ./trainhmm -s 1.1 -m 1 -p 1 -P 1 -q 1 -k $k a89_kts_train.txt model.txt predict.txt
done) > output.csv
