tableextension 50102 "TabExt50102_Item_BTR" extends "Item"
{
    fields
    {        
        Modify("Vendor Item No.")
        {
            Caption = 'Manufacturer code ';
        }
         Modify("Tariff No.")
        {
            Caption = 'HS Code ';
        }
        // Add changes to table fields here
        field(50100;"HIP Code";Code[20])
        {
          TableRelation = HIP;  
          ValidateTableRelation =  true;
        } 
        field(50101;"Last Year Purchase Price";Decimal)
        {
            
        }
        field(50102;"Sub Category 1";Code[20])
        {
            TableRelation = "Item Sub Category 1";
            ValidateTableRelation = true; 
        }
        field(50103;"Sub Category 2";Code[20])
        {
            TableRelation = "Item Sub Category 2";
            ValidateTableRelation = true; 
        }       
    }
    
    trigger OnBeforeInsert();
    var 
        InvSetup : Record "Inventory Setup";
    begin 
        InvSetup.GET;
        "Costing Method" := InvSetup."Default Costing Method";
    end;
}