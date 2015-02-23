% Extracts the mask of all annotations in folder HOMEIMAGES
%
% Assumes the annotations to be figure-segmentations.
%
% Steps:
% - Download annotations from.
% - Put all annotations in data/annotations/.
% - Put all images in data/users/<your-labelme-suer>/<your-labelme-folder>/.
% - Adapt below variables accordingly.
% - Run extract_masks.m.
% - Masks can be found in data/masks/

DATAFOLDER = 'data';
IMAGEFOLDER = 'users/davidstutz/boundingboxes'; % relative to DATAFOLDER
ANNOTATIONSFOLDER = 'annotations'; % relative to DATAFOLDER
MASKSFOLDER = 'masks'; % relative to DATAFOLDER

addpath 'main';
addpath 'XMLtools'

annotation_files = dir(sprintf('%s/%s/*.xml', DATAFOLDER, ANNOTATIONSFOLDER));
for annotation_file = annotation_files'
    [annotation, img] = LMread(sprintf('%s/%s/%s', DATAFOLDER, ANNOTATIONSFOLDER, annotation_file.name), DATAFOLDER);
    [mask, class, maskpol, classpol] = LMobjectmask(annotation, DATAFOLDER);
    
    [pathstr, name, ext] = fileparts(annotation_file.name); 
    imwrite(mask, sprintf('%s/%s/%s.png', DATAFOLDER, MASKSFOLDER, name));
end;