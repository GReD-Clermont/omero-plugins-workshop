run("Gaussian Blur...", "sigma=3");
setAutoThreshold("Otsu dark");
setOption("BlackBackground", true);
run("Convert to Mask");
run("Analyze Particles...", "  show=[Count Masks]");
run("glasbey_on_dark");
run("Enhance Contrast", "saturated=0.35");
