# Description of scripts used in master thesis

##Data mergin, clearing and completing - R script (main_DIP.R)
1. from date to date +/- days in past you want to extract information
2. from rectangle to rectangle (better from latitude/longtitude to latitude/longtitude) +/- extra area to extract information at border

##Generate numpy arrays - IPython notebook (preprocess_neighbour_arrays_DIP.ipynb)
1. Go throught rectangles
2. Go througth dates
3. Select surrounding in defined distance the day before

##Features selection - IPython notebook (crime_feature_selection_DIP.ipynb)
1. Load and select data
2. Join together with tm_data_complete datasest
3. Train tree model
5. Select the most important features
6. Save data

##Concate data and feature extraction - IPython notebook (concat_data_feature_extraction_pca_DIP)
1. Concate neigh, tm and database data together
2. Extract features using PCA and add them into dataset
3. Save new data

##Crime prediction - IPython notebook (h2o_crime_prediction_DIP.ipynb)
1. Create models (Deep learning, Random Forest, Gradient Boosting Machines)
2. Train models
3. Test models
4. Colect and visualize the results
5. Do it for various features
6. Compare all models and select best results

##Crime prediction - IPython notebook (CNN_crime_prediction_DIP.ipynb)
1. Create models
2. Train models
3. Test models
4. Colect and visualize the results

##Crime prediction - IPython notebook (RNN_crime_prediction_DIP.ipynb)
1. Create models
2. Train models
3. Test models
4. Colect and visualize the results

##Crime prediction - IPython notebook (CRNN_crime_prediction_DIP.ipynb)
1. Create models
2. Train models
3. Test models
4. Colect and visualize the results

##Extract features using CNN and CRNN - IPython notebook (CRNN_crime_feature_extraction_DIP.ipynb)
1. Train convolution net
2. Remove last layer
3. Generate feature vector for all data