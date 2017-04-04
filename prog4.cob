       Identification Division.

       Program-id. Forth-Prog.
      
      *Alberto Cen Zheng
      *CSI203
      *HW2
      *Work on Mar/28/17

      *This is a program that moving the information from the input file and edit and print it in a desire way.

      **Objective...
      ***add page number 
      ***print out number of bedroom as string instead of number.
      ***add table for sale price accumulation base on bedroom.

       Date-compiled.
   
       Environment Division.
     
       Input-Output Section.
 
       File-Control.

           select Input-file assign to 
           "/home1/c/a/acsi203/realestate.dat".
	   select Output-file assign to
	   "prog4out.dat"
           organization is line sequential.
           select Error-file assign to
	   "error4out.dat"
	   organization is line sequential.
			 
       Data Division.
	   
       File Section.
     
       FD Input-file.
   
       01 Input-rec. 
          02 Addresses          pic x(27). 
          02 City               pic A(15).     
	  02 Zip                pic x(5).     
	  02 State              pic x(2).
	    88 valid-state        value "CA".  
          02 Bedroom            pic 9(1).   
	  02 Bathroom           pic 9(1).
	  02 SquareFeet   	pic 9(4).
	  02 PropertyType       pic x(8).
	    88 valid-PropertyType value "Resident" "Condo" "Multi-Fa".   
	  02 SaleDay		pic x(3).    
	  02 filler 		pic x(1).  
	  02 SaleMonth          pic x(3).    
	  02 filler 		pic x(1). 
	  02 SalesDay           pic 9(2).
	  02 filler             pic x(1).
	  02 SalesHour          pic 9(2).   
	  02 filler             pic x(1). 	 
          02 SalesMinute        pic 9(2).
	  02 filler             pic x(1).
	  02 SalesSecond        pic 9(2).
	  02 filler             pic x(1). 
	  02 TimeZone 	        pic A(3).
	  02 filler             pic x(1).
	  02 SaleYear		pic 9(4).
	  02 SalePrice   	pic 9(6).
	  02 PropertyLatitude   pic 9(8).
	  02 PropertyLongtitude pic 9(9).

  	  02 filler 		pic x(1).
 
    
      *new  
       FD Output-file
	  Linage is 58 lines with footing at 56
          Lines at top 5 lines at bottom 5.

       01 Output-rec            pic x(132).


       FD Error-file.
       01 Error-rec		pic x(132).


       Working-Storage Section.

      *new
       01 Page-number-line.
	  02 filler 		pic x(64) value spaces.
	  02 filler 		pic x value "-".
	  02 Page-number	pic 99 value 1.
	  02 filler 		pic x value "-".
	  02 filler 		pic x(64) value spaces.
      
       01 Report-Header.
	  02 filler             pic x(43) value spaces.
	  02 filler		pic x(36) value
	  "California Real Estate Transactions-".
	  02 month-out 		pic 9(2).
	  02 filler 		pic x value "/".
	  02 day-out 		pic 9(2).
	  02 filler 		pic x value "/".
	  02 year-out 		pic 9(4).
	  02 filler             pic x(43) value spaces.

       01 todays-date.
	  02 Years		pic 9(4).
	  02 Months		pic 9(2).
	  02 Days		pic 9(2).
	   
       01 Colomn-Header.
	  02 filler 		pic x(7) value "Address".
	  02 filler 		pic x(21) value spaces.
		   
          02 filler 		pic x(4) value "City".
	  02 filler 		pic x(12) value spaces.
		   
	  02 filler 		pic x(3) value "Zip".
	  02 filler 		pic x(3) value spaces.
		   
	  02 filler 		pic x(2) value "ST".
	  02 filler		pic x(1) value spaces.
  		   
	  02 filler 		pic x(5) value "Bd".
	  02 filler 		pic x(1) value spaces.
		   
	  02 filler 		pic x(2) value "Bt".
	  02 filler 		pic x(1) value spaces.
		   
	  02 filler 		pic x(4) value "SqFt".
	  02 filler 		pic x(1) value spaces.
		   
	  02 filler 		pic x(8) value "PropType".
	  02 filler 		pic x(1) value spaces.
		   
	  02 filler 		pic x(3) value "SDy".
	  02 filler 		pic x(1) value spaces.
		   
	  02 filler 		pic x(3) value "SMo".
	  02 filler 		pic x(1) value spaces.

	  02 filler  		pic x(2) value "DY".
 	  02 filler 		pic x(1) value spaces.	

	  02 filler  		pic x(2) value "HR".
 	  02 filler 		pic x(1) value spaces.

	  02 filler  		pic x(2) value "MN".
	  02 filler 		pic x(1) value spaces.

	  02 filler  		pic x(2) value "SC".
	  02 filler 		pic x(1) value spaces.
	      
	  02 filler 		pic x(4) value "SlYr".
	  02 filler 		pic x(1) value spaces.

	  02 filler 		pic x(6) value "SalePr".
	  02 filler 		pic x(6) value spaces.

	  02 filler             pic x(7) value "Pr/SqFt".
	  02 filler 		pic x(1) value spaces.

          02 filler             pic x(6) value "EstVal".	  
	  02 filler 		pic x(5) value spaces.
	   
       01 Info-line.
	  02 Addresses-out      pic x(27).
	  02 filler 		pic x(1) value spaces.
	  02 City-out           pic A(15).
	  02 filler 		pic x(1) value spaces.
	  02 Zip-out            pic 9(5).
	  02 filler 		pic x(1) value spaces.
	  02 State-out          pic A(2).
	  02 filler 		pic x(1) value spaces.
	  02 Bedroom-out        pic x(5).
	  02 filler 		pic x(1) value spaces.
	  02 Bathroom-out       pic x(1).
	  02 filler 		pic x(2) value spaces.
	  02 SquareFeet-out 	pic z(3)9.
	  02 filler 		pic x(1) value spaces.
	  02 PropertyType-out   pic x(8).
	  02 filler 		pic x(1) value spaces.
	  02 SaleDay-out	pic x(3).
	  02 filler 		pic x(1) value spaces.
	  02 SaleMonth-out      pic x(3).
	  02 filler 		pic x(1) value spaces.
	  02 DY-out		pic x(2).
 	  02 filler 		pic x(1) value spaces.
	  02 HR-out 		pic x(2).
 	  02 filler 		pic x(1) value spaces.
	  02 MIN-out  		pic x(2).
          02 filler 		pic x(1) value spaces.
	  02 SEC-out  		pic x(2).
	  02 filler 		pic x(1) value spaces.
	  02 SaleYear-out  	pic 9(4).
	  02 filler 		pic x(1) value spaces.
	  02 SalePrice-out 	pic $z(3),z(2)9.99.
	  02 filler 		pic x(1) value spaces.
	  02 PricePerSqft-out   pic $z(2)9.99.
	  02 filler 		pic x(1) value spaces.
	  02 EstimateValue-out  pic $z(3),z(2)9.99.
          02 filler 		pic x(1) value spaces.
	

       01 Average-Bottom.
          02 filler             pic x(51) value spaces.
	  02 bed-average-out    pic 9(1).9.
	  02 filler		pic x(1) value spaces.
	  02 bath-average-out   pic 9(1).9.
	  02 filler		pic x(1) value spaces.
	  02 SqFt-average-out   pic z(3)9.9.
	  02 filler             pic x(34) value spaces.
	  02 SP-average-out     pic $(9)9.99.
          02 filler             pic x(22) value spaces.

       01 Variables-v.
	  02 SquareFeet-count	pic 9(4)v99 value 0.	
  	  02 Estimation         pic 9(7)v99 value 0.  
	  02 SP-per-SF          pic 9(4)v99 value 0.
	  02 Bed-accum		pic 9(4) value 0.
	  02 Bath-accum		pic 9(4) value 0.
	  02 SquareFeet-accum   pic 9(8) value 0.
	  02 SP-accum		pic 9(10) value 0.
	  02 Hold-for-calc-bd   pic 9(5)v99 value 0.
	  02 Hold-for-calc-bt   pic 9(5)v99 value 0.
	  02 Hold-for-calc-sf   pic 9(5)v99 value 0.
	  02 Hold-for-calc-sp   pic 9(10)v99 value 0.
	  02 Rec-count          pic 9(4) value 0.

      *new
       01 Num2Str.
 	  02 filler             pic x(5) value "zero".	
          02 filler             pic x(5) value "one".
	  02 filler             pic x(5) value "two".	
	  02 filler             pic x(5) value "three".	
	  02 filler             pic x(5) value "four".	
	  02 filler             pic x(5) value "five".	
	  02 filler             pic x(5) value "six".	

      *new
       01 Num2Str-table redefines Num2Str.
	  02 Num occurs 7 times pic x(5).
    
      *new
       01 Accum-table.
	  02 bsp occurs 6 times pic 9(6)v99 value 0.

      *new
       01 bed-sp-out	        pic $z(3),z(2)9.99.

      *new
       01 table-column-header.
	  02 filler 		pic x(57) value spaces.
	  02 filler 		pic x(7) value "BedRoom".
	  02 filler 		pic x(1) value spaces.
	  02 filler 		pic x(10) value "SalesPrice".
	  02 filler 		pic x(57) value spaces.



       01 Number-of-files-line.
	  02 filler 		pic x(30) value 
	  "Number of Records Processed : ".
	  02 Rec-count-out      pic z(4).
	  02 filler 		pic x(98) value spaces.
	   
       01 Footer.
          02 filler 		pic x(59) value spaces.
	  02 filler 		pic x(14) value " End Of Report".
	  02 filler 		pic x(59) value spaces.

       01 error-flag            pic x(3) value "No".
	  88 error-occur        value "Yes".

       01 eof-flag              pic x(3) value "No".
       
      *new
       01 page-flag             pic x(3) value "No".


       Procedure Division.

      ********procedures, and stop running******************************************************
       0000-main-logic.

          Perform 1000-init.

	  Perform 2000-main-loop
	  until eof-flag = "Yes".

	  move spaces to Output-rec.
	  Write Output-rec.

	  Perform 3000-finish.
          STOP RUN.


      *new
       0100-blankline.
	  Move spaces to Output-rec.
	  write Output-rec
	  at eop move "Yes" to page-flag.

      *new
       0200-next-page.
	  Write Output-rec from Page-number-line 
            after advancing 2 lines.
          Add 1 to Page-number.
	  Move "Yes" to page-flag.
	  write Output-rec from table-column-header 
	    after advancing page. 
    	   
      ********open files, print headers, and read first file************************************
       1000-init.

	  Accept todays-date from DATE YYYYMMDD.
	  move Years to year-out.
	  move Months to month-out.
	  move Days to day-out.
		
	  open Input Input-file.
          open Output Output-file
		      Error-file.	
		   
	  move spaces to Output-rec.
	  Write Output-rec.
		   
	  write Output-rec from Report-Header.
		  
	  move spaces to Output-rec.
          Write Output-rec.
		   
          Write Output-rec from Colomn-Header.
		   
	  move spaces to Output-rec.
	  Write Output-rec.
		   
	  read Input-file at end move "Yes" to eof-flag.

      *new
       1200-write-column-header.
	  Write Output-rec from Page-number-line after advancing 2 lines.
	  Write Output-rec from Colomn-Header after advancing page.
	  perform 0100-blankline.
	  Add 1 to Page-number.

      ********first increment the counter,******************************************************
      ********move everything and print for the content.****************************************
       2000-main-loop.
	  perform 2100-validation.
	  If error-occur then
	     perform 2999-error
	  else
	     perform 2200-process.
          read Input-file at end move "Yes" to eof-flag.

      *Validate the input data.
       2100-validation.
	  if not valid-state or not valid-PropertyType then
	     move "Yes" to error-flag.
	  if Bedroom not numeric
	     move "Yes" to error-flag.
	  if Bathroom not numeric
	     move "Yes" to error-flag.
	  if SquareFeet not numeric
	     move "Yes" to error-flag.
	  if SalePrice not numeric
	     move "Yes" to error-flag.
 
       2200-process.
      ********count for the number of times this loop runs**************************************
	  Add 1 to Rec-count.
      ********moving data from input file*******************************************************		  
	  move Addresses to Addresses-out.
	  move City to City-out.
	  move Zip to Zip-out.
	  move State to State-out.

      *new
          move Num(Bedroom + 1) to Bedroom-out.

	  move Bathroom to Bathroom-out.
	  move SquareFeet to Squarefeet-out.
	  move Propertytype to Propertytype-out.
	  move SaleDay to SaleDay-out.
	  move SaleMonth to SaleMonth-out.
	  move SaleYear to SaleYear-out.
	  move SalePrice to SalePrice-out.
	  move SalesDay to DY-out.
	  move SalesHour to HR-out.
	  move SalesMinute to MIN-out. 
	  move SalesSecond to SEC-out.

      *new
	  if Bedroom is not = 0 then
	     add SalePrice to bsp(Bedroom).

 
      ********loop prepare for calculation******************************************************     
	  if SquareFeet = 0 then
	     move 0 to PricePerSqft-out
          else
	     compute SP-per-SF = SalePrice/SquareFeet
	     move SP-per-SF to PricePerSqft-out
	     add 1 to SquareFeet-count
	     add Bedroom to Bed-accum
	     add Bathroom to Bath-accum
	     add SquareFeet to SquareFeet-accum
	     add SalePrice to SP-accum.

      ********New loop for city speciication****************************************************
	  if City = "SACRAMENTO" or "RIO LINDA" then
	     compute Estimation = SalePrice*1.18
	  else
	     compute Estimation = SalePrice*1.13.

	  move Estimation to EstimateValue-out.
	 
      *new
          Write Output-rec from Info-line at eop 
	  perform 1200-write-column-header.
		  
     	  
      ******** print to the error file, if the data is wrong **********************************
       2999-error.
	  write Error-rec from Input-rec.
	  If not valid-state then
	     move "Invalide State" to Error-rec
	     write Error-rec.
	  If not valid-PropertyType then
	     move "Invalide PropertyType" to Error-rec
	     write Error-rec.
	  if Bedroom not numeric
	     move "Bedroom is Not Numeric" to Error-rec
	     write Error-rec.
	  if Bathroom not numeric
	     move "Bathroom is Not Numeric" to Error-rec
	     write Error-rec.
	  if SquareFeet not numeric
	     move "SquareFeet is Not Numeric" to Error-rec
	     write Error-rec.
	  if SalePrice not numeric
	     move "SalePrice is Not Numeric" to Error-rec
	     write Error-rec.
	  Move "No" to error-flag.

      ********This paragraph write the footer,**************************************************
      ********counter of steps and close the file.**********************************************  
       3000-finish.

      ********calculation for the average line**************************************************
	  compute Hold-for-calc-bd = Bed-accum/SquareFeet-count.
          move Hold-for-calc-bd to bed-average-out.
	  
          compute Hold-for-calc-bt = Bath-accum/SquareFeet-count.
          move Hold-for-calc-bt to bath-average-out.

          compute Hold-for-calc-sf = SquareFeet-accum/SquareFeet-count.
          move Hold-for-calc-sf to SqFt-average-out.

          compute Hold-for-calc-sp = SP-accum/SquareFeet-count.
          move Hold-for-calc-sp to SP-average-out.
	
      ********print out the line of average for bed bath square feet and sale price*************
	  write output-rec from Average-Bottom.
 
	  move Rec-count to Rec-count-out.

      ********print string along with the number of time the main loop runs*********************
   	  write Output-rec from Number-of-files-line.
	  
	  move spaces to Output-rec.
          Write Output-rec.
		  
      ********print out the footer**************************************************************
	  write Output-rec from Footer.

      *new
	  perform 0100-blankline until 
	  page-flag = "Yes".
	  perform 0200-next-page.
		   
	  close Input-file.
	   
	 