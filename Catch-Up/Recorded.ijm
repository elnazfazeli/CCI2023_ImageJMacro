run("Split Channels");

selectImage("C1-711_D6_1.tif");
rename("nuclei");

selectImage("C2-711_D6_1.tif");
rename("signal");

selectImage("nuclei");
run("Median...", "radius=8");

setAutoThreshold("Huang dark no-reset");
setOption("BlackBackground", false);
run("Convert to Mask");
run("Fill Holes");

run("Analyze Particles...", "size=2000-Infinity exclude add");

run("Set Measurements...", "mean redirect=None decimal=3");
selectImage("signal");
roiManager("Select", 7);
run("Measure");


