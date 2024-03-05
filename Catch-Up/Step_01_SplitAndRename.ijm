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


	








 