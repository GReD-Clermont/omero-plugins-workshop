// @String(label="Username") USERNAME
// @String(label="Password", style='password') PASSWORD
// @String(label="Host", value='127.0.0.1') HOST
// @Integer(label="Port", value=4064) PORT

run("OMERO Extensions");

connected = Ext.connectToOMERO(HOST, PORT, USERNAME, PASSWORD);

projects = Ext.list("projects");
project_ids = split(projects,",");
project_names = newArray(project_ids.length);
project_names_ids = newArray(project_ids.length);
for (i = 0; i <project_ids.length; i++) {
	project_names_ids[i] = Ext.getName("project", project_ids[i]) + " (" + project_ids[i] + ")";
	project_names[i] = Ext.getName("project", project_ids[i]);
}

Dialog.create("Choose a project");
Dialog.addChoice("projects", project_names_ids);
Dialog.show();
chosen_project = replace(Dialog.getChoice(), ".+ \\(([0-9]+)\\)$", "$1");
print("Chosen project: " + chosen_project);

Ext.disconnect();