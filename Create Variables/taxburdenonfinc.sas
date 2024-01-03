*this program creates the tax Burden on Foreign Income;
libname tmp1 '\\apporto.com\dfs\SEA\Users\s116_sea\Desktop\FinANa\SAAS';
run;
data a1; set tmp1.taxdataset;
gvkey2=gvkey*1;
nyear = year(datadate);
if PIFO="." then PIFO=0;
if TXFO="." then TXFO=0;
if che="." then delete;
if at="." then delete;
if (at-che)=0 then delete;
data a2; set a1;
if 0.35*PIFO < TXFO then TaxBurdenOnFInc=0;
else TaxBurdenOnFInc = (((0.35 * PIFO)-TXFO)/(AT-CHE))*100;
data a3; set a2;
*proc print data=a3 (obs=100); *run;
if TaxBurdenOnFInc ne ".";
if nyear>=1975;
keep gvkey2 nyear AT CHE PIFO TXFO TaxBurdenOnFInc;
proc sort nodupkey; by gvkey2 nyear; 
data a4; set a3;
*proc print data=a4 (obs=100); *run;
keep gvkey2 nyear TaxBurdenOnFInc;
proc sort nodupkey; by gvkey2 nyear; 
data a5; set a4;
proc print data=a5 (obs=100); run;
data tmp1.TaxBurdenOnFInc1; set a5;
data tmp1.TaxBurdenOnFInc2; set a5;
data tmp1.TaxBurdenOnFInc3; set a5;
data tmp1.TaxBurdenOnFInc4; set a5;
proc means; run;


