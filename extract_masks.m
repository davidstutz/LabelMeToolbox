% Extracts the mask of all annotations in folder HOMEIMAGES
%
% Assumes the annotations to be figure-segmentations.
%
% Steps:
% - Download annotations from.
% - Put all annotations in data/Annotations/users/<your-labelme-suer>/<your-labelme-folder>/.
%   (Can be extracted as downlaoded from LabelMe)
% - Put all images in data/users/<your-labelme-suer>/<your-labelme-folder>/.
%   (Can be extracted as downloaded from LabelMe)
% - Adapt below variables accordingly.
% - Run extract_masks.m.
% - Masks can be found in data/masks/

DATAFOLDER = 'data';
IMAGEFOLDER = 'users/davidstutz/boundingboxes'; % relative to DATAFOLDER
ANNOTATIONSFOLDER = 'Annotations/users/davidstutz/boundingboxes'; % relative to DATAFOLDER
MASKSFOLDER = 'Masks/users/davidstutz/boundingboxes'; % relative to DATAFOLDER
mkdir([DATAFOLDER '/' MASKSFOLDER]);

addpath 'main';
addpath 'XMLtools';

annotation_files = dir(sprintf('%s/%s/*.xml', DATAFOLDER, ANNOTATIONSFOLDER));
for annotation_file = annotation_files'
    [annotation, img] = LMread(sprintf('%s/%s/%s', DATAFOLDER, ANNOTATIONSFOLDER, annotation_file.name), DATAFOLDER);
    % Note that mask will be a logical matrix.
    [mask, class, maskpol, classpol] = LMobjectmask(annotation, DATAFOLDER);
    
    [pathstr, name, ext] = fileparts(annotation_file.name); 
    
    csvwrite(sprintf('%s/%s/%s.csv', DATAFOLDER, MASKSFOLDER, name), mask(:, :, size(mask, 3)));
end;