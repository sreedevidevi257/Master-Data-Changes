table 50118 "Supplier Delivery Report Buffe"
{
    
    fields
    {
        field(1;"Item No.";Code[20])
        {
            
        }
        field(2;"Vendor No.";Code[20])
        {
             
        }
        field(3;"Item Description";Text[50])
        {
             
        }
        field(4;"Last Purchase Vendor";Text[50])
        {
             
        }
        field(5;"Product Group Code";Code[20])
        {
             
        }
        field(6;"Last Year Volume";Decimal)
        {
             
        }
        field(7;"YTD Volume";Decimal)
        {
             
        }
        field(8;"Last Year Last Paid Price LCY";Decimal)
        {
            Caption = 'Last Year Last Paid Price (LCY)';
             
        }
        field(9;"YTD Last Paid Price (LCY)";Decimal)
        {
            Caption = 'YTD Last Paid Price (LCY)';
             
        }
        field(10;"Last Year Last Paid Price FCY";Decimal)
        {
            Caption = 'Last Year Last Paid Price (FCY)';
             
        }
        field(11;"YTD Last Paid Price (FCY)";Decimal)
        {
             
        }
        field(12;"Invoice Currency";Code[10])
        {
             
        }
        field(13;"Supplier Lead Time From Order";DateFormula)
        {
            Caption = 'Supplier Lead Time From Order To Delivery';
             
        }
        field(14;"Article Minimum Order Quantity";Decimal)
        {
             
        }
        field(15;"Inventory Level End Of Month";Decimal)
        {
             
        }
        field(16;"Unit of Measure";Code[10])
        {
             
        }
        field(17;"Last Purchased Volume";Decimal)
        {
             
        }
        field(18;"Consumption Volume Last Year";Decimal)
        {
             
        }
        field(19;"Consumption Volume YTD";Decimal)
        {
             
        }
        field(20;"Supplier Country Code";Code[10])
        {
             
        }
        field(21;"Supplier City";Text[50])
        {
             
        }
        field(22;"Supplier Street Address";Text[50])
        {
             
        }
        field(23;"Supplier Postal Code";Code[20])
        {
             
        }
        field(24;"Supplier Phone No.";Text[30])
        {
             
        }
        field(25;"Material Standard Code";Code[10])
        {
             
        }
        field(26;"Payment Terms";Code[10])
        {
             
        }
        field(27;"Local ERP Supplier ID";Code[20])
        {
             
        }
        field(28;Incoterm;Code[10])
        {
             
        }
        field(29;"Incoterm Location";Code[20])
        {
             
        }
        field(30;"Volume Rejected LY";Decimal)
        {
             
            DecimalPlaces = 0:5;
        }
        field(31;"Volume Rejected YTD";Decimal)
        {
             
            DecimalPlaces = 0:5;
        }
        field(32;"Number of claims LY";Integer)
        {
             
        }
        field(33;"Number of claims YTD";Integer)
        {
             
        }
        field(34;"Requested Early Delivery";Integer)
        {
            Caption = 'PO Line Count Early Delivery against Requested Date YTD';
             
        }
        field(35;"Requested On Time Delivery";Integer)
        {
            Caption = 'PO Line Count On Time Delivery against Requested Date YTD';
             
        }
        field(36;"Requested Late Delivery";Integer)
        {
            Caption = 'PO Line Count Date Delivery against Requested Date YTD';
             
        }
        field(37;"Confirmed Early Delivery";Integer)
        {
            Caption = 'PO Line Count Early Delviery against 1st Confirmed Date YTD';
             
        }
        field(38;"Confirmed On Time Delivery";Integer)
        {
            Caption = 'PO Line Count On Time Delviery against 1st Confirmed Date YTD';
             
        }
        field(39;"Confirmed Late Delivery";Integer)
        {
            Caption = 'PO Line Count Late Delivery against 1st Confirmed Date YTD';
             
        }
        field(40;"Agreed Early Delivery";Integer)
        {
            Caption = 'PO Line Count Early Delivery against Agreed Lead Time YTD';
             
        }
        field(41;"Agreed On Time Delivery";Integer)
        {
            Caption = 'PO Line Count On Time Delivery agaisnt Agreed Lead Time YTD';
             
        }
        field(42;"Agreed Late Delivery";Integer)
        {
            Caption = 'PO Line Count Late Delivery against Agreed Lead Time YTD';
             
        }
        field(43;"Vendor Name";Text[50])
        {
             
        }
    }

    keys
    {
        key(Key1;"Item No.","Vendor No.")
        {
        }
    }

    fieldgroups
    {
    }
}

