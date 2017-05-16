      *required
	   Identification Division.
           
      *first part require, second user chosen name
       Program-id. Seventh-Prog.

      *turnin-csi203 -c csi203 -p prog7 prog7.cob
	  
      *print out the date when compile
       Date-compiled.
	   
      *****************************************************************
      *required
       Environment Division.
	   Input-Output Section.
       File-Control.
      *line is sequential is required
           select Input-file assign to 
           "/home1/c/a/acsi203/realestate.dat".

	   select Input-City-file assign to 
	   "/home1/c/a/acsi203/cityrates.dat".

	   select Sort-work-file assign to 
           "Sort.dat".

	   select Output-file assign to
	   "review_out.dat"
           organization is line sequential.

           select Error-file assign to
	   "review_Error_Out.dat"
	   organization is line sequential.
       
      *****************************************************************
      *required
       Data Division.
       File Section.
       
      *declaration of input file
       FD Input-file.

      *name of the record
       01 Input-rec. 

      *detail of the record
           02 Addresses          pic x(27). 
           02 City               pic A(15).     
	   02 Zip                pic x(5).     
	   02 State              pic x(2).
      *condition name, user chosen name
	     88 valid-state        value "CA".  
           02 Bedroom            pic 9(1).   
	   02 Bathroom           pic 9(1).
	   02 SquareFeet      	 pic 9(4).
	   02 PropertyType       pic x(8).
      *condition name, spcae in between
	     88 valid-PropertyType value "Resident" "Condo" "Multi-Fa".   
	   02 SaleDay		 pic x(3).    
	   02 filler 		 pic x(1).  
	   02 SaleMonth          pic x(3).    
	   02 filler 		 pic x(1). 
	   02 SalesDay           pic 9(2).
	   02 filler             pic x(1).
	   02 SalesHour          pic 9(2).   
	   02 filler             pic x(1). 	 
           02 SalesMinute        pic 9(2).
	   02 filler             pic x(1).
	   02 SalesSecond        pic 9(2).
	   02 filler             pic x(1). 
	   02 TimeZone 	         pic A(3).
	   02 filler             pic x(1).
	   02 SaleYear	         pic 9(4).
	   02 SalePrice   	 pic 9(6).
	   02 PropertyLatitude   pic 9(8).
	   02 PropertyLongtitude pic 9(9).
      *must have, type writer
  	   02 filler 		 pic x(1).
          
      *declaration for sort work, same picture clauces as sorting file
       SD Sort-work-file.

      *name of the sort work
       01 Sort-work-rec.

      *detail line for sort file
           02 filler             pic x(27).
           02 City-s             pic A(15). 
           02 filler             pic x(7).
           02 Bedroom-s          pic 9(1).   
	   02 Bathroom-s         pic 9(1).
           02 filler             pic x(64).
       
      *declaration of city multipler rate file      
       FD Input-City-file.

      *detail line for city multipler rate file
       01 City-input-rec.
           02 City-t             pic A(15).
	   02 Multiplier-Rate    pic v999.
      *must have, type writer
  	   02 filler 		 pic x(1).
          
      *declaretion of the output file,
      *and the linage of the page
       FD Output-file
	  Linage is 58 lines with footing at 56
          Lines at top 5 lines at bottom 5.
          
      *number of spaces per line
       01 Output-rec            pic x(132).

      *declaretion of the error- file
       FD Error-file.

      *number of spaces per line
       01 Error-rec	        pic x(132).
       
      *****************************************************************
      *required
       Working-Storage Section.
       
      *77 level variables
       77 table-index		pic 99 value 0.
       77 loading-index 	pic 99 value 0.
       77 column-index		pic 99 value 0.
       77 row-index		pic 99 value 0.
      *accumulation
       77 SquareFeet-count      pic 9(4)v99 value 0.	
       77 Estimation            pic 9(7)v99 value 0.  
      *sale price per square feet       
       77 SP-per-SF             pic 9(4)v99 value 0.
      *accumulator
       77 Bed-accum		pic 9(4) value 0.
       77 Bath-accum		pic 9(4) value 0.
       77 SquareFeet-accum      pic 9(8) value 0.
       77 SP-accum		pic 9(10) value 0.
      *averages calculation
       77 Hold-for-calc-bd      pic 9(5)v99 value 0.
       77 Hold-for-calc-bt      pic 9(5)v99 value 0.
       77 Hold-for-calc-sf      pic 9(5)v99 value 0.
       77 Hold-for-calc-sp      pic 9(10)v99 value 0.
       77 Rec-count             pic 9(4) value 0.
      *variable for new sale price
       77 summation             pic 9(10)v99 value 0.
      *variables for break control
       77 subBreak-var          pic 9(1) value 0. 
       77 Break-var             pic x(15).
       77 subBreak-accum        pic 9(10)v99 value 0.
       77 Break-accum           pic 9(10)v99 value 0.
       01 Testing-line.
          02 filler             pic x(25) value spaces.
          02 filler             pic x(5) value "tests".

      *print out the number line at the bottom of the page
       01 Page-number-line.
	  02 filler 		pic x(64) value spaces.
	  02 filler 		pic x value "-".
	  02 Page-number	pic 99 value 1.
	  02 filler 		pic x value "-".
	  02 filler 		pic x(64) value spaces.

      *print report header at the very beginning of the prog
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

      *hold date information
       01 todays-date.
	  02 Years		pic 9(4).
	  02 Months		pic 9(2).
	  02 Days		pic 9(2).

      *print out the colomn header	   
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
	   
      *out put of input-rec
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
	
      *output of averages
       01 Average-Bottom.
          02 filler             pic x(51) value spaces.
	  02 bed-average-out    pic 9(1).9.
	  02 filler		pic x(1) value spaces.
	  02 bath-average-out   pic 9(1).9.
	  02 filler		pic x(1) value spaces.
	  02 SqFt-average-out   pic z(3)9.9.
	  02 filler             pic x(34) value spaces.
	  02 SP-average-out     pic $zzz,zzz,zz9.99.
       
      *hardcode bedroom number
      * user chosen name, group item name Num2Str
       01 Num2Str.
 	   02 filler            pic x(5) value "zero".	
           02 filler            pic x(5) value "one".
	   02 filler            pic x(5) value "two".	
	   02 filler            pic x(5) value "three".	
	   02 filler            pic x(5) value "four".	
	   02 filler            pic x(5) value "five".	
	   02 filler            pic x(5) value "six".	
           
      *table for hardcoded numbers, correspondingly
       01 Num2Str-table redefines Num2Str.
	   02 Num occurs 7 times 
 		 		pic x(5).
       
      *creating a table for accumulation
       01 Accum-table.
      *user chosen name ,bsp, Bed sale price
	   02 bsp occurs 6 times 
 		 		pic 9(10)v99 value 0.      

      *just header for the one dimentional table          
       01 table-column-header.
	   02 filler 		pic x(55) value spaces.
	   02 filler 		pic x(7) value "BedRoom".
	   02 filler 	        pic x(1) value spaces.
	   02 filler 	        pic x(10) value "SalesPrice".
	   02 filler 	        pic x(59) value spaces.
          
      *detail line for the one dimentional table
       01 table-column-out.
	   02 filler 	        pic x(55) value spaces.
	   02 tb-bed-out 	pic x(7).
	   02 filler 		pic x(1) value spaces.
	   02 tb-sp-out 	pic $z(3),z(3),z(2)9.99.
	   02 filler 		pic x(54) value spaces.

      *header for the two dimentional table          
       01 last-table-header-out.
	   02 filler 		pic x(5) value spaces.
	   02 filler 		pic x(5) value "Baths".
	   02 filler  		pic x(17) value spaces.
	   02 filler  		pic x(1) value "1".
	   02 filler  		pic x(17) value spaces.
	   02 filler  		pic x(1) value "2".
	   02 filler  		pic x(17) value spaces.
	   02 filler  		pic x(1) value "3".
	   02 filler  		pic x(17) value spaces.
	   02 filler  		pic x(1) value "4".
	   02 filler  		pic x(17) value spaces.
	   02 filler  		pic x(1) value "5".
	   02 filler  		pic x(32) value spaces.          
      
      *two dimentional table, header for the row header
       01 bed-title.
	   02 filler  		pic x(5) value spaces.
	   02 filler  		pic x(5) value "Bedrm".
	   02 filler  		pic x(122) value spaces.
          
      *print our number fo records read
       01 Number-of-files-line.
	   02 filler  		pic x(30) value 
	   "Number of Records Processed : ".
	   02 Rec-count-out     pic z(4).
	   02 filler  		pic x(98) value spaces.

      *print out the line "end of report"
       01 Footer.
	   02 filler  		pic x(59) value spaces.
	   02 filler  		pic x(14) value " End Of Report".
	   02 filler  		pic x(59) value spaces.
          
      *error flag
       01 error-flag            pic x(3) value "No".
      *condition name 
	   88 error-occur        value "Yes".
          
      *end of page flag 
       01 eof-flag              pic x(3) value "No".
      *condition name
	   88 end-reach          value "Yes". 
       
      *this flag check if it is the end of the page of not
       01 page-flag             pic x(3) value "No".
      
      *table for holding information from the new input file
       01 city-mutiplier-table.
	   02 citizes occurs 22 times
	   indexed by city-index
	   ascending key is Citi-table .
	     03 Citi-table      pic A(15).
	     03 mitip-table     pic v999.

      *for holding the 2 dimentional table content              
       01 sale-price-accum-table.
	   02 accum-bed occurs 6 times.
	         03 accum-bath occurs 5 times 
	            pic 9(10)v99 values 0.
                                
      *for printing out the 2 dimentional table content.                  
       01 last-table-out.
	   02 filler  		pic x(5) value spaces.
	   02 bedroom-number-out pic 9.
	   02 filler  		pic x(10) value spaces.
	   02 something occurs 5 times.
              03 bed-bath-acum-out 
                                pic $z,zzz,zzz,zz9.99.
	      03 filler  	pic x(3) value spaces.
             
      *output for bedroom break, for print out
       01 Bedroom-break.
	   02 filler            pic x(88) value spaces.
	   02 filler            pic x(9)    
         		value "Total for".
	   02 filler            pic x(1) value spaces.
	   02 bdrm-num          pic 9.
	   02 filler            pic x(11) value " Bedroom(s)".
	   02 filler            pic x(3) value spaces.
	   02 filler            pic x(1) value ":".
	   02 filler            pic x(1) value spaces.
	   02 bd-break-accum    pic $z,zzz,zzz,zz9.99.
       
      *output for city break, for print out
       01 City-break.
	   02 filler            pic x(98) value spaces.
	   02 city-name         pic x(15).
	   02 filler            pic x(1) value ":".
	   02 filler            pic x(1) value spaces.
	   02 city-break-accum  pic $z,zzz,zzz,zz9.99.
          
      ***********************************************************
       Procedure Division.

      *Main section,Sortwork section
       0000-main section.

      *Sort work in particular order 
      *Separate input and output into pre and post process section
       0000-main-logic.
          Sort sort-work-file
          on ascending key City-s
	  on ascending key Bedroom-s
	  on ascending key Bathroom-s
          input procedure is 4000-preprocess
          output procedure is 5000-postprocess.
          STOP RUN.

      *preprocess section, handle everything that goes in, 
      *including sorting and validation
       4000-preprocess section.

      *main logic for preprocess section
       4000-main-logic.
          Perform 1000-init.
          Perform 2000-main-loop until end-reach.
          Perform 3000-finish.
          Go to 4999-Exit.

      *open files and read the first record
       1000-init.
	  open Input Input-file.
          open Output Error-file.
	  read Input-file at end move "Yes" to eof-flag.

      *loop for processing the data;
      *validate wether it is error or should be sorted;
       2000-main-loop.
	  perform 2100-validation.
	  If error-occur then
	     perform 2999-error
	  else
	     release Sort-work-rec
             from Input-rec.
          read Input-file at end move "Yes" to eof-flag.

      *validate wether the data is good or bad
       2100-validation.
	  if not valid-state or not valid-PropertyType
	     move "Yes" to error-flag.
	  if Bedroom not numeric
	     move "Yes" to error-flag.
	  if Bathroom not numeric
	     move "Yes" to error-flag.
	  if SquareFeet not numeric
	     move "Yes" to error-flag.
	  if SalePrice not numeric
	     move "Yes" to error-flag.
     	  
      *write correponding string to error file 
      *based on what type of error it is
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

      *close all opened file in this section
       3000-finish.
          Close Input-file 
                Error-file.
 
      *exit
       4999-Exit.
          Exit.

      *post process section, handle all data and write it to the output
       5000-postprocess section.

      *main logic for post process section
       5000-main-logic.
          Perform 5100-init.
          Perform 2200-process 
            until end-reach.
          Perform 3000-finish.
          Go to 5999-Exit.

      *print out the current date
      *open files
      *load in the city multiplier rate into a table
      *print out the first column header
      *read the very first data that sorted in the sort work file.
      ***P.s. moving No to eof flag to make sure that it would read
      *initializing the hold variable for control break
       5100-init.

          Accept todays-date from DATE YYYYMMDD.
	  move Years to year-out.
	  move Months to month-out.
	  move Days to day-out.

          Open Input Input-city-file.
          Open Output Output-file.

          Perform 0301-load-table 
	  varying city-index from 1 by 1 
	  until  city-index > 22.
      
	  write Output-rec from Report-Header.
		  
	  Perform 0100-blankline.
		   
          Write Output-rec from Colomn-Header.
		   
	  Perform 0100-blankline.

          Move "No" to eof-flag.
          return sort-work-file into Input-rec
            at end move "Yes" to eof-flag.

          Move City to Break-var.
          Move Bedroom to subBreak-var.

      *Write out blank lines.
       0100-blankline.
	  Move spaces to Output-rec.
	  write Output-rec
	  at eop move "Yes" to page-flag.

      *write out the current page number 
      *then go to the next page 
      *and print out the table header
       0200-next-page.
	  Write Output-rec from Page-number-line.
          Add 1 to Page-number.
	  move "No" to page-flag.
	  write Output-rec from table-column-header 
	    after advancing page. 

      *write out the current page number 
      *then go to the next page 
      *and print out the table header
       0201-next-page.
	  Write Output-rec from Page-number-line.
          Add 1 to Page-number.
	  move "No" to page-flag.
	  write Output-rec from last-table-header-out
	    after advancing page. 
	  write Output-rec from bed-title.

      *move item to fill out the table
       0300-Bed-SP-Table.
	  move Num(table-index + 1) to tb-bed-out.
	  move bsp(table-index) to tb-sp-out.
	  write Output-rec from table-column-out.

      *print out the table
       0301-Bed-Bath-Table.
	  move row-index to bedroom-number-out.
	  perform 0311-table-rows
          varying column-index from 1 by 1
	    until column-index > 5.
           write Output-rec from last-table-out.

      *move item from the input file and load it into table for future use  
       0301-load-table.
          read Input-City-file.
          move City-t to Citi-table(city-index).
          move Multiplier-Rate to mitip-table(city-index).
  
      *make sure that we don't calculate anything with 0 bath or bed
      *because there has no table index with 0
       0302-bed-bath-check.
          if Bedroom not equal to 0
          and Bathroom not equal to 0 then
            add summation to accum-bath(Bedroom,Bathroom).

      *moving the accumulation to the corresponding place
       0311-table-rows.
	  move accum-bath(row-index,column-index)
	    to bed-bath-acum-out(column-index).

      *print out the current page number
      *print out the column header on the next page 
      *along with a blank line. 
      *increase the page number counter
       1200-write-column-header.
	  Write Output-rec from Page-number-line.
	  Write Output-rec from Colomn-Header
            after advancing page.
          Perform 0100-blankline.
	  Add 1 to Page-number.
     
      *bedroom break
       whatsoever.
          Move subBreak-var to bdrm-num.
          Move subBreak-accum to bd-break-accum.  
          Write Output-rec from Bedroom-break
             at eop perform 1200-write-column-header.		 
          Move 0 to subBreak-accum.
          Move Bedroom to subBreak-var.
     
      *city break
       whatsoever2.
          Move Break-var to city-name.
          Move Break-accum to city-break-accum.
          Write Output-rec from City-break
             at eop perform 1200-write-column-header.
          Move 0 to Break-accum.
          Move City to Break-var.

      *processing everything and move them to output rec
      *calculate the modified sale prices
      *then print it out
      *at last read the next record
       2200-process.
	  Add 1 to Rec-count.		  
	  move Addresses to Addresses-out.
	  move City to City-out.
	  move Zip to Zip-out.
	  move State to State-out.
          move Num(Bedroom + 1) to Bedroom-out.
	  move Bathroom to Bathroom-out.
	  move SquareFeet to Squarefeet-out.
	  move Propertytype to Propertytype-out.
	  move SaleDay to SaleDay-out.
	  move SaleMonth to SaleMonth-out.
	  move SaleYear to SaleYear-out.
	  move SalesDay to DY-out.
	  move SalesHour to HR-out.
	  move SalesMinute to MIN-out. 
	  move SalesSecond to SEC-out.
     
          Search All citizes
          when City = Citi-table(city-index)
          compute summation = SalePrice*(1+mitip-table(city-index)).

          move summation to SalePrice-out.

      *break control statements/loop
          if City is not equal to Break-var
             Perform whatsoever
             Perform whatsoever2
             Move space to Output-rec
             Write Output-rec
          else if Bedroom is not equal to subBreak-var 
                Perform whatsoever
                Move space to Output-rec
                Write Output-rec.
   
      *add saleprice to the accummulator for the break control
          Add summation to subBreak-accum.
          Add summation to Break-accum.
	  
          perform 0302-bed-bath-check.

	  if City = "SACRAMENTO" or "RIO LINDA" then
	     compute Estimation = summation*1.18
	  else
	     compute Estimation = summation*1.13.

	  move Estimation to EstimateValue-out.
	 
      *not processing data with O bedroom
      *no table index 0
	  if Bedroom is not = 0 then
	     add summation to bsp(Bedroom).  
 
	  if SquareFeet = 0 then
	     move 0 to PricePerSqft-out
          else
	     compute SP-per-SF = summation/SquareFeet
	     move SP-per-SF to PricePerSqft-out
	     add 1 to SquareFeet-count
	     add Bedroom to Bed-accum
	     add Bathroom to Bath-accum
	     add SquareFeet to SquareFeet-accum
	     add summation to SP-accum.

          Write Output-rec from Info-line at eop 
	  perform 1200-write-column-header.

          return sort-work-file into Input-rec
            at end move "Yes" to eof-flag.
		  
      *print out the last control break
      *print out average line
      *print out the last two table along with page number;
      *close opened file in this section
       3000-finish.

          Perform whatsoever.
          Perform whatsoever2.

	  compute Hold-for-calc-bd = Bed-accum/SquareFeet-count.
          move Hold-for-calc-bd to bed-average-out.
	  
          compute Hold-for-calc-bt = Bath-accum/SquareFeet-count.
          move Hold-for-calc-bt to bath-average-out.

          compute Hold-for-calc-sf = SquareFeet-accum/SquareFeet-count.
          move Hold-for-calc-sf to SqFt-average-out.

          compute Hold-for-calc-sp = SP-accum/SquareFeet-count.
          move Hold-for-calc-sp to SP-average-out.
	
	  write output-rec from Average-Bottom.
 
	  move Rec-count to Rec-count-out.

   	  write Output-rec from Number-of-files-line.
	  
	  move spaces to Output-rec.
          Write Output-rec.
		  
	  Move "No" to page-flag.
	  perform 0100-blankline until 
	  page-flag = "Yes".

	  perform 0200-next-page.

	  perform 0300-Bed-SP-Table
	  varying table-index from 1 by 1
	    until table-index > 6.
 
	  perform 0100-blankline until 
	  page-flag = "Yes".

	  perform 0201-next-page.

	  perform 0301-Bed-Bath-Table
	  varying row-index from 1 by 1
	    until row-index > 6.

	  Perform 0100-blankline.
          write Output-rec from Footer.

	  perform 0100-blankline until 
	  page-flag = "Yes".

	  Write Output-rec from Page-number-line. 
	  	
	  close Input-city-file
		Output-file.
  
       5999-Exit.
          Exit.


	   