tableextension 50115 "Ext50115-PurchaseLine" extends "Purchase Line"
{
    fields
    {
        field(50100;"Last Year Purchase Price";Decimal)
        {
            Editable=false;
        }
        field(50101;"Last Direct Purchase Price";Decimal)
        {
            Editable=false;
        }
        field(50102;"Actual Received Date";Date)
        {

        }
        modify("No.")
        {
            trigger OnAfterValidate();
            var 
                Item : Record Item;
            begin 
                item.reset; 
                If not Item.get("No.") then  
                    Item.init;
                "Last Direct Purchase Price" := Item."Last Direct Cost";
                Modify;
            end;
        }
    }
}