
#ifdef __cplusplus
extern "C" {
#endif

/* Address type (for 488.2 calls) */

typedef int Addr4882_t;       /* System dependent: must be 16 bits */


/***************************************************************************/
/*         IBSTA, IBERR, IBCNT, IBCNTL and FUNCTION PROTOTYPES             */
/*      ( only included if not accessing the 32-bit DLL directly )         */
/***************************************************************************/

/*
 *  Set up access to the user variables (ibsta, iberr, ibcnt, ibcntl).
 *  These are declared and exported by the 32-bit DLL.  Separate copies
 *  exist for each process that accesses the DLL.  They are shared by
 *  multiple threads of a single process.
 */

extern int  ibsta;
extern int  iberr;
extern int  ibcnt;
extern long ibcntl;
/*
 *  Extern 32-bit GPIB DLL functions
 */

#define ibbna  ibbnaA
#define ibfind ibfindA
#define ibrdf  ibrdfA
#define ibwrtf ibwrtfA

/*  NI-488 Function Prototypes  */
extern int __stdcall  ibfind   (char * udname);
extern int __stdcall  ibbna    (int ud, char * udname);
extern int __stdcall  ibrdf    (int ud, char * filename);
extern int __stdcall  ibwrtf   (int ud, char * filename);



extern int __stdcall  ibask    (int ud, int option, int *v);
//%output v

extern int __stdcall  ibcac    (int ud, int v);
extern int __stdcall  ibclr    (int ud);
extern int __stdcall  ibcmd    (int ud, char *buf, int cnt);
extern int __stdcall  ibcmda   (int ud, char * buf, int cnt);
extern int __stdcall  ibconfig (int ud, int option, int v);
extern int __stdcall  ibdev    (int ud, int pad, int sad, int tmo, int eot, int eos);
extern int __stdcall  ibdma    (int ud, int v);
extern int __stdcall  ibeos    (int ud, int v);
extern int __stdcall  ibeot    (int ud, int v);
extern int __stdcall  ibgts    (int ud, int v);
extern int __stdcall  ibist    (int ud, int v);
extern int __stdcall  iblines  (int ud, int * result);
//%output result

extern int __stdcall  ibln     (int ud, int pad, int sad, int * listen);
//%output listen

extern int __stdcall  ibloc    (int ud);
extern int __stdcall  ibonl    (int ud, int v);
extern int __stdcall  ibpad    (int ud, int v);
extern int __stdcall  ibpct    (int ud);
extern int __stdcall  ibpoke   (int ud, int option, int v);
extern int __stdcall  ibppc    (int ud, int v);
extern int __stdcall  ibrd     (int ud, void *buf, int cnt);
//%output buf(cnt)

extern int __stdcall  ibrda    (int ud, void * buf, int cnt);
//%output buf(cnt)

extern int __stdcall  ibrpp    (int ud, char *ppr);
//%output ppr

extern int __stdcall  ibrsc    (int ud, int v);
extern int __stdcall  ibrsp    (int ud, char *spr);
//%output spr

extern int __stdcall  ibrsv    (int ud, int v);
extern int __stdcall  ibsad    (int ud, int v);
extern int __stdcall  ibsic    (int ud);
extern int __stdcall  ibsre    (int ud, int v);
extern int __stdcall  ibstop   (int ud);
extern int __stdcall  ibtmo    (int ud, int v);
extern int __stdcall  ibtrg    (int ud);
extern int __stdcall  ibwait   (int ud, int mask);
extern int __stdcall  ibwrt    (int ud, char *buf, int cnt);

extern int __stdcall  ibwrta   (int ud, char *buf, int cnt);



extern int __stdcall   ThreadIbsta (void);
extern int __stdcall   ThreadIberr (void);
extern int __stdcall   ThreadIbcnt (void);
extern int __stdcall  ThreadIbcntl (void);


/**************************************************************************/
/*  NI-488.2 Function Prototypes  */

extern void  __stdcall  AllSpoll      (int boardID, Addr4882_t * addrlist, int * results);
//%output results
extern void  __stdcall  DevClear      (int boardID, Addr4882_t addr);
extern void  __stdcall  DevClearList  (int boardID, Addr4882_t * addrlist);
extern void  __stdcall  EnableLocal   (int boardID, Addr4882_t * addrlist);
extern void  __stdcall  EnableRemote  (int boardID, Addr4882_t * addrlist);
extern void  __stdcall  FindLstn      (int boardID, Addr4882_t * addrlist, int * results, int limit);
//%output results(limit)
extern void  __stdcall  FindRQS       (int boardID, Addr4882_t * addrlist, int * dev_stat);
//%output dev_stat

extern void  __stdcall  PPoll         (int boardID, int * result);
//%output result
extern void  __stdcall  PPollConfig   (int boardID, Addr4882_t addr, int dataLine, int lineSense);
extern void  __stdcall  PPollUnconfig (int boardID, Addr4882_t * addrlist);
extern void  __stdcall  PassControl   (int boardID, Addr4882_t addr);
extern void  __stdcall  RcvRespMsg    (int boardID, void *buffer, int cnt, int Termination);
//%output buffer(cnt)
extern void  __stdcall  ReadStatusByte(int boardID, Addr4882_t addr, int * result);
//%output result
extern void  __stdcall  Receive       (int boardID, Addr4882_t addr,void *buffer, int cnt, int Termination);
//%output buffer(cnt)

extern void  __stdcall  ReceiveSetup  (int boardID, Addr4882_t addr);
extern void  __stdcall  ResetSys      (int boardID, Addr4882_t * addrlist);
extern void  __stdcall  Send          (int boardID, Addr4882_t addr, char *databuf, int datacnt, int eotMode);

extern void  __stdcall  SendCmds      (int boardID, char * buffer, int cnt);

extern void  __stdcall  SendDataBytes (int boardID, char * buffer, int cnt, int eot_mode);

extern void  __stdcall  SendIFC       (int boardID);
extern void  __stdcall  SendLLO       (int boardID);
extern void  __stdcall  SendList      (int boardID, Addr4882_t * addrlist, char *databuf, int datacnt, int eotMode);

extern void  __stdcall  SendSetup     (int boardID, Addr4882_t * addrlist);
extern void  __stdcall  SetRWLS       (int boardID, Addr4882_t * addrlist);
extern void  __stdcall  TestSRQ       (int boardID, int * result);
//%output result
extern void  __stdcall  TestSys       (int boardID, Addr4882_t * addrlist, int * results);
//%output results

extern void  __stdcall  Trigger       (int boardID, Addr4882_t addr);
extern void  __stdcall  TriggerList   (int boardID, Addr4882_t * addrlist);
extern void  __stdcall  WaitSRQ       (int boardID, int * result);
//%output result



#ifdef __cplusplus
}
#endif



