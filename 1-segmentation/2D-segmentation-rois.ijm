run("Gaussian Blur...", "sigma=3");
setAutoThreshold("Otsu dark");
setOption("BlackBackground", true);
run("Convert to Mask");
run("Analyze Particles...", "add");
