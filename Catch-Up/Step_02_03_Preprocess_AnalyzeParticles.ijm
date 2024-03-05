/* 
 * NEUBIAS Academy
 * ImageJ/Fiji Macro Language
 * anna.klemm@it.uu.se - BioImage Informatics Facility @SciLifeLab
 * Edited by Elnaz Fazeli
 * March 2024
 */

//Step1: Getting image information + Normalise the data name
//get general information
title = getTitle();
	
	
//split channels and rename them
run("Split Channels");
selectImage("C1-" + title);
rename("nuclei");
selectImage("C2-" + title);
rename("signal");

	
//Step2: Prefilter nuclear image and make binary image
selectImage("nuclei");
//preprocessing of the grayscale image
run("Median...", "radius=8");
//thresholding
setAutoThreshold("Huang dark");
setOption("BlackBackground", true);
run("Convert to Mask");
//postprocessing of binary image
run("Fill Holes");
	

//Step3: Retrieve the nuclei's boundaries
num = getNumber("minimum size", 2000 );
selectImage("nuclei");
run("Analyze Particles...", "size=" + num + "-Infinity exclude add");  //add to ROI-Manager by running analyze particles













 