// @Integer(label="Gaussian XY", value=3) g_xy
// @Integer(label="Gaussian Z", value=1) g_z

run("Gaussian Blur 3D...", "x="+g_xy+" y="+g_xy+" z="+g_z);
setBatchMode("hide");
setAutoThreshold("Li dark stack");
setOption("BlackBackground", true);
run("Convert to Mask", "method=Otsu background=Dark black");
run("3D OC Options", "volume surface nb_of_obj._voxels nb_of_surf._voxels integrated_density mean_gray_value std_dev_gray_value median_gray_value minimum_gray_value maximum_gray_value centroid mean_distance_to_surface std_dev_distance_to_surface median_distance_to_surface centre_of_mass bounding_box dots_size=5 font_size=10 white_numbers store_results_within_a_table_named_after_the_image_(macro_friendly) redirect_to=none");
run("3D Objects Counter", "threshold=128 slice=37 min.=10 max.=314572800 exclude_objects_on_edges objects");
run("glasbey_on_dark");
rename("labels");
labels_to_rois_4D("labels");
setBatchMode("exit and display");
run("To ROI Manager");
close("labels");


function labels_to_rois_4D(labelsTitle) {
    selectImage(labelsTitle);
    getDimensions(width, height, channels, slices, frames);
    getVoxelSize(v_width, v_height, v_depth, unit);
    Stack.getStatistics(voxelCount, mean, min, n_cells, stdDev);
    for(i=0; i<n_cells; i++) {
        showProgress(i+1, n_cells);
        setThreshold(i+1, i+1);
        for(t=1; t<=frames; t++) {
            Stack.setFrame(t);
            for(z = 1; z <= slices; z++) {
                Stack.setSlice(z);
                run("Create Selection");
                if(Roi.size > 0) {
                    Roi.setPosition(0, z, t);
                    Roi.setProperty("ROI", i+1);
                    Roi.setProperty("ROI_NAME", "Cell #" + i+1);
                    Roi.setName("Cell #" + i+1 + " (z=" + z + ", t=" + t + ")");
                    // Use ROI groups, but only up to 255
                    if(n_cells < 256) Roi.setGroup(i+1);
                    Overlay.addSelection();
                }
            }
        }
    }
}