# Run: sbatch ./script.sh <path to video dir> 
# Note: If you have images see the comment near the end of the script 
python2.7 -m pip install --user virtualenv
python2.7 -m virtualenv env
source env/bin/activate
git clone https://github.com/Dene33/keras_Realtime_Multi-Person_Pose_Estimation.git
pip install configobj
git clone https://github.com/Dene33/hmr.git
wget https://people.eecs.berkeley.edu/~kanazawa/cachedir/hmr/models.tar.gz && tar -xf models.tar.gz
mv models hmr/
pip install numpy
pip2 install -r hmr/requirements.txt
mkdir hmr/output
mkdir hmr/output/csv
mkdir hmr/output/images
mkdir hmr/output/csv_joined
mkdir hmr/output/images/mesh
mkdir hmr/output/images/overlay
mkdir hmr/output/bvh_animation
mkdir hmr/output/smpl
cd keras_Realtime_Multi-Person_Pose_Estimation
bash model/get_keras_model.sh
mkdir sample_jsons
mkdir sample_videos
mkdir sample_images
cd ..
# Copy the following Files to Given Folders
cp 2d_pose_estimation.py ./keras_Realtime_Multi-Person_Pose_Estimation/
cp demo.py ./hmr/
pip2 install keras
pip2 install tensorflow-gpu==1.3.0
pip2 install pandas
# transfer videos to ./keras_Realtime_Multi-Person_Pose_Estimation/sample_videos/
cp $1/* ./keras_Realtime_Multi-Person_Pose_Estimation/sample_videos/
cd ./keras_Realtime_Multi-Person_Pose_Estimation/
bash video_to_images.sh 10
python2 2d_pose_estimation.py
# transfer images to ./keras_Realtime_Multi-Person_Pose_Estimation/sample_videos/
# cp $1/* ./keras_Realtime_Multi-Person_Pose_Estimation/sample_images/
cd ..
bash hmr/3dpose_estimate.sh
