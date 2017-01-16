select 
  barcode, 
  homebranch, 
  itype 
from 
    items 
    left join old_issues using (itemnumber) 
where 
    onloan is null 
    and old_issues.itemnumber is null 
    and notforloan=0 
    and damaged=0 
    and itemlost=0 
    and withdrawn=0 
limit 10;
