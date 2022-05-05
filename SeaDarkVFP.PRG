******************************************
* Criado por: Omar Junior - @OmarJunr    *
* Versão 1.0  ------------  05/05/2022   *
*                SEA DARK                *
******************************************

SET PATH TO HOME() + "FFC\" ADDITIVE
#INCLUDE "Registry.H"

#DEFINE HKEY_CLASSES_ROOT  - 2147483648   && BITSET(0, 31)     
#DEFINE HKEY_CURRENT_USER  - 2147483647   && BITSET(0, 31) + 1 
#DEFINE HKEY_LOCAL_MACHINE - 2147483646   && BITSET(0, 31) + 2 
#DEFINE HKEY_USERS         - 2147483645   && BITSET(0, 31) + 3 
CLEAR

SetCoresTemaSeaDark()

MessageBox([Reinicie o Microsoft Visual FoxPro para aplicar as mudanças de tema no editor.], 4096 + 64, [SeaDark Tema para Microsoft Visual FoxPro])

FUNCTION SetCoresTemaSeaDark()
   LOCAL lnLoop AS INTEGER, lcRegKey AS STRING, lcValue AS STRING, regConst AS STRING

   Dimension aEditorColors[7, 3]
   aEditorColors[1, 1] = "EditorCommentColor"
   aEditorColors[1, 2] = "RGB(255, 0, 0, 255, 255, 255), NoAuto, NoAuto"
   aEditorColors[2, 1] = "EditorKeywordColor"
   aEditorColors[2, 2] = "RGB(255, 85, 85, 33, 33, 33), NoAuto, NoAuto"
   aEditorColors[3, 1] = "EditorConstantColor"
   aEditorColors[3, 2] = "RGB(109, 204, 92, 33, 33, 33), NoAuto, NoAuto"
   aEditorColors[4, 1] = "EditorNormalColor"
   aEditorColors[4, 2] = "RGB(98, 114, 164, 33, 33, 33), NoAuto, NoAuto"
   aEditorColors[5, 1] = "EditorOperatorColor"
   aEditorColors[5, 2] = "RGB(255, 255, 255, 33, 33, 33), NoAuto, NoAuto"
   aEditorColors[6, 1] = "EditorStringColor"
   aEditorColors[6, 2] = "RGB(52, 254, 187, 33, 33, 33), NoAuto, NoAuto"
   aEditorColors[7, 1] = "EditorVariableColor"
   aEditorColors[7, 2] = "RGB(95, 201, 241, 33, 33, 33), NoAuto, NoAuto"

   lcRegKey = "Software\Microsoft\VisualFoxPro\9.0\Options"
   regConst = HKEY_CURRENT_USER
   FOR lnLoop = 1 TO ALEN(aEditorColors, 1)
      lcValue = SetRegKey(regConst, lcRegKey, aEditorColors[lnLoop, 1], aEditorColors[lnLoop, 2])
   ENDFOR
ENDFUNC

FUNCTION SetRegKey()
   LPARAMETERS hkey AS CHARACTER, keyPath AS CHARACTER, entry AS CHARACTER, regValue AS CHARACTER
   GetRegistryApi()
   keyPath  = ADDBS(TRANSFORM(EVL(keyPath, "")))
   entry    = TRANSFORM(EVL(entry, ""))
   regValue = TRANSFORM(regValue)
   RETURN (oRegApi.SetRegKey(entry, regValue, keyPath, hkey, .T.) = 0)

   FUNCTION GetRegistryApi() AS Registry
   IF VARTYPE(oRegApi) # "O" THEN
      PUBLIC oRegApi AS Registry
      oRegApi = NewObject("Registry", HOME() + "FFC\Registry.VCX")
   ENDIF
   RETURN oRegApi
ENDFUNC