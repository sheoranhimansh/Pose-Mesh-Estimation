#scp rndscript.sh himansh@10.2.137.21:~/
#source env/bin/activate
module load cudnn/6-cuda-8.0
module load cuda/8.0 
module load ffmpeg/3.4 
cd keras_Realtime_Multi-Person_Pose_Estimation
#bash video_to_images.sh 5 
python 2d_pose_estimation.py
cd ..
bash hmr/3dpose_estimate.sh
cd keras_Realtime_Multi-Person_Pose_Estimation/sample_images
rm -rf *
cd ../sample_jsons 
rm -rf *
cd ../../
python convertimagestovideo.py 20
python convertimagestovideo1.py 20

