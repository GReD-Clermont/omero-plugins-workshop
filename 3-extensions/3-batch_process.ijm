// @String(label="Username") USERNAME
// @String(label="Password", style='password') PASSWORD
// @String(label="Host", value='127.0.0.1') HOST
// @Integer(label="Port", value=4064) PORT
// @Integer(label="Dataset ID", value=1) dataset_id

macro_path = File.openDialog("Select a macro file");

run("OMERO Extensions");

connected = Ext.connectToOMERO(HOST, PORT, USERNAME, PASSWORD);

setBatchMode(true);
if(connected == "true") {
    images = Ext.list("images", "dataset", dataset_id);
    image_ids = split(images, ",");
    
    for(i=0; i<image_ids.length; i++) {
        ij_id = Ext.getImage(image_ids[i]);
        ij_id = parseInt(ij_id);
        roiManager("reset");
        runMacro(macro_path);
        nROIs = Ext.saveROIs(image_ids[i], "");
        print("Image " + image_ids[i] + ": " + nROIs + " ROI(s) saved.");
        roiManager("reset");
        close("Results");
        selectImage(ij_id);
        close();
    }
}
setBatchMode(false);

Ext.disconnect();
print("processing done");