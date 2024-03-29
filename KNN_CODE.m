function [trainedClassifier, validationAccuracy] = trainClassifier(trainingData)
% [trainedClassifier, validationAccuracy] = trainClassifier(trainingData)
% Returns a trained classifier and its accuracy. This code recreates the
% classification model trained in Classification Learner app. Use the
% generated code to automate training the same model with new data, or to
% learn how to programmatically train models.
%
%  Input:
%      trainingData: A table containing the same predictor and response
%       columns as those imported into the app.
%
%
%  Output:
%      trainedClassifier: A struct containing the trained classifier. The
%       struct contains various fields with information about the trained
%       classifier.
%
%      trainedClassifier.predictFcn: A function to make predictions on new
%       data.
%
%      validationAccuracy: A double representing the validation accuracy as
%       a percentage. In the app, the Models pane displays the validation
%       accuracy for each model.
%
% Use the code to train the model with new data. To retrain your
% classifier, call the function from the command line with your original
% data or new data as the input argument trainingData.
%
% For example, to retrain a classifier trained with the original data set
% T, enter:
%   [trainedClassifier, validationAccuracy] = trainClassifier(T)
%
% To make predictions with the returned 'trainedClassifier' on new data T2,
% use
%   [yfit,scores] = trainedClassifier.predictFcn(T2)
%
% T2 must be a table containing at least the same predictor columns as used
% during training. For details, enter:
%   trainedClassifier.HowToPredict

% Auto-generated by MATLAB on 18-Jul-2023 13:27:36


% Extract predictors and response
% This code processes the data into the right shape for training the
% model.
inputTable = trainingData;
predictorNames = {'x_Clostridium__innocuum_group', 'x_Eubacterium__brachy_group', 'x_Eubacterium__coprostanoligenes_group', 'x_Eubacterium__eligens_group', 'x_Eubacterium__fissicatena_group', 'x_Eubacterium__hallii_group', 'x_Eubacterium__nodatum_group', 'x_Eubacterium__rectale_group', 'x_Eubacterium__ruminantium_group', 'x_Eubacterium__ventriosum_group', 'x_Eubacterium__xylanophilum_group', 'x_Ruminococcus__gauvreauii_group', 'x_Ruminococcus__gnavus_group', 'x_Ruminococcus__torques_group', 'Abiotrophia', 'Acetanaerobacterium', 'Achromobacter', 'Acidaminococcus', 'Acidovorax', 'Acinetobacter', 'Actinomyces', 'Actinotalea', 'Adlercreutzia', 'Aerococcus', 'Aerosphaera', 'Akkermansia', 'Alistipes', 'Allisonella', 'Allobaculum', 'Alloprevotella', 'Alloscardovia', 'Ammoniphilus', 'Anaerococcus', 'Anaerofilum', 'Anaerofustis', 'Anaeroglobus', 'Anaerostipes', 'Anaerotruncus', 'Anaerovorax', 'Anoxybacillus', 'Atopobium', 'Azospirillum', 'Bacillus', 'Bacteroides', 'Barnesiella', 'Bergeyella', 'Bifidobacterium', 'Bilophila', 'Blastomonas', 'Blautia', 'Brevibacillus', 'Brevundimonas', 'Butyricicoccus', 'Butyricimonas', 'Butyrivibrio', 'Campylobacter', 'Candidatus_Odyssella', 'Candidatus_Saccharimonas', 'Candidatus_Soleaferrea', 'Candidatus_Stoquefichus', 'Capnocytophaga', 'Caproiciproducens', 'Cardiobacterium', 'Catabacter', 'Catenibacterium', 'Catonella', 'Cellulosilyticum', 'Cetobacterium', 'Christensenellaceae_R_7_group', 'Chryseobacterium', 'Cloacibacillus', 'Cloacibacterium', 'Clostridium_sensu_stricto_1', 'Clostridium_sensu_stricto_13', 'Clostridium_sensu_stricto_3', 'Collinsella', 'Comamona', 'Coprobacter', 'Coprococcus_1', 'Coprococcus_2', 'Coprococcus_3', 'Coriobacteriaceae_UCG_002', 'Corynebacterium', 'Cupriavidus', 'Dechlorobacter', 'Defluviitaleaceae_UCG_011', 'Deinococcus', 'Desulfomonile', 'Desulfovibrio', 'Dialister', 'Diaphorobacter', 'Dielma', 'Dorea', 'Dysgonomonas', 'Eggerthella', 'Eikenella', 'Eisenbergiella', 'Enhydrobacter', 'Enorma', 'Enterorhabdus', 'Enterovibrio', 'Epulopiscium', 'Erysipelatoclostridium', 'Erysipelothrix', 'Erysipelotrichaceae_UCG_003', 'Erysipelotrichaceae_UCG_004', 'Erysipelotrichaceae_UCG_006', 'Erysipelotrichaceae_UCG_010', 'Escherichia_Shigella', 'Eubacterium', 'Ezakiella', 'Faecalibacterium', 'Faecalibaculum', 'Faecalicoccus', 'Faecalitalea', 'Family_XIII_AD3011_group', 'Family_XIII_UCG_001', 'Fastidiosipila', 'Faucicola', 'Finegoldia', 'Flavonifractor', 'Fusicatenibacter', 'Fusobacterium', 'Gemella', 'Geobacter', 'Glutamicibacter', 'Gordonibacter', 'Granulicatella', 'Haemophilus', 'Halomonas', 'Halothiobacillus', 'Holdemanella', 'Holdemania', 'Howardella', 'Hungatella', 'Hydrogenoanaerobacterium', 'Intestinibacter', 'Intestinimonas', 'Johnsonella', 'Kitasatospora', 'Kurthia', 'Lachnoanaerobaculum', 'Lachnoclostridium', 'Lachnoclostridium_10', 'Lachnospira', 'Lachnospiraceae_FCS020_group', 'Lachnospiraceae_ND3007_group', 'Lachnospiraceae_NK4A136_group', 'Lachnospiraceae_UCG_001', 'Lachnospiraceae_UCG_003', 'Lachnospiraceae_UCG_004', 'Lachnospiraceae_UCG_006', 'Lachnospiraceae_UCG_008', 'Lachnospiraceae_UCG_010', 'Lacticigenium', 'Lactobacillus', 'Lactococcus', 'Lactonifactor', 'Lautropia', 'Lawsonella', 'Legionella', 'Lentimicrobium', 'Leuconostoc', 'Limnobacter', 'Marvinbryantia', 'Massilia', 'Megamonas', 'Megasphaera', 'Mesorhizobium', 'Methylobacterium', 'Methyloversatilis', 'Microbacterium', 'Mitsuokella', 'Mobiluncus', 'Mogibacterium', 'Morganella', 'Moryella', 'Mucispirillum', 'Murdochiella', 'Negativicoccus', 'Neisseria', 'Nevskia', 'Nocardioides', 'norank_c__Cyanobacteria', 'norank_c__Gammaproteobacteria', 'norank_f__Bacteroidales_S24_7_group', 'norank_f__Carnobacteriaceae', 'norank_f__Christensenellaceae', 'norank_f__Clostridiales_vadinBB60_group', 'norank_f__Coriobacteriaceae', 'norank_f__Erysipelotrichaceae', 'norank_f__Family_XI', 'norank_f__Family_XIII', 'norank_f__Flavobacteriaceae', 'norank_f__Geodermatophilaceae', 'norank_f__Halothiobacillaceae', 'norank_f__Lachnospiraceae', 'norank_f__Lentimicrobiaceae', 'norank_f__Mitochondria', 'norank_f__Moraxellaceae', 'norank_f__Neisseriaceae', 'norank_f__NS9_marine_group', 'norank_f__Peptococcaceae', 'norank_f__PHOS_HE36', 'norank_f__Porphyromonadaceae', 'norank_f__Prevotellaceae', 'norank_f__Rhodospirillaceae', 'norank_f__Ruminococcaceae', 'norank_f__Sphingomonadaceae', 'norank_f__vadinBE97', 'norank_f__Victivallaceae', 'norank_o__Bacteroidales', 'norank_o__Gastranaerophilales', 'norank_o__JG30_KF_CM45', 'norank_o__Mollicutes_RF9', 'norank_o__NB1_n', 'norank_o__Opitutae_vadinHA64', 'norank_p__Saccharibacteria', 'norank_p__SR1__Absconditabacteria_', 'Ochrobactrum', 'Odoribacter', 'Olsenella', 'Oribacterium', 'Oscillibacter', 'Oscillospira', 'Oxalobacter', 'Paeniclostridium', 'Pandoraea', 'Parabacteroides', 'Paracoccus', 'Paraeggerthella', 'Paraprevotella', 'Parasutterella', 'Parvibacter', 'Parvimonas', 'Peptoclostridium', 'Peptococcus', 'Peptoniphilus', 'Peptostreptococcus', 'Perlucidibaca', 'Petrimonas', 'Phascolarctobacterium', 'Phocaeicola', 'Porphyromonas', 'Prevotella', 'Prevotella_2', 'Prevotella_6', 'Prevotella_9', 'Prevotellaceae_NK3B31_group', 'Prevotellaceae_UCG_001', 'Prolixibacter', 'Propionibacterium', 'Proteus', 'Pseudoalteromonas', 'Pseudobutyrivibrio', 'Pseudomonas', 'Pseudoxanthomonas', 'Psychrobacter', 'Pyramidobacter', 'Ralstonia', 'Rhizobium', 'Rhodococcus', 'Rhodopseudomonas', 'Rikenella', 'Rikenellaceae_RC9_gut_group', 'Robinsoniella', 'Romboutsia', 'Roseburia', 'Rothia', 'Rubrobacter', 'Ruminiclostridium', 'Ruminiclostridium_1', 'Ruminiclostridium_5', 'Ruminiclostridium_6', 'Ruminiclostridium_9', 'Ruminococcaceae_NK4A214_group', 'Ruminococcaceae_UCG_002', 'Ruminococcaceae_UCG_003', 'Ruminococcaceae_UCG_004', 'Ruminococcaceae_UCG_005', 'Ruminococcaceae_UCG_008', 'Ruminococcaceae_UCG_009', 'Ruminococcaceae_UCG_010', 'Ruminococcaceae_UCG_013', 'Ruminococcaceae_UCG_014', 'Ruminococcus_1', 'Ruminococcus_2', 'Sarcina', 'Scardovia', 'Sedimentibacter', 'Selenomonas', 'Sellimonas', 'Senegalimassilia', 'Shewanella', 'Shuttleworthia', 'Slackia', 'Sneathia', 'Solobacterium', 'Sphaerochaeta', 'Sphingobacterium', 'Sphingomonas', 'Sphingopyxis', 'Staphylococcus', 'Stenotrophomonas', 'Stomatobaculum', 'Streptococcus', 'Subdoligranulum', 'Succinatimonas', 'Succiniclasticum', 'Sutterella', 'Taibaiella', 'Tannerella', 'Terrisporobacter', 'Thauera', 'Thermus', 'Thiomonas', 'Truepera', 'Turicibacter', 'Tyzzerella', 'Tyzzerella_3', 'Tyzzerella_4', 'unclassifiedSincePylum', 'Unclassified_Actinomycetaceae', 'unclassified_c__Clostridia', 'unclassified_f__Acetobacteraceae', 'unclassified_f__Bacillaceae', 'unclassified_f__Christensenellaceae', 'unclassified_f__Clostridiaceae_1', 'unclassified_f__Coriobacteriaceae', 'unclassified_f__Enterobacteriaceae', 'unclassified_f__Erysipelotrichaceae', 'unclassified_f__Family_XIII', 'unclassified_f__Flavobacteriaceae', 'unclassified_f__Gemmatimonadaceae', 'unclassified_f__Lachnospiraceae', 'unclassified_f__Porphyromonadaceae', 'unclassified_f__Prevotellaceae', 'unclassified_f__Rhodobacteraceae', 'unclassified_f__Rikenellaceae', 'unclassified_f__Ruminococcaceae', 'unclassified_f__Sphingomonadaceae', 'unclassified_f__Xanthomonadaceae', 'unclassified_o__Bacteroidales', 'unclassified_o__Burkholderiales', 'unclassified_o__Clostridiales', 'unclassified_o__Rhizobiales', 'unclassified_p__Bacteroidetes', 'unclassified_p__Firmicutes', 'unclassified_p__Proteobacteria', 'Uruburuella', 'Vagococcus', 'Varibaculum', 'Veillonella', 'Vibrio', 'Victivallis', 'Vulcaniibacterium', 'Weissella'};
predictors = inputTable(:, predictorNames);
response = inputTable.DIAGNOSIS;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];
classNames = {'ASD'; 'NT'};
costMatrix = [0 1.1; 1 0];

% Feature Ranking and Selection
% Replace Inf/-Inf values with NaN to prepare data for normalization
predictors = standardizeMissing(predictors, {Inf, -Inf});
% Normalize data for feature ranking
predictorMatrix = normalize(predictors, "DataVariable", ~isCategoricalPredictor);
newPredictorMatrix = zeros(size(predictorMatrix));
for i = 1:size(predictorMatrix, 2)
    if isCategoricalPredictor(i)
        newPredictorMatrix(:,i) = grp2idx(predictorMatrix{:,i});
    else
        newPredictorMatrix(:,i) = predictorMatrix{:,i};
    end
end
predictorMatrix = newPredictorMatrix;
responseVector = grp2idx(response);

% Rank features using Kruskal Wallis algorithm
for i = 1:size(predictorMatrix, 2)
    pValues(i) = kruskalwallis(...
        predictorMatrix(:,i), ...
        responseVector, ...
        'off');
end
[~,featureIndex] = sort(-log(pValues), 'descend');
numFeaturesToKeep = 23;
includedPredictorNames = predictors.Properties.VariableNames(featureIndex(1:numFeaturesToKeep));
predictors = predictors(:,includedPredictorNames);
isCategoricalPredictor = isCategoricalPredictor(featureIndex(1:numFeaturesToKeep));

% Train a classifier
% This code specifies all the classifier options and trains the classifier.
classificationKNN = fitcknn(...
    predictors, ...
    response, ...
    'Distance', 'Spearman', ...
    'Exponent', [], ...
    'NumNeighbors', 14, ...
    'DistanceWeight', 'SquaredInverse', ...
    'Standardize', false, ...
    'Cost', costMatrix, ...
    'ClassNames', classNames);

% Create the result struct with predict function
predictorExtractionFcn = @(t) t(:, predictorNames);
featureSelectionFcn = @(x) x(:,includedPredictorNames);
knnPredictFcn = @(x) predict(classificationKNN, x);
trainedClassifier.predictFcn = @(x) knnPredictFcn(featureSelectionFcn(predictorExtractionFcn(x)));

% Add additional fields to the result struct
trainedClassifier.RequiredVariables = {'Abiotrophia', 'Acetanaerobacterium', 'Achromobacter', 'Acidaminococcus', 'Acidovorax', 'Acinetobacter', 'Actinomyces', 'Actinotalea', 'Adlercreutzia', 'Aerococcus', 'Aerosphaera', 'Akkermansia', 'Alistipes', 'Allisonella', 'Allobaculum', 'Alloprevotella', 'Alloscardovia', 'Ammoniphilus', 'Anaerococcus', 'Anaerofilum', 'Anaerofustis', 'Anaeroglobus', 'Anaerostipes', 'Anaerotruncus', 'Anaerovorax', 'Anoxybacillus', 'Atopobium', 'Azospirillum', 'Bacillus', 'Bacteroides', 'Barnesiella', 'Bergeyella', 'Bifidobacterium', 'Bilophila', 'Blastomonas', 'Blautia', 'Brevibacillus', 'Brevundimonas', 'Butyricicoccus', 'Butyricimonas', 'Butyrivibrio', 'Campylobacter', 'Candidatus_Odyssella', 'Candidatus_Saccharimonas', 'Candidatus_Soleaferrea', 'Candidatus_Stoquefichus', 'Capnocytophaga', 'Caproiciproducens', 'Cardiobacterium', 'Catabacter', 'Catenibacterium', 'Catonella', 'Cellulosilyticum', 'Cetobacterium', 'Christensenellaceae_R_7_group', 'Chryseobacterium', 'Cloacibacillus', 'Cloacibacterium', 'Clostridium_sensu_stricto_1', 'Clostridium_sensu_stricto_13', 'Clostridium_sensu_stricto_3', 'Collinsella', 'Comamona', 'Coprobacter', 'Coprococcus_1', 'Coprococcus_2', 'Coprococcus_3', 'Coriobacteriaceae_UCG_002', 'Corynebacterium', 'Cupriavidus', 'Dechlorobacter', 'Defluviitaleaceae_UCG_011', 'Deinococcus', 'Desulfomonile', 'Desulfovibrio', 'Dialister', 'Diaphorobacter', 'Dielma', 'Dorea', 'Dysgonomonas', 'Eggerthella', 'Eikenella', 'Eisenbergiella', 'Enhydrobacter', 'Enorma', 'Enterorhabdus', 'Enterovibrio', 'Epulopiscium', 'Erysipelatoclostridium', 'Erysipelothrix', 'Erysipelotrichaceae_UCG_003', 'Erysipelotrichaceae_UCG_004', 'Erysipelotrichaceae_UCG_006', 'Erysipelotrichaceae_UCG_010', 'Escherichia_Shigella', 'Eubacterium', 'Ezakiella', 'Faecalibacterium', 'Faecalibaculum', 'Faecalicoccus', 'Faecalitalea', 'Family_XIII_AD3011_group', 'Family_XIII_UCG_001', 'Fastidiosipila', 'Faucicola', 'Finegoldia', 'Flavonifractor', 'Fusicatenibacter', 'Fusobacterium', 'Gemella', 'Geobacter', 'Glutamicibacter', 'Gordonibacter', 'Granulicatella', 'Haemophilus', 'Halomonas', 'Halothiobacillus', 'Holdemanella', 'Holdemania', 'Howardella', 'Hungatella', 'Hydrogenoanaerobacterium', 'Intestinibacter', 'Intestinimonas', 'Johnsonella', 'Kitasatospora', 'Kurthia', 'Lachnoanaerobaculum', 'Lachnoclostridium', 'Lachnoclostridium_10', 'Lachnospira', 'Lachnospiraceae_FCS020_group', 'Lachnospiraceae_ND3007_group', 'Lachnospiraceae_NK4A136_group', 'Lachnospiraceae_UCG_001', 'Lachnospiraceae_UCG_003', 'Lachnospiraceae_UCG_004', 'Lachnospiraceae_UCG_006', 'Lachnospiraceae_UCG_008', 'Lachnospiraceae_UCG_010', 'Lacticigenium', 'Lactobacillus', 'Lactococcus', 'Lactonifactor', 'Lautropia', 'Lawsonella', 'Legionella', 'Lentimicrobium', 'Leuconostoc', 'Limnobacter', 'Marvinbryantia', 'Massilia', 'Megamonas', 'Megasphaera', 'Mesorhizobium', 'Methylobacterium', 'Methyloversatilis', 'Microbacterium', 'Mitsuokella', 'Mobiluncus', 'Mogibacterium', 'Morganella', 'Moryella', 'Mucispirillum', 'Murdochiella', 'Negativicoccus', 'Neisseria', 'Nevskia', 'Nocardioides', 'Ochrobactrum', 'Odoribacter', 'Olsenella', 'Oribacterium', 'Oscillibacter', 'Oscillospira', 'Oxalobacter', 'Paeniclostridium', 'Pandoraea', 'Parabacteroides', 'Paracoccus', 'Paraeggerthella', 'Paraprevotella', 'Parasutterella', 'Parvibacter', 'Parvimonas', 'Peptoclostridium', 'Peptococcus', 'Peptoniphilus', 'Peptostreptococcus', 'Perlucidibaca', 'Petrimonas', 'Phascolarctobacterium', 'Phocaeicola', 'Porphyromonas', 'Prevotella', 'Prevotella_2', 'Prevotella_6', 'Prevotella_9', 'Prevotellaceae_NK3B31_group', 'Prevotellaceae_UCG_001', 'Prolixibacter', 'Propionibacterium', 'Proteus', 'Pseudoalteromonas', 'Pseudobutyrivibrio', 'Pseudomonas', 'Pseudoxanthomonas', 'Psychrobacter', 'Pyramidobacter', 'Ralstonia', 'Rhizobium', 'Rhodococcus', 'Rhodopseudomonas', 'Rikenella', 'Rikenellaceae_RC9_gut_group', 'Robinsoniella', 'Romboutsia', 'Roseburia', 'Rothia', 'Rubrobacter', 'Ruminiclostridium', 'Ruminiclostridium_1', 'Ruminiclostridium_5', 'Ruminiclostridium_6', 'Ruminiclostridium_9', 'Ruminococcaceae_NK4A214_group', 'Ruminococcaceae_UCG_002', 'Ruminococcaceae_UCG_003', 'Ruminococcaceae_UCG_004', 'Ruminococcaceae_UCG_005', 'Ruminococcaceae_UCG_008', 'Ruminococcaceae_UCG_009', 'Ruminococcaceae_UCG_010', 'Ruminococcaceae_UCG_013', 'Ruminococcaceae_UCG_014', 'Ruminococcus_1', 'Ruminococcus_2', 'Sarcina', 'Scardovia', 'Sedimentibacter', 'Selenomonas', 'Sellimonas', 'Senegalimassilia', 'Shewanella', 'Shuttleworthia', 'Slackia', 'Sneathia', 'Solobacterium', 'Sphaerochaeta', 'Sphingobacterium', 'Sphingomonas', 'Sphingopyxis', 'Staphylococcus', 'Stenotrophomonas', 'Stomatobaculum', 'Streptococcus', 'Subdoligranulum', 'Succinatimonas', 'Succiniclasticum', 'Sutterella', 'Taibaiella', 'Tannerella', 'Terrisporobacter', 'Thauera', 'Thermus', 'Thiomonas', 'Truepera', 'Turicibacter', 'Tyzzerella', 'Tyzzerella_3', 'Tyzzerella_4', 'Unclassified_Actinomycetaceae', 'Uruburuella', 'Vagococcus', 'Varibaculum', 'Veillonella', 'Vibrio', 'Victivallis', 'Vulcaniibacterium', 'Weissella', 'norank_c__Cyanobacteria', 'norank_c__Gammaproteobacteria', 'norank_f__Bacteroidales_S24_7_group', 'norank_f__Carnobacteriaceae', 'norank_f__Christensenellaceae', 'norank_f__Clostridiales_vadinBB60_group', 'norank_f__Coriobacteriaceae', 'norank_f__Erysipelotrichaceae', 'norank_f__Family_XI', 'norank_f__Family_XIII', 'norank_f__Flavobacteriaceae', 'norank_f__Geodermatophilaceae', 'norank_f__Halothiobacillaceae', 'norank_f__Lachnospiraceae', 'norank_f__Lentimicrobiaceae', 'norank_f__Mitochondria', 'norank_f__Moraxellaceae', 'norank_f__NS9_marine_group', 'norank_f__Neisseriaceae', 'norank_f__PHOS_HE36', 'norank_f__Peptococcaceae', 'norank_f__Porphyromonadaceae', 'norank_f__Prevotellaceae', 'norank_f__Rhodospirillaceae', 'norank_f__Ruminococcaceae', 'norank_f__Sphingomonadaceae', 'norank_f__Victivallaceae', 'norank_f__vadinBE97', 'norank_o__Bacteroidales', 'norank_o__Gastranaerophilales', 'norank_o__JG30_KF_CM45', 'norank_o__Mollicutes_RF9', 'norank_o__NB1_n', 'norank_o__Opitutae_vadinHA64', 'norank_p__SR1__Absconditabacteria_', 'norank_p__Saccharibacteria', 'unclassifiedSincePylum', 'unclassified_c__Clostridia', 'unclassified_f__Acetobacteraceae', 'unclassified_f__Bacillaceae', 'unclassified_f__Christensenellaceae', 'unclassified_f__Clostridiaceae_1', 'unclassified_f__Coriobacteriaceae', 'unclassified_f__Enterobacteriaceae', 'unclassified_f__Erysipelotrichaceae', 'unclassified_f__Family_XIII', 'unclassified_f__Flavobacteriaceae', 'unclassified_f__Gemmatimonadaceae', 'unclassified_f__Lachnospiraceae', 'unclassified_f__Porphyromonadaceae', 'unclassified_f__Prevotellaceae', 'unclassified_f__Rhodobacteraceae', 'unclassified_f__Rikenellaceae', 'unclassified_f__Ruminococcaceae', 'unclassified_f__Sphingomonadaceae', 'unclassified_f__Xanthomonadaceae', 'unclassified_o__Bacteroidales', 'unclassified_o__Burkholderiales', 'unclassified_o__Clostridiales', 'unclassified_o__Rhizobiales', 'unclassified_p__Bacteroidetes', 'unclassified_p__Firmicutes', 'unclassified_p__Proteobacteria', 'x_Clostridium__innocuum_group', 'x_Eubacterium__brachy_group', 'x_Eubacterium__coprostanoligenes_group', 'x_Eubacterium__eligens_group', 'x_Eubacterium__fissicatena_group', 'x_Eubacterium__hallii_group', 'x_Eubacterium__nodatum_group', 'x_Eubacterium__rectale_group', 'x_Eubacterium__ruminantium_group', 'x_Eubacterium__ventriosum_group', 'x_Eubacterium__xylanophilum_group', 'x_Ruminococcus__gauvreauii_group', 'x_Ruminococcus__gnavus_group', 'x_Ruminococcus__torques_group'};
trainedClassifier.ClassificationKNN = classificationKNN;
trainedClassifier.About = 'This struct is a trained model exported from Classification Learner R2023a.';
trainedClassifier.HowToPredict = sprintf('To make predictions on a new table, T, use: \n  [yfit,scores] = c.predictFcn(T) \nreplacing ''c'' with the name of the variable that is this struct, e.g. ''trainedModel''. \n \nThe table, T, must contain the variables returned by: \n  c.RequiredVariables \nVariable formats (e.g. matrix/vector, datatype) must match the original training data. \nAdditional variables are ignored. \n \nFor more information, see <a href="matlab:helpview(fullfile(docroot, ''stats'', ''stats.map''), ''appclassification_exportmodeltoworkspace'')">How to predict using an exported model</a>.');

% Extract predictors and response
% This code processes the data into the right shape for training the
% model.
inputTable = trainingData;
predictorNames = {'x_Clostridium__innocuum_group', 'x_Eubacterium__brachy_group', 'x_Eubacterium__coprostanoligenes_group', 'x_Eubacterium__eligens_group', 'x_Eubacterium__fissicatena_group', 'x_Eubacterium__hallii_group', 'x_Eubacterium__nodatum_group', 'x_Eubacterium__rectale_group', 'x_Eubacterium__ruminantium_group', 'x_Eubacterium__ventriosum_group', 'x_Eubacterium__xylanophilum_group', 'x_Ruminococcus__gauvreauii_group', 'x_Ruminococcus__gnavus_group', 'x_Ruminococcus__torques_group', 'Abiotrophia', 'Acetanaerobacterium', 'Achromobacter', 'Acidaminococcus', 'Acidovorax', 'Acinetobacter', 'Actinomyces', 'Actinotalea', 'Adlercreutzia', 'Aerococcus', 'Aerosphaera', 'Akkermansia', 'Alistipes', 'Allisonella', 'Allobaculum', 'Alloprevotella', 'Alloscardovia', 'Ammoniphilus', 'Anaerococcus', 'Anaerofilum', 'Anaerofustis', 'Anaeroglobus', 'Anaerostipes', 'Anaerotruncus', 'Anaerovorax', 'Anoxybacillus', 'Atopobium', 'Azospirillum', 'Bacillus', 'Bacteroides', 'Barnesiella', 'Bergeyella', 'Bifidobacterium', 'Bilophila', 'Blastomonas', 'Blautia', 'Brevibacillus', 'Brevundimonas', 'Butyricicoccus', 'Butyricimonas', 'Butyrivibrio', 'Campylobacter', 'Candidatus_Odyssella', 'Candidatus_Saccharimonas', 'Candidatus_Soleaferrea', 'Candidatus_Stoquefichus', 'Capnocytophaga', 'Caproiciproducens', 'Cardiobacterium', 'Catabacter', 'Catenibacterium', 'Catonella', 'Cellulosilyticum', 'Cetobacterium', 'Christensenellaceae_R_7_group', 'Chryseobacterium', 'Cloacibacillus', 'Cloacibacterium', 'Clostridium_sensu_stricto_1', 'Clostridium_sensu_stricto_13', 'Clostridium_sensu_stricto_3', 'Collinsella', 'Comamona', 'Coprobacter', 'Coprococcus_1', 'Coprococcus_2', 'Coprococcus_3', 'Coriobacteriaceae_UCG_002', 'Corynebacterium', 'Cupriavidus', 'Dechlorobacter', 'Defluviitaleaceae_UCG_011', 'Deinococcus', 'Desulfomonile', 'Desulfovibrio', 'Dialister', 'Diaphorobacter', 'Dielma', 'Dorea', 'Dysgonomonas', 'Eggerthella', 'Eikenella', 'Eisenbergiella', 'Enhydrobacter', 'Enorma', 'Enterorhabdus', 'Enterovibrio', 'Epulopiscium', 'Erysipelatoclostridium', 'Erysipelothrix', 'Erysipelotrichaceae_UCG_003', 'Erysipelotrichaceae_UCG_004', 'Erysipelotrichaceae_UCG_006', 'Erysipelotrichaceae_UCG_010', 'Escherichia_Shigella', 'Eubacterium', 'Ezakiella', 'Faecalibacterium', 'Faecalibaculum', 'Faecalicoccus', 'Faecalitalea', 'Family_XIII_AD3011_group', 'Family_XIII_UCG_001', 'Fastidiosipila', 'Faucicola', 'Finegoldia', 'Flavonifractor', 'Fusicatenibacter', 'Fusobacterium', 'Gemella', 'Geobacter', 'Glutamicibacter', 'Gordonibacter', 'Granulicatella', 'Haemophilus', 'Halomonas', 'Halothiobacillus', 'Holdemanella', 'Holdemania', 'Howardella', 'Hungatella', 'Hydrogenoanaerobacterium', 'Intestinibacter', 'Intestinimonas', 'Johnsonella', 'Kitasatospora', 'Kurthia', 'Lachnoanaerobaculum', 'Lachnoclostridium', 'Lachnoclostridium_10', 'Lachnospira', 'Lachnospiraceae_FCS020_group', 'Lachnospiraceae_ND3007_group', 'Lachnospiraceae_NK4A136_group', 'Lachnospiraceae_UCG_001', 'Lachnospiraceae_UCG_003', 'Lachnospiraceae_UCG_004', 'Lachnospiraceae_UCG_006', 'Lachnospiraceae_UCG_008', 'Lachnospiraceae_UCG_010', 'Lacticigenium', 'Lactobacillus', 'Lactococcus', 'Lactonifactor', 'Lautropia', 'Lawsonella', 'Legionella', 'Lentimicrobium', 'Leuconostoc', 'Limnobacter', 'Marvinbryantia', 'Massilia', 'Megamonas', 'Megasphaera', 'Mesorhizobium', 'Methylobacterium', 'Methyloversatilis', 'Microbacterium', 'Mitsuokella', 'Mobiluncus', 'Mogibacterium', 'Morganella', 'Moryella', 'Mucispirillum', 'Murdochiella', 'Negativicoccus', 'Neisseria', 'Nevskia', 'Nocardioides', 'norank_c__Cyanobacteria', 'norank_c__Gammaproteobacteria', 'norank_f__Bacteroidales_S24_7_group', 'norank_f__Carnobacteriaceae', 'norank_f__Christensenellaceae', 'norank_f__Clostridiales_vadinBB60_group', 'norank_f__Coriobacteriaceae', 'norank_f__Erysipelotrichaceae', 'norank_f__Family_XI', 'norank_f__Family_XIII', 'norank_f__Flavobacteriaceae', 'norank_f__Geodermatophilaceae', 'norank_f__Halothiobacillaceae', 'norank_f__Lachnospiraceae', 'norank_f__Lentimicrobiaceae', 'norank_f__Mitochondria', 'norank_f__Moraxellaceae', 'norank_f__Neisseriaceae', 'norank_f__NS9_marine_group', 'norank_f__Peptococcaceae', 'norank_f__PHOS_HE36', 'norank_f__Porphyromonadaceae', 'norank_f__Prevotellaceae', 'norank_f__Rhodospirillaceae', 'norank_f__Ruminococcaceae', 'norank_f__Sphingomonadaceae', 'norank_f__vadinBE97', 'norank_f__Victivallaceae', 'norank_o__Bacteroidales', 'norank_o__Gastranaerophilales', 'norank_o__JG30_KF_CM45', 'norank_o__Mollicutes_RF9', 'norank_o__NB1_n', 'norank_o__Opitutae_vadinHA64', 'norank_p__Saccharibacteria', 'norank_p__SR1__Absconditabacteria_', 'Ochrobactrum', 'Odoribacter', 'Olsenella', 'Oribacterium', 'Oscillibacter', 'Oscillospira', 'Oxalobacter', 'Paeniclostridium', 'Pandoraea', 'Parabacteroides', 'Paracoccus', 'Paraeggerthella', 'Paraprevotella', 'Parasutterella', 'Parvibacter', 'Parvimonas', 'Peptoclostridium', 'Peptococcus', 'Peptoniphilus', 'Peptostreptococcus', 'Perlucidibaca', 'Petrimonas', 'Phascolarctobacterium', 'Phocaeicola', 'Porphyromonas', 'Prevotella', 'Prevotella_2', 'Prevotella_6', 'Prevotella_9', 'Prevotellaceae_NK3B31_group', 'Prevotellaceae_UCG_001', 'Prolixibacter', 'Propionibacterium', 'Proteus', 'Pseudoalteromonas', 'Pseudobutyrivibrio', 'Pseudomonas', 'Pseudoxanthomonas', 'Psychrobacter', 'Pyramidobacter', 'Ralstonia', 'Rhizobium', 'Rhodococcus', 'Rhodopseudomonas', 'Rikenella', 'Rikenellaceae_RC9_gut_group', 'Robinsoniella', 'Romboutsia', 'Roseburia', 'Rothia', 'Rubrobacter', 'Ruminiclostridium', 'Ruminiclostridium_1', 'Ruminiclostridium_5', 'Ruminiclostridium_6', 'Ruminiclostridium_9', 'Ruminococcaceae_NK4A214_group', 'Ruminococcaceae_UCG_002', 'Ruminococcaceae_UCG_003', 'Ruminococcaceae_UCG_004', 'Ruminococcaceae_UCG_005', 'Ruminococcaceae_UCG_008', 'Ruminococcaceae_UCG_009', 'Ruminococcaceae_UCG_010', 'Ruminococcaceae_UCG_013', 'Ruminococcaceae_UCG_014', 'Ruminococcus_1', 'Ruminococcus_2', 'Sarcina', 'Scardovia', 'Sedimentibacter', 'Selenomonas', 'Sellimonas', 'Senegalimassilia', 'Shewanella', 'Shuttleworthia', 'Slackia', 'Sneathia', 'Solobacterium', 'Sphaerochaeta', 'Sphingobacterium', 'Sphingomonas', 'Sphingopyxis', 'Staphylococcus', 'Stenotrophomonas', 'Stomatobaculum', 'Streptococcus', 'Subdoligranulum', 'Succinatimonas', 'Succiniclasticum', 'Sutterella', 'Taibaiella', 'Tannerella', 'Terrisporobacter', 'Thauera', 'Thermus', 'Thiomonas', 'Truepera', 'Turicibacter', 'Tyzzerella', 'Tyzzerella_3', 'Tyzzerella_4', 'unclassifiedSincePylum', 'Unclassified_Actinomycetaceae', 'unclassified_c__Clostridia', 'unclassified_f__Acetobacteraceae', 'unclassified_f__Bacillaceae', 'unclassified_f__Christensenellaceae', 'unclassified_f__Clostridiaceae_1', 'unclassified_f__Coriobacteriaceae', 'unclassified_f__Enterobacteriaceae', 'unclassified_f__Erysipelotrichaceae', 'unclassified_f__Family_XIII', 'unclassified_f__Flavobacteriaceae', 'unclassified_f__Gemmatimonadaceae', 'unclassified_f__Lachnospiraceae', 'unclassified_f__Porphyromonadaceae', 'unclassified_f__Prevotellaceae', 'unclassified_f__Rhodobacteraceae', 'unclassified_f__Rikenellaceae', 'unclassified_f__Ruminococcaceae', 'unclassified_f__Sphingomonadaceae', 'unclassified_f__Xanthomonadaceae', 'unclassified_o__Bacteroidales', 'unclassified_o__Burkholderiales', 'unclassified_o__Clostridiales', 'unclassified_o__Rhizobiales', 'unclassified_p__Bacteroidetes', 'unclassified_p__Firmicutes', 'unclassified_p__Proteobacteria', 'Uruburuella', 'Vagococcus', 'Varibaculum', 'Veillonella', 'Vibrio', 'Victivallis', 'Vulcaniibacterium', 'Weissella'};
predictors = inputTable(:, predictorNames);
response = inputTable.DIAGNOSIS;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];
classNames = {'ASD'; 'NT'};
costMatrix = [0 1.1; 1 0];

% Perform cross-validation
KFolds = 10;
cvp = cvpartition(response, 'KFold', KFolds);
% Initialize the predictions to the proper sizes
validationPredictions = response;
numObservations = size(predictors, 1);
numClasses = 2;
validationScores = NaN(numObservations, numClasses);
for fold = 1:KFolds
    trainingPredictors = predictors(cvp.training(fold), :);
    trainingResponse = response(cvp.training(fold), :);
    foldIsCategoricalPredictor = isCategoricalPredictor;

    % Feature Ranking and Selection
    % Replace Inf/-Inf values with NaN to prepare data for normalization
    trainingPredictors = standardizeMissing(trainingPredictors, {Inf, -Inf});
    % Normalize data for feature ranking
    predictorMatrix = normalize(trainingPredictors, "DataVariable", ~foldIsCategoricalPredictor);
    newPredictorMatrix = zeros(size(predictorMatrix));
    for i = 1:size(predictorMatrix, 2)
        if foldIsCategoricalPredictor(i)
            newPredictorMatrix(:,i) = grp2idx(predictorMatrix{:,i});
        else
            newPredictorMatrix(:,i) = predictorMatrix{:,i};
        end
    end
    predictorMatrix = newPredictorMatrix;
    responseVector = grp2idx(trainingResponse);

    % Rank features using Kruskal Wallis algorithm
    for i = 1:size(predictorMatrix, 2)
        pValues(i) = kruskalwallis(...
            predictorMatrix(:,i), ...
            responseVector, ...
            'off');
    end
    [~,featureIndex] = sort(-log(pValues), 'descend');
    numFeaturesToKeep = 23;
    includedPredictorNames = trainingPredictors.Properties.VariableNames(featureIndex(1:numFeaturesToKeep));
    trainingPredictors = trainingPredictors(:,includedPredictorNames);
    foldIsCategoricalPredictor = foldIsCategoricalPredictor(featureIndex(1:numFeaturesToKeep));

    % Train a classifier
    % This code specifies all the classifier options and trains the classifier.
    classificationKNN = fitcknn(...
        trainingPredictors, ...
        trainingResponse, ...
        'Distance', 'Spearman', ...
        'Exponent', [], ...
        'NumNeighbors', 14, ...
        'DistanceWeight', 'SquaredInverse', ...
        'Standardize', false, ...
        'Cost', costMatrix, ...
        'ClassNames', classNames);

    % Create the result struct with predict function
    featureSelectionFcn = @(x) x(:,includedPredictorNames);
    knnPredictFcn = @(x) predict(classificationKNN, x);
    validationPredictFcn = @(x) knnPredictFcn(featureSelectionFcn(x));

    % Add additional fields to the result struct

    % Compute validation predictions
    validationPredictors = predictors(cvp.test(fold), :);
    [foldPredictions, foldScores] = validationPredictFcn(validationPredictors);

    % Store predictions in the original order
    validationPredictions(cvp.test(fold), :) = foldPredictions;
    validationScores(cvp.test(fold), :) = foldScores;
end

% Compute validation accuracy
correctPredictions = strcmp( strtrim(validationPredictions), strtrim(response));
isMissing = cellfun(@(x) all(isspace(x)), response, 'UniformOutput', true);
correctPredictions = correctPredictions(~isMissing);
validationAccuracy = sum(correctPredictions)/length(correctPredictions);