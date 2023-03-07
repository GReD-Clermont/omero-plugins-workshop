run("Set Measurements...", "area mean standard perimeter shape integrated median stack limit display redirect=None decimal=2");
roiManager("Measure");

getVoxelSize(voxWidth, voxHeight, voxDepth, unit);

group = Table.getColumn("Group");
Array.getStatistics(group, start_cell, n_cells, mean, stdDev);
cells_mean = newArray(n_cells - start_cell + 1);
n_pixels = newArray(n_cells - start_cell + 1);
volumes = newArray(n_cells - start_cell + 1);
cells = newArray(n_cells - start_cell + 1);
units = newArray(n_cells - start_cell + 1);

rawintden = Table.getColumn("RawIntDen");
mean = Table.getColumn("Mean");
for(i=0; i<group.length; i++) {
	cell = group[i] - start_cell;
	cells[cell] = group[i];
	n_pixels[cell] += rawintden[i] / mean[i];
	cells_mean[cell] += rawintden[i];
}

for(i=0; i<cells_mean.length; i++) {
	cells_mean[i] = cells_mean[i] / n_pixels[i] ;
	volumes[i] = n_pixels[i] * voxWidth * voxHeight * voxDepth;
	units[i] = unit + "^3";
}

close("Results");
Array.show("Results", cells, cells_mean, volumes, units);
Table.renameColumn("cells", "ROI");
Table.renameColumn("cells_mean", "Mean");
Table.renameColumn("volumes", "Volume");
Table.renameColumn("units", "Unit");