using System;
using System.Runtime.InteropServices;
using System.Text;


namespace PI
{

	/// <summary>
	/// Summary description for E7XX.
	/// </summary>
	public class E7XX
	{


		///////////////////////////
		// E-7XX Bits (BIT_XXX). //
		///////////////////////////

		///* Curve Controll E7XX_BIT_WGO_XXX */
		public const int BIT_WGO_START_DEFAULT				= 0x00000001;
		public const int BIT_WGO_START_EXTERN_TRIGGER		= 0x00000002;
		public const int BIT_WGO_WITH_DDL_INITIALISATION	= 0x00000040;
		public const int BIT_WGO_WITH_DDL					= 0x00000080;
		public const int BIT_WGO_START_AT_ENDPOSITION		= 0x00000100;
		public const int BIT_WGO_SINGLE_RUN_DDL_TEST	= 0x00000200;
		public const int BIT_WGO_SAVE_BIT_1					= 0x00100000;
		public const int BIT_WGO_SAVE_BIT_2					= 0x00200000;
		public const int BIT_WGO_SAVE_BIT_3					= 0x00400000;

		/* Wave-Trigger E7XX_BIT_TRG_XXX */
		public const int BIT_TRG_LINE_1					= 0x0001;
		public const int BIT_TRG_LINE_2					= 0x0002;
		public const int BIT_TRG_LINE_3					= 0x0004;
		public const int BIT_TRG_LINE_4					= 0x0008;
		public const int BIT_TRG_ALL_CURVE_POINTS		= 0x0100;


		/* P(arameter)I(nfo)F(lag)_M(emory)T(ype)_XX */
		public const int PIF_MT_RAM				= 0x00000001;
		public const int PIF_MT_EPROM			= 0x00000002;
		public const int PIF_MT_ALL				= PIF_MT_RAM | PIF_MT_EPROM;


		/////////////////////////////////////////////////////////////////////////////
		// DLL initialization and comm functions
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_InterfaceSetupDlg")]		public static extern int	InterfaceSetupDlg(string sRegKeyName);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_ConnectRS232")]			public static extern int	ConnectRS232(int nPortNr, int nBaudRate);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_ConnectNIgpib")]			public static extern int	ConnectNIgpib(int nBoard, int nDevAddr);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_ConnectPciBoard")]		public static extern int	ConnectPciBoard(int iBoardNumber);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_ChangeNIgpibAddress")]	public static extern int	ChangeNIgpibAddress(int iId, int nDevAddr);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_IsConnected")]			public static extern int	IsConnected(int iId);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_CloseConnection")]		public static extern void	CloseConnection(int iId);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_GetError")]				public static extern int	GetError(int iId);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_SetErrorCheck")]			public static extern int	SetErrorCheck(int iId, int bErrorCheck);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_TranslateError")]			public static extern int	TranslateError(int errNr, StringBuilder sBuffer, int iMaxlen);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_CountPciBoards")]			public static extern int	CountPciBoards();

		
		/////////////////////////////////////////////////////////////////////////////
		// general
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_qERR")]	public static extern int	qERR(int iId, ref int nError);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_qIDN")]	public static extern int	qIDN(int iId, StringBuilder buffer, int iMaxlen);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_INI")]	public static extern int	INI(int iId, string sAxes);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_qHLP")]	public static extern int	qHLP(int iId, StringBuilder sBuffer, int iMaxlen);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_qHPA")]	public static extern int	qHPA(int iId, StringBuilder sBuffer, int iMaxlen);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_qOVF")]	public static extern int	qOVF(int iId, string sAxes, int []iOverFlow);
		
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_MOV")]		public static extern int	MOV(int iId, string sAxes, double []dValArray);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_qMOV")]		public static extern int	qMOV(int iId, string sAxes, double []dValArray);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_MVR")]		public static extern int	MVR(int iId, string sAxes, double []dValArray);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_qPOS")]		public static extern int	qPOS(int iId, string sAxes, double []dValArray);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_IsMoving")]	public static extern int	IsMoving(int iId, string sAxes, int []bValArray);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_HLT")]		public static extern int	HLT(int iId, string sAxes);
		
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_SVA")]	public static extern int	SVA(int iId, string sAxes, double []dValArray);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_qSVA")]	public static extern int	qSVA(int iId, string sAxes, double []dValArray);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_SVR")]	public static extern int	SVR(int iId, string sAxes, double []dValArray);
		
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_DFH")]	public static extern int	DFH(int iId, string sAxes);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_qDFH")]	public static extern int	qDFH(int iId, string sAxes, double []dValArray);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_GOH")]	public static extern int	GOH(int iId, string sAxes);
		
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_qCST")]	public static extern int	qCST(int iId, string sAxes, StringBuilder sNames, int iMaxlen);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_CST")]	public static extern int	CST(int iId, string sAxes, string names);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_qVST")]	public static extern int	qVST(int iId, StringBuilder sValideStages, int iMaxlen);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_qTVI")]	public static extern int	qTVI(int iId, StringBuilder sValideAxisIds, int iMaxlen);
		
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_SVO")]	public static extern int	SVO(int iId, string sAxes, int []iValArray);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_qSVO")]	public static extern int	qSVO(int iId, string sAxes, int []iValArray);
		
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_VEL")]	public static extern int	VEL(int iId, string sAxes, double []dValArray);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_qVEL")]	public static extern int	qVEL(int iId, string sAxes, double []dValArray);
		
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_SPA")]	public static extern int	SPA(int iId, string sAxes, uint []iParameterArray, double []dValArray, string sStrings);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_qSPA")]	public static extern int	qSPA(int iId, string sAxes, uint []iParameterArray, double []dValArray, StringBuilder sStrings, int iMaxNameSize);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_SEP")]	public static extern int	SEP(int iId, string sPassword, string sAxes, uint []iParameterArray, double []dValArray, string szStrings);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_qSEP")]	public static extern int	qSEP(int iId, string sAxes, uint []iParameterArray, double []dValArray, StringBuilder sStrings, int iMaxNameSize);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_WPA")]	public static extern int	WPA(int iId, string sPassword, string sAxes, uint []iParameterArray);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_RPA")]	public static extern int	RPA(int iId, string sAxes, uint []iParameterArray);
		
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_STE")]	public static extern int	STE(int iId, char cAxis, double dOffset);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_qSTE")]	public static extern int	qSTE(int iId, char cAxis, int iOffset, int nrValues, double []dValArray);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_IMP")]	public static extern int	IMP(int iId, char cAxis, double dOffset);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_qIMP")]	public static extern int	qIMP(int iId, char cAxis, int iOffset, int nrValues, double []dValArray);
		
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_SAI")]		public static extern int	SAI(int iId, string sOldAxes, string sNewAxes);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_qSAI")]		public static extern int	qSAI(int iId, StringBuilder sAxes, int iMaxlen);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_qSAI_ALL")]	public static extern int	qSAI_ALL(int iId, StringBuilder sAxes, int iMaxlen);
		
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_CCL")]		public static extern int	CCL(int iId, int iComandLevel, string sPassWord);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_qCCL")]		public static extern int	qCCL(int iId, ref int iComandLevel);
		
		
		/////////////////////////////////////////////////////////////////////////////
		// String commands.
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_E7XXSendString")]		public static extern int	E7XXSendString(int iId, string sString);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_E7XXReadLine")]		public static extern int	E7XXReadLine(int iId, StringBuilder sAnswer, int iBufSize);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_GcsCommandset")]		public static extern int	GcsCommandset(int iId, string sCommand);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_GcsGetAnswer")]		public static extern int	GcsGetAnswer(int iId, StringBuilder sAnswer, int iBufSize);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_GcsGetAnswerSize")]	public static extern int	GcsGetAnswerSize(int iId, ref int iAnswerSize);
		
		
		/////////////////////////////////////////////////////////////////////////////
		// limits.
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_ATZ")]	public static extern int	ATZ(int iId,  string sAxes, double []dLowVoltageArray, int []fUseDefaultArray);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_qTMN")]	public static extern int	qTMN(int iId, string sAxes, double []dValArray);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_qTMX")]	public static extern int	qTMX(int iId, string sAxes, double []dValArray);
		
		
		/////////////////////////////////////////////////////////////////////////////
		// Wave commands.
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_WMS")]		public static extern int	WMS(int iId, string sAxes, int []iMaxWaveSize);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_qWMS")]		public static extern int	qWMS(int iId, string sAxes, int []iMaxWaveSize);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_WAV_SIN_P")]	public static extern int	WAV_SIN_P(int iId, string sAxes, int nStart, int nLength, int iAppend, int iCenterPoint, double rAmplitude, double rOffset, int iSegmentLength);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_WAV_LIN")]	public static extern int	WAV_LIN(int iId, string sAxes, int nStart, int nLength, int iAppend, int iSpeedUpDown, double rAmplitude, double rOffset, int iSegmentLength);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_WAV_RAMP")]	public static extern int	WAV_RAMP(int iId, string sAxes, int nStart, int nLength, int iAppend, int iCenterPoint, int iSpeedUpDown, double rAmplitude, double rOffset, int iSegmentLength);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_WAV_PNT")]	public static extern int	WAV_PNT(int iId, string sAxes, int nStart, int nLength, int iAppend, double []pPoints);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_qWAV")]		public static extern int	qWAV(int iId, string sAxes, int []iCmdarray, double []dValArray);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_qGWD")]		public static extern int	qGWD(int iId, char cAxis, int iStart, int iLength, double []dData);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_WGO")]		public static extern int	WGO(int iId, string sAxes, int []iStartMod);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_qWGO")]		public static extern int	qWGO(int iId, string sAxes, int []iValArray);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_WGR")]		public static extern int	WGR(int iId);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_qTNR")]		public static extern int	qTNR(int iId, ref int iRecChannels);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_DRC")]		public static extern int	DRC(int iId, int []iRecChannelId, string sRecSourceId, int []iRecOption, int []iTriggerOption);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_qDRC")]		public static extern int	qDRC(int iId, int []iRecChannelId, StringBuilder sRecSourceId, int []iRecOption, int []iTriggerOption, int ArraySize);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_qDRR_SYNC")]		public static extern int	qDRR_SYNC(int iId, int iRecChannelId, int iOffset, int iValues, double []dValArray);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_qTWG")]		public static extern int	qTWG(int iId, ref int iGenerator);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_qTLT")]		public static extern int	qTLT(int iId, ref int iLinearizationTable);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_DDL")]		public static extern int	DDL(int iId, int iLinearizationTable, int iOffset, int iValues, double []dValArray);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_qDDL")]		public static extern int	qDDL(int iId, int iLinearizationTable, int iOffset, int iValues, double []dValArray);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_DTC")]		public static extern int	DTC(int iId, int iLearnTable, int bClearWaveAllsow);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_TWS")]		public static extern int	TWS(int iId, int []iWavePoint, int []iTriggerLevel, int iNumberOfPoints);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_TWC")]		public static extern int	TWC(int iId);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_DPO")]		public static extern int	DPO(int iId, string sAxes);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_IsGeneratorRunning")]		public static extern int	IsGeneratorRunning(int iId, string sAxes, int []pValArray);
		
		
		/////////////////////////////////////////////////////////////////////////////
		// Piezo-Channel commands.
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_VMA")]	public static extern int	VMA(int iId, string sPiezoChannels, double []dValarray);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_qVMA")]	public static extern int	qVMA(int iId, string sPiezoChannels, double []dValarray);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_VMI")]	public static extern int	VMI(int iId, string sPiezoChannels, double []dValarray);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_qVMI")]	public static extern int	qVMI(int iId, string sPiezoChannels, double []dValarray);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_qVOL")]	public static extern int	qVOL(int iId, string sPiezoChannels, double []dValarray);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_qTPC")]	public static extern int	qTPC(int iId, ref int iPiezoCannels);
		
		
		/////////////////////////////////////////////////////////////////////////////
		// Sensor-Channel commands.
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_qTAD")]	public static extern int	qTAD(int ID, string sSensorChannels, int []iValarray);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_qTNS")]	public static extern int	qTNS(int ID, string sSensorChannels, double []dValarray);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_qTSP")]	public static extern int	qTSP(int ID, string sSensorChannels, double []dValarray);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_qTSC")]	public static extern int	qTSC(int ID, ref int iSensorCannels);
		
		
		///////////////////////////////////////////////////////////////////////////////
		//// AutoFocus (6 channel version only).
		//BOOL E7XX_FUNC_DECL E7XX_AFB(const int ID, char* const szAxes, double* pdValarray);
		//BOOL E7XX_FUNC_DECL E7XX_qAFB(const int ID, char* const szAxes, double* pdValarray);
		//BOOL E7XX_FUNC_DECL E7XX_AFR(const int ID, char* const szAxes, double* pdValarray);
		//BOOL E7XX_FUNC_DECL E7XX_qAFR(const int ID, char* const szAxes, double* pdValarray);
		//BOOL E7XX_FUNC_DECL E7XX_qAFI(const int ID, char* const szAxes, double* pdValarray);
		//
		//
		///////////////////////////////////////////////////////////////////////////////
		//// Flatness Compensation (6 channel version only).
		//BOOL E7XX_FUNC_DECL E7XX_FCG(const int ID, char const cAxis, char* const szExternalAxes, double* pdMaxValarray, double* pdMinValarray, int* NumberOfPointsArray);
		//BOOL E7XX_FUNC_DECL E7XX_qFCG(const int ID, char const cAxis, char* const szExternalAxes, double* pdMaxValarray, double* pdMinValarray, int* NumberOfPointsArray);
		//BOOL E7XX_FUNC_DECL E7XX_FCA(const int ID, char* const szAxes, BOOL* pbActive);
		//BOOL E7XX_FUNC_DECL E7XX_qFCA(const int ID, char* const szAxes, BOOL* pbActive);
		//BOOL E7XX_FUNC_DECL E7XX_FCD(const int ID, char const cAxis, int iArraySize, double* pdValarray);
		//BOOL E7XX_FUNC_DECL E7XX_qFCD(const int ID, char const cAxis, double* pdValarray, int iArrayMaxSize);
		//BOOL E7XX_FUNC_DECL E7XX_FCP(const int ID, char* const szExternalAxes, double* pdPositionArray);
		//BOOL E7XX_FUNC_DECL E7XX_qFCP(const int ID, char* const szExternalAxes, double* pdPositionArray);
		//
		//
		///////////////////////////////////////////////////////////////////////////////
		//// Crosstalk correction (6 channel version only).
		//BOOL E7XX_FUNC_DECL E7XX_CTC(const int ID, char const cAxis, char* const szCosstalkAxes, double* pdRange, double* pdErrorFactor);
		//
		//
		///////////////////////////////////////////////////////////////////////////////
		//// DDL Auto Examine (6 channel version only).
		//BOOL E7XX_FUNC_DECL E7XX_DAS(const int ID, char* const szAxes, BOOL* pbEnable, int* plLowerLimit, int* plUperLimit);
		//BOOL E7XX_FUNC_DECL E7XX_qDAS(const int ID, char* const szAxes, BOOL* pbEnable, int* plLowerLimit, int* plUperLimit);
		//BOOL E7XX_FUNC_DECL E7XX_qDAE(const int ID, char* const szAxes, double* pdAverageError);
		//BOOL E7XX_FUNC_DECL E7XX_qDAD(const int ID, char* const szAxes, double* pdDeviation);
		//BOOL E7XX_FUNC_DECL E7XX_DAC(const int ID, char* const szAxes);
		//
		//
		///////////////////////////////////////////////////////////////////////////////
		//// Spezial
		//BOOL	E7XX_FUNC_DECL	E7XX_AddStage(const int ID, char* const szAxes);
		//BOOL	E7XX_FUNC_DECL	E7XX_RemoveStage(const int ID, char* szStageName);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_GetSupportedFunctions")]		public static extern int	GetSupportedFunctions(int ID, int []piComandLevelArray, int iMaxlen, StringBuilder sFunctionNames, int iMaxFunctioNamesLength);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_GetSupportedParameters")]		public static extern int	GetSupportedParameters(int ID, int []piParameterIdArray, int []piComandLevelArray, int []piMemoryLocationArray, int iMaxlen, StringBuilder sParameterName, int iMaxParameterNameSize);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_GetSupportrdControllers")]	public static extern int	GetSupportrdControllers(StringBuilder szControllerNames, int iMaxlen);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_NMOV")]		public static extern int	NMOV(int iId, string sAxes, double []dValArray);
		[DllImport("E7XX_GCS_DLL.dll", EntryPoint = "E7XX_NMVR")]		public static extern int	NMVR(int iId, string sAxes, double []dValArray);

	}
}
