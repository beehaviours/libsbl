#include <dirent.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "sbl.h"

char filter_str[25] = { 0 };

int filter(const struct dirent *dir) {
	int r = strncmp(dir->d_name, filter_str, 20);
	return !r;
}


int sbl_find_video(char *filename, int module, int cam, int year,
		   int month, int day, int hour, int minute) {
	struct dirent **namelist;
	int n;

	snprintf(filter_str, 25, "M%02dC%02d_%4d%02d%02d_%02d%02d",
		 module, cam, year, month, day, hour, minute);

	n = scandir(".", &namelist, filter, alphasort);

	if (n == -1) {
		fprintf(stderr, "[find_sblv_file] Scandir Error\n");
		return -1;
	}

	if (n == 0) {
		return -1;
	}

	if (n > 1) {
		fprintf(stderr,
			"[find_sblv_file] File for this timestamp is not unique.\n");
		return -2;
	}

	filename = malloc(strlen(namelist[0]->d_name + 1));

	sprintf(filename, "%s", namelist[0]->d_name);

	free(namelist[0]);
	free(namelist);

	return 0;
}

void sbl_get_lib_version( int* major, int* minor, int* patch) {
	*major = VERSION_MAJOR ;
	*minor = VERSION_MINOR ;
	*patch = VERSION_PATCH ;
}
