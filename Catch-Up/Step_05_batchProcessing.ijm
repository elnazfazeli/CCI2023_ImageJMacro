/* 
 * NEUBIAS Academy
 * ImageJ/Fiji Macro Language
 * anna.klemm@it.uu.se - BioImage Informatics Facility @SciLifeLab
 * April 2020
 */

//batch processing
input_path = getDirectory("Choose image folder"); 
fileList = getFileList(input_path); 

for (f=0; f<fileList.length; f++){ //loops over all images in the given directory
	
	//clean-up to prepare for analysis
	roiManager("reset");	
	run("Close All");
	run("Clear Results");

	//open file
	open(input_path + fileList[f]);
	print(input_path + fileList[f]); //displays file that is processed

	//Step1: Getting image information + normalise the data name
	//get general information
	title = getTitle();
	

	//split channels and rename them
	run("Split Channels");
	selectImage("C1-"+title);
	rename("nuclei");
	selectImage("C2-"+title);
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
	num = getNumber("minimum size", 2000); //minimum particle size (px) for "Analyze particles..." command
	selectImage("nuclei");
	run("Analyze Particles...", "size=" + num + "-Infinity exclude add");  //add to ROI-Manager by running analyze particles
	
	
	//Step 4: Measure signal in nuclear envelope's boundaries and save the result
	run("Set Measurements...", "mean display redirect=None decimal=3"); //define the measurements
	selectImage("signal");
	roiManager("deselect");  //ensures that no ROI is selected
	roiManager("Measure");	//measures active ROI or - if no ROI is selected - all ROIs
	
	// Save results with specific name
	//saveAs("results", "C:/Users/Anna/Desktop/Neubias_output/Results.csv");
	saveAs("results", "C:/Users/Anna/Desktop/Neubias_output/" + title + "_results.xls");
	
		
} //closes loop over fileList


 