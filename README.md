## No-Reference Video Quality Assessment Using Natural Spatiotemporal Scene Statistics
You can find full access to our [paper](https://ieeexplore.ieee.org/abstract/document/9059006/) here.

### Citation: 
If you are using the code/model/data provided here in a publication, please cite our paper:
    
    @ARTICLE{9059006,
    author={S. V. {Reddy Dendi} and S. S. {Channappayya}},
    journal={IEEE Transactions on Image Processing},
    title={No-Reference Video Quality Assessment Using Natural Spatiotemporal Scene Statistics},
    year={2020},
    volume={29},
    number={},
    pages={5612-5624},}

This is a two-step approach i.e. spatiotemporal feature extraction followed by regression against subjective quality scores. To evaluate the performance of this approach on a given video quality assessment (VQA) dataset, we advise you to follow the following steps.

Step1: Feature extraction using functions in FeatureExtraction folder. 

       (i) 3D-MSCN features using SpatioTemporal_3DMSCN_Features.m
       (ii) Spatiotemporal Gabor filter based features using SpatioTemporal_I_Features.m and SpatioTemporal_Q_Features.m (both inphase and quadrature)
       
Step2: Performance evaluation using functions in PerformanceEvaluation folder.

       (i) VQA_using_3DMSCN.m evaluates the performance using only 3D-MSCN features.
       (ii) VQA_using_ST_features.m evaluates the performance using only spatiotemporal Gabor filter-based features.
       (ii) VQA_using_3DMSCN_and_ST_features.m evaluates the perfomance using 3D-MSCN and spatiotemporal Gabor filter based features.

Details about other folders.

       (i) videos: You can place videos here to extracts its features.
       (ii) src: contains 3D MSCN function, AGGD parameter estimate, and Gabor 3D Kernal.
       (iii) matlab_yuvread: contains functions to read .yuv videos.
       (iv) logistic fitting: Contain logistic regression function to find LCC and SRCC between objective and subjective scores.
