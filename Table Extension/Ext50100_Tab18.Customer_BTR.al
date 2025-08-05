tableextension 50100 "TabExt50100_Customer_BTR" extends Customer
{
    fields
    {
        // Add changes to table fields here
        field(50100;Channel;Option)     //Not to be deployed into Production.
        {                 
            OptionCaption = ',Wholesalers,Trade Merchants,OEM Doors & Windows,OEM Industrial,OEM Access Control,Locksmiths,System Integrators,Contractors,PEU,Retail,e-Retailers,Consumer Direct,e-Consumer Direct,Others';
            OptionMembers = ,Wholesalers,"Trade Merchants","OEM Doors & Windows","OEM Industrial","OEM Access Control",Locksmiths,"System Integrators",Contractors,PEU,Retail,"e-Retailers","Consumer Direct","e-Consumer Direct",Others;
            BlankZero = true;
            
        }
        field(50101;"Customer Channel";Text[20])
        {     
            TableRelation = "Customer Channel";     
            ValidateTableRelation = true;      
        }
        field(50102;"Trade License No.";Text[20])
        {
            trigger OnValidate();
            var 
                TradeLicenseUniqueError : TextConst ENU='A customer with the same Trade License No. already exists. Please specify a unique Trade License No.';
                Customer : Record Customer;            
            begin 
                IF (UPPERCASE("Trade License No.") <> 'N/A') and (UPPERCASE("Trade License No.") <> 'NA') THEN  begin 
                    Customer.reset;
                    customer.setrange("Trade License No.","Trade License No.");
                    if not Customer.IsEmpty then  
                        Error(TradeLicenseUniqueError);
                end;
            end;
        }
    }
    

}