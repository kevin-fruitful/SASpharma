/*******************************************************************************
| Program Name: defaults.sas
|
| Program Version: 00.01
| 
| Program Purpose: Study level defaults
|
********************************************************************************/
options nofmterr validvarname = upcase;

options fmtsearch = (grefdata.formats);


libname sdtm "" access=readonly;
libname adam "" access=readonly;
libname qc "" ;
libname here "";

libname refdata "" access=readonly;
libname diction "" access=readonly;
libname fmtdir "";

options fmtsearch=(diction) missing = ' ' validvarname=upcase;

*** Formats **;
proc format;
       picture percfmt (round)
              . ='    '    (noedit)
              0 ='    '    (noedit)
          0<-<1 ='(<1%)'   (noedit)
         1-<9.5 =' 0%)'    (prefix='(')
       9.5-99.5 =' 00%)'   (prefix='(')
     99.5<-<100 ='(>99%)'  (noedit)
            100 =' 000%)'  (prefix='(')
          other = '*' (noedit)
          ;

** Treatment variable formats **;          
	value $trtfmt (multilabel)
		'C1' = 'C1'
		'C2' = 'C2'
		'C3' = 'C3'
		'C4' = 'C4'
		'C5' = 'C5'
		'C6' = 'C6'
/* 		'C2', 'C3', 'C4' = 'C5' */
/* 		'C1', 'C2', 'C3', 'C4' = 'C6' */
		;
		
	value $trtdmyfmt (multilabel)
		'C1' = 'C1'
		'C2' = 'C2'
		'C3' = 'C3'
		'C4' = 'C4'
		'C2', 'C3', 'C4' = 'C5'
		'C1', 'C2', 'C3', 'C4' = 'C6'
		;
		
	invalue statsfmts
		'N' = 1
		'MEAN' = 2
		'SD' = 3
		'MEDIAN' = 4
		'MIN' = 5
		'MAX' = 6
		;
		
	value statsfmt
		0 = 'n'
		20 = 'Mean'
		30 = 'SD'
		40 = 'Median'
		50 = 'Min.'
		60 = 'Max.'
		;
		
    value occfmt (multilabel)
        1-high = 'n'
        1 = 'One'
        2 = 'Two'
        3-high = 'Three or more'
        ;
        
    invalue occsortfmt
    	'n' = 1
    	'One' = 2
    	'Two' = 3
    	'Three or more' = 4
    	;
        
    value $outfmt (multilabel)
		'FATAL', 'NOT RECOVERED/NOT RESOLVED', 'RECOVERED/RESOLVED', 'RECOVERED/RESOLVED WITH SEQUELAE', 'RECOVERING/RESOLVING', 'UNKNOWN' = 'n'
		'FATAL' = 'Fatal' 
		'NOT RECOVERED/NOT RESOLVED' = 'Not Recovered/Not Resolved' 
		'RECOVERED/RESOLVED' = 'Recovered/Resolved' 
		'RECOVERED/RESOLVED WITH SEQUELAE' = 'Recovered/Resolved w/ sequelae' 
		'RECOVERING/RESOLVING' = 'Recovering/Resolving' 
		'UNKNOWN' = 'Unknown' 
		;

	invalue outsortfmt
		'n' = 1
		'Fatal' = 6
		'Not Recovered/Not Resolved' = 4
		'Recovered/Resolved' = 2
		'Recovered/Resolved w/ sequelae' = 5
		'Recovering/Resolving' = 3
		'Unknown' = 7
		;
		
	value $aetoxgrfmt (multilabel)
		'1', '2', '3', '4', '5' = 'n'
		'1' = 'Grade 1' 
		'2' = 'Grade 2' 
		'3' = 'Grade 3' 
		'4' = 'Grade 4' 
		'5' = 'Grade 5' 
		;
		
	invalue aetoxsortfmt
		'n' = 1
		'Grade 1' = 2
		'Grade 2' = 3
		'Grade 3' = 4
		'Grade 4' = 5
		'Grade 5' = 6
		;
run;

*** Default ADSL common variables **;
%let default_adsl_comvar = studyid usubjid subjid siteid age ageu sex race raceoth ethnic ittfl mittfl armcd arm actarmcd actarm
               trt01p trt02p trt01a trt02a trtseqp trtseqa trtsdt trtsdtm trtedt trtedtm tr01sdt tr02sdt icf01dt
               icf02dt aph01dt aph02dt ch01sdt ch02sdt rfpendt dthdt;

*** Default bigN dataset **;
%let default_bign_ds = adsl;

*** Default treatment variable **;
%let default_trtvar=armcd;

*** Default treatment display **;
%let default_trt_display = C1 C2 C3 C4 | C2 C3 C4 = C5 | C1 C2 C3 C4 = C6;



*** Macro programs **;
%include "/macro_bign.sas";
%include "/macro_rename_sort.sas";
%include "/macro_rename_sort_m.sas";
%include "/macro_count_nested.sas";
%include "/macro_continuous_stats.sas";


