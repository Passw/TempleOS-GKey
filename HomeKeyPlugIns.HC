//GKey: German Keyboard Layout for TempleOS

//Layout Definitions
asm {
GN_KEY_SCAN_DECODE_TABLE::
	DU8	0,CH_ESC,"1234567890�\`",CH_BACKSPACE,'\t';
	DU8	"qwertzuiop�+",'\n',0,"as";
	DU8	"dfghjkl��^",0,"#yxcv";
	DU8	"bnm,.-",0,'*',0,CH_SPACE,0,0,0,0,0,0;
	DU8	0,0,0,0,0,0,0,0,0,0,'-',0,0,0,'+',0;
GS_KEY_SCAN_DECODE_TABLE::
	DU8	0,CH_SHIFT_ESC,"!\"�$$%&/()=?\`",CH_BACKSPACE,'\t';
	DU8	"QWERTZUIOP�*",'\n',0,"AS";
	DU8	"DFGHJKL���",0,"'YXCV";
	DU8	"BNM;:_",0,'*',0,CH_SHIFT_SPACE,0,0,0,0,0,0;
	DU8	0,0,0,0,0,0,0,0,0,0,'-',0,0,0,'+',0;
GC_KEY_SCAN_DECODE_TABLE::
	DU8	0,CH_ESC,"1234567890-=",CH_BACKSPACE,'\t';
	DU8	CH_CTRLQ,CH_CTRLW,CH_CTRLE,CH_CTRLR,CH_CTRLT,CH_CTRLZ,CH_CTRLU,
		CH_CTRLI,CH_CTRLO,CH_CTRLP,"[]",'\n',0,CH_CTRLA,CH_CTRLS;
	DU8	CH_CTRLD,CH_CTRLF,CH_CTRLG,CH_CTRLH,CH_CTRLJ,CH_CTRLK,CH_CTRLL,
		";'\`",0,"\\",CH_CTRLY,CH_CTRLX,CH_CTRLC,CH_CTRLV;
	DU8	CH_CTRLB,CH_CTRLN,CH_CTRLM,",./",0,'*',0,CH_SPACE,0,0,0,0,0,0;
	DU8	0,0,0,0,0,0,0,0,0,0,'-',0,0,0,'+',0;
}
//Font Definitions
text.font['�']=0x007C666666006600;
text.font['�']=0x007C667C603C0066;
text.font['�']=0x00667E66663C0066;
text.font['�']=0x003C66663C006600;
text.font['�']=0x003C6666663C0066;
text.font['�']=0x003C666666660066;
text.font['�']=0x003C460F061F463C;
text.font['�']=0x1C36386C6C38D870;
text.font['�']=0x003666663636663C;

//Overwriting Scan Decode Tables
MemCpy(NORMAL_KEY_SCAN_DECODE_TABLE,GN_KEY_SCAN_DECODE_TABLE,64);
MemCpy(SHIFT_KEY_SCAN_DECODE_TABLE,GS_KEY_SCAN_DECODE_TABLE,64);
MemCpy(CTRL_KEY_SCAN_DECODE_TABLE,GC_KEY_SCAN_DECODE_TABLE,64);

U0 TimeIns()
{
  CDate cdt;
  cdt=Now;
  "$$IV,1$$----%D %T----$$IV,0$$\n",cdt,cdt;
}

Bool MyPutKey(I64 ch,I64 sc)
{//ch=ASCII; sc=scan_code

  //See $LK,"Char",A="HI:Char"$ for definition of scan codes.
  //See $LK,"Key Allocations",A="FI:::/Doc/KeyAlloc.DD"$.
  //See $LK,"Keyboard Devices",A="HI:Keyboard Devices/System"$.

  //You can customize keys.  This routine
  //is called before the main editor
  //key hndlr $LK,"DocPutKey",A="MN:DocPutKey"$().
  //You can intercept any key.

  //Return TRUE if you completely
  //handled the key.
  I64 i;
  U8 *st1,*st2;

  //Implementing "<>|" Key
  if (sc&0x7F==0x56 && !(sc&SCF_CTRL||sc&SCF_KEY_DESC)){
    if(sc&SCF_ALT)
      '|';
    else if(sc&SCF_SHIFT^^sc&SCF_CAPS)
      '>';
    else
      '<';
    return TRUE;
  }

  if (sc&SCF_ALT && !(sc&SCF_CTRL)) {
    switch (ch) {
      case 0:
	switch (sc.u8[0]) {
	  case SC_F1:
	    if (sc&SCF_SHIFT) {
	      if (sc&SCF_KEY_DESC)
		KeyDescSet("Dol/LTPURPLE");
	      else
		"$$LTPURPLE$$";
	    } else {
	      if (sc&SCF_KEY_DESC)
		KeyDescSet("Dol/PURPLE");
	      else
		"$$PURPLE$$";
	    }
	    return TRUE;
	  case SC_F2:
	    if (sc&SCF_SHIFT) {
	      if (sc&SCF_KEY_DESC)
		KeyDescSet("Dol/LTRED");
	      else
		"$$LTRED$$";
	    } else {
	      if (sc&SCF_KEY_DESC)
		KeyDescSet("Dol/RED");
	      else
		"$$RED$$";
	    }
	    return TRUE;
	  case SC_F3:
	    if (sc&SCF_SHIFT) {
	      if (sc&SCF_KEY_DESC)
		KeyDescSet("Dol/LTGREEN");
	      else
		"$$LTGREEN$$";
	    } else {
	      if (sc&SCF_KEY_DESC)
		KeyDescSet("Dol/GREEN");
	      else
		"$$GREEN$$";
	    }
	    return TRUE;
	  case SC_F4:
	    if (sc&SCF_SHIFT) {
	      if (sc&SCF_KEY_DESC)
		KeyDescSet("Dol/Default Color");
	      else
		"$$FG$$";
	    } else {
	      if (sc&SCF_KEY_DESC)
		KeyDescSet("Dol/BLUE");
	      else
		"$$BLUE$$";
	    }
	    return TRUE;
	  case SC_F7:
	    if (!(sc&SCF_SHIFT)) {
	      if (sc&SCF_KEY_DESC)
		KeyDescSet("Cmd/TimeIns");
	      else
		TimeIns;
	    }
	    return TRUE;
	}
	break;
      case 'a':
	if (sc&SCF_KEY_DESC)
	  KeyDescSet("Cmd/AutoComplete On");
	else
	  AutoComplete(ON);
	return TRUE;
      case 'A':
	if (sc&SCF_KEY_DESC)
	  KeyDescSet("Cmd/AutoComplete Off");
	else
	  AutoComplete;
	return TRUE;
      case 'h':
	if (sc&SCF_KEY_DESC)
	  KeyDescSet("Cmd/WinTileHorz");
	else
	  WinTileHorz;
	return TRUE;
      case 'm':
	if (sc&SCF_KEY_DESC)
	  KeyDescSet("Cmd/WinMax");
	else {
	  WinBorder;
	  WinMax;
	}
	return TRUE;
      case 'v':
	if (sc&SCF_KEY_DESC)
	  KeyDescSet("Cmd/WinTileVert");
	else
	  WinTileVert;
	return TRUE;
      case 'l':
	if (sc&SCF_KEY_DESC)
	  KeyDescSet("Edit/Put Link to Cur Pos on Clip");
	else {
	  ClipDel;
	  st1=FileNameAbs(BIBLE_FILENAME);
	  st2=FileNameAbs(DocPut->filename.name);
	  if (!StrCmp(st1,st2)) {
	    Free(st1);
	    st1=BibleLine2Verse(DocPut->cur_entry->y+1,',');
	    DocPrint(sys_clip_doc,"$$LK,\"BF:%s\"$$",st1);
	  } else
	    DocPrint(sys_clip_doc,"$$LK,\"FL:%s,%d\"$$",
		  st2,DocPut->cur_entry->y+1);
	  Free(st1);
	  Free(st2);
	}
	return TRUE;
      case 'L':
	if (sc&SCF_KEY_DESC)
	  KeyDescSet("Edit/Place Anchor, Put Link to Clip");
	else {
	  i=RandU32;
	  ClipDel;
	  DocPrint(sys_clip_doc,"$$LK,\"<TODO>\",A=\"FA:%s,ANC%d\"$$",
		DocPut->filename.name,i);
	  "$$AN,\"<TODO>\",A=\"ANC%d\"$$",i;
	}
	return TRUE;

	//Ins your own ALT-key plug-ins
      case '1':
	if (sc&SCF_KEY_DESC)
	  KeyDescSet("Dol/�");
	else
	  '�';
	return TRUE;
      case '2':
	if (sc&SCF_KEY_DESC)
	  KeyDescSet("Dol/�");
	else
	  '�';
	return TRUE;
      case '3':
	if (sc&SCF_KEY_DESC)
	  KeyDescSet("Dol/�");
	else
	  '�';
	return TRUE;
      case '4':
	if (sc&SCF_KEY_DESC)
	  KeyDescSet("Dol/�");
	else
	  '�';
	return TRUE;
      //Implementing AltGr functionality
      case '7':
	if (!(sc&SCF_KEY_DESC))
	  '{';
	return TRUE;
      case '8':
	if (!(sc&SCF_KEY_DESC))
	  '[';
	return TRUE;
      case '9':
	if (!(sc&SCF_KEY_DESC))
	  ']';
	return TRUE;
      case '0':
	if (!(sc&SCF_KEY_DESC))
	  '}';
	return TRUE;
      case '�':
	if (!(sc&SCF_KEY_DESC))
	  '\\';
	return TRUE;
      case 'q':
	if (!(sc&SCF_KEY_DESC))
	  '@';
	return TRUE;
      case '+':
	if (!(sc&SCF_KEY_DESC))
	  '~';
	return TRUE;
      case 'e':
	if (!(sc&SCF_KEY_DESC))
	  '�';
	return TRUE;
    }
  }
  return FALSE;
}

Bool MyPutS(U8 *)
{
  return FALSE;
}

KeyDevAdd(&MyPutKey,&MyPutS,0x20000000,TRUE);

