module fat;

alias FDIR = uint;
alias TCHAR = ubyte;
alias BYTE = ubyte;
alias UINT = uint;
alias FSIZE_t = uint;
alias WORD = ushort;
alias DWORD = uint;

enum FF_MIN_SS = 512;
enum FF_MAX_SS = 512;
enum FR_OK = 0;

/** Filesystem object structure (FATFS) */
struct FATFS
{
	BYTE fs_type; /** Filesystem type (0:not mounted) */
	BYTE pdrv; /** Associated physical drive */
	BYTE n_fats; /** Number of FATs (1 or 2) */
	BYTE wflag; /** win[] flag (b0:dirty) */
	BYTE fsi_flag; /** FSINFO flags (b7:disabled, b0:dirty) */
	WORD id; /** Volume mount ID */
	WORD n_rootdir; /** Number of root directory entries (FAT12/16) */
	WORD csize; /** Cluster size [sectors] */
	DWORD n_fatent; /** Number of FAT entries (number of clusters + 2) */
	DWORD fsize; /** Size of an FAT [sectors] */
	DWORD volbase; /** Volume base sector */
	DWORD fatbase; /** FAT base sector */
	DWORD dirbase; /** Root directory base sector/cluster */
	DWORD database; /** Data base sector */
	DWORD winsect; /** Current sector appearing in the win[] */
	BYTE[FF_MAX_SS] win; /** Disk access window for Directory, FAT (and file data at tiny cfg) */
}

/** Object ID and allocation information (FFOBJID) */
struct FFOBJID
{
	FATFS* fs; /** Pointer to the hosting volume of this object */
	WORD id; /** Hosting volume mount ID */
	BYTE attr; /** Object attribute */
	BYTE stat; /** Object chain status (b1-0: =0:not contiguous, =2:contiguous, =3:fragmented in this session, b2:sub-directory stretched) */
	DWORD sclust; /** Object data start cluster (0:no cluster or root directory) */
	FSIZE_t objsize; /** Object size (valid when sclust != 0) */
}

/** File object structure (FIL) */
struct FIL
{
	FFOBJID obj; /** Object identifier (must be the 1st member to detect invalid object pointer) */
	BYTE flag; /** File status flags */
	BYTE err; /** Abort flag (error code) */
	FSIZE_t fptr; /** File read/write pointer (Zeroed on file open) */
	DWORD clust; /** Current cluster of fpter (invalid when fptr is 0) */
	DWORD sect; /** Sector number appearing in buf[] (0:invalid) */
	BYTE[512] buf; /** File private data read/write window */
}

/** Directory object structure (DIR) */
struct DIR
{
	FFOBJID obj; /** Object identifier */
	DWORD dptr; /** Current read/write offset */
	DWORD clust; /** Current cluster */
	DWORD sect; /** Current sector (0:Read operation has terminated) */
	BYTE* dir; /** Pointer to the directory item in the win[] */
	BYTE[12] fn; /** SFN (in/out) {body[8],ext[3],status[1]} */
}

/** File information structure (FILINFO) */
struct FILINFO
{
	FSIZE_t fsize; /** File size */
	WORD fdate; /** Modified date */
	WORD ftime; /** Modified time */
	BYTE fattrib; /** File attribute */
	TCHAR[12 + 1] fname; /** File name */
}

/** File function return code (FRESULT) */
enum FRESULT
{
	FR_OK = 0, /** (0) Succeeded */
	FR_DISK_ERR, /** (1) A hard error occurred in the low level disk I/O layer */
	FR_INT_ERR, /** (2) Assertion failed */
	FR_NOT_READY, /** (3) The physical drive cannot work */
	FR_NO_FILE, /** (4) Could not find the file */
	FR_NO_PATH, /** (5) Could not find the path */
	FR_INVALID_NAME, /** (6) The path name format is invalid */
	FR_DENIED, /** (7) Access denied due to prohibited access or directory full */
	FR_EXIST, /** (8) Access denied due to prohibited access */
	FR_INVALID_OBJECT, /** (9) The file/directory object is invalid */
	FR_WRITE_PROTECTED, /** (10) The physical drive is write protected */
	FR_INVALID_DRIVE, /** (11) The logical drive number is invalid */
	FR_NOT_ENABLED, /** (12) The volume has no work area */
	FR_NO_FILESYSTEM, /** (13) There is no valid FAT volume */
	FR_MKFS_ABORTED, /** (14) The f_mkfs() aborted due to any problem */
	FR_TIMEOUT, /** (15) Could not get a grant to access the volume within defined period */
	FR_LOCKED, /** (16) The operation is rejected according to the file sharing policy */
	FR_NOT_ENOUGH_CORE, /** (17) LFN working buffer could not be allocated */
	FR_TOO_MANY_OPEN_FILES, /** (18) Number of open files > FF_FS_LOCK */
	FR_INVALID_PARAMETER /** (19) Given parameter is invalid */
}

/** File access mode and open method flags (3rd argument of f_open) */
enum FA_READ = 0x01;
enum FA_WRITE = 0x02;
enum FA_OPEN_EXISTING = 0x00;
enum FA_CREATE_NEW = 0x04;
enum FA_CREATE_ALWAYS = 0x08;
enum FA_OPEN_ALWAYS = 0x10;
enum FA_OPEN_APPEND = 0x30;

pragma(mangle, "f_open") extern (C) FRESULT open(FIL* fp, immutable(char)* path, BYTE mode); /** Open or create a file */
pragma(mangle, "f_close") extern (C) FRESULT close(FIL* fp); /** Close an open file object */
pragma(mangle, "f_read") extern (C) FRESULT read(FIL* fp, void* buff, UINT btr, UINT* br); /** Read data from the file */
//FRESULT f_write (FIL* fp, const(void)* buff, UINT btw, UINT* bw);	/** Write data to the file */
pragma(mangle, "f_lseek") extern (C) FRESULT lseek(FIL* fp, FSIZE_t ofs); /** Move file pointer of the file object */
//extern(C) FRESULT f_truncate (FIL* fp);										/** Truncate the file */
//extern(C) FRESULT f_sync (FIL* fp);											/** Flush cached data of the writing file */
pragma(mangle, "f_opendir") extern (C) FRESULT opendir(DIR* dp, immutable(char)* path); /** Open a directory */
pragma(mangle, "f_closedir") extern (C) FRESULT closedir(DIR* dp); /** Close an open directory */
pragma(mangle, "f_readdir") extern (C) FRESULT readdir(DIR* dp, FILINFO* fno); /** Read a directory item */
//extern(C) FRESULT f_findfirst (DIR* dp, FILINFO* fno, const(TCHAR)* path, const(TCHAR)* pattern);	/** Find first file */
//extern(C) FRESULT f_findnext (DIR* dp, FILINFO* fno);							/** Find next file */
//FRESULT f_mkdir (const TCHAR* path);								/** Create a sub directory */
//FRESULT f_unlink (const TCHAR* path);								/** Delete an existing file or directory */
//FRESULT f_rename (const TCHAR* path_old, const TCHAR* path_new);	/** Rename/Move a file or directory */
pragma(mangle, "f_stat") extern (C) FRESULT stat(const TCHAR* path, FILINFO* fno); /** Get file status */
//extern(C) FRESULT f_chmod (const TCHAR* path, BYTE attr, BYTE mask);			/** Change attribute of a file/dir */
//extern(C) FRESULT f_utime (const TCHAR* path, const FILINFO* fno);			/** Change timestamp of a file/dir */
pragma(mangle, "f_chdir") extern (C) FRESULT chdir(const TCHAR* path); /** Change current directory */
pragma(mangle, "f_chdrive") extern (C) FRESULT chdrive(const TCHAR* path); /** Change current drive */
pragma(mangle, "getcwd") extern (C) FRESULT getcwd(TCHAR* buff, UINT len); /** Get current directory */
//extern (C) FRESULT f_getfree(const TCHAR* path, DWORD* nclst, FATFS** fatfs); /** Get number of free clusters on the drive */
//extern (C) FRESULT f_getlabel(const TCHAR* path, TCHAR* label, DWORD* vsn); /** Get volume label */
//extern (C) FRESULT f_setlabel(const TCHAR* label); /** Set volume label */
//FRESULT f_forward (FIL* fp, UINT(*func)(const BYTE*,UINT), UINT btf, UINT* bf);	/** Forward data to the stream */
//FRESULT f_expand (FIL* fp, FSIZE_t szf, BYTE opt);					/** Allocate a contiguous block to the file */
pragma(mangle, "f_mount") extern (C) FRESULT mount(FATFS* fs, immutable(char)* path, BYTE opt); /** Mount/Unmount a logical drive */
//FRESULT f_mkfs (const TCHAR* path, BYTE opt, DWORD au, void* work, UINT len);	/** Create a FAT volume */
//FRESULT f_fdisk (BYTE pdrv, const DWORD* szt, void* work);			/** Divide a physical drive into some partitions */
extern (C) FRESULT setcp(WORD cp); /** Set current code page */
//int f_putc (TCHAR c, FIL* fp);										/** Put a character to the file */
//int f_puts (const TCHAR* str, FIL* cp);								/** Put a string to the file */
//int f_printf (FIL* fp, const TCHAR* str, ...);						/** Put a formatted string to the file */
pragma(mangle, "f_gets") extern (C) TCHAR* gets(TCHAR* buff, int len, FIL* fp); /** Get a string from the file */

bool eof(FIL fp)
{
	return fp.fptr == fp.obj.objsize;
}
