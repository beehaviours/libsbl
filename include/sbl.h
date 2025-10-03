#ifndef SBL_H
#define SBL_H

#define ID_HIVE 			001
#define DEFAULT_DATA_PATH	"/beegfs/superbeelive_data"
#define SBL_SBLV_PATH 		"/raw_data/cam_videos"
#define SBL_WEBSERVER_PATH 	"/web_server"
#define SBL_VIDEO_PATH		"/videos"


void sbl_get_lib_version( int* major, int* minor, int* patch);

int sbl_find_video(char *filename, size_t size, int module, int cam, int year, int month, int day, int hour, int minute) ;

#endif

