// @String(label="Username") USERNAME
// @String(label="Password", style='password') PASSWORD
// @String(label="Host", value='127.0.0.1') HOST
// @Integer(label="Port", value=4064) PORT
// @Integer(label="Dataset ID", value=2) dataset_id

run("OMERO Extensions");

connected = Ext.connectToOMERO(HOST, PORT, USERNAME, PASSWORD);
tag_id = Ext.createTag("High", "");

setBatchMode(true);
if(connected == "true") {
    images = Ext.list("images", "dataset", dataset_id);
    image_ids = split(images, ",");
    
    for(i=0; i<image_ids.length; i++) {
        ij_id = Ext.getImage(image_ids[i]);
        getStatistics(area, mean, min, max, std, histogram);
        if(mean > 450) {
            Ext.link("tag", tag_id, "image", image_ids[i]);
        }
        close();
    }
}
setBatchMode(false);

Ext.disconnect();
print("processing done");