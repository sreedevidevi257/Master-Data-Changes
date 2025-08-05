page 50106 "Purchase Order Delivery"
{
    UsageCategory = Lists;
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Purchase Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No.";"Document No.")
                {
                }
                field("PO Date";PurchHdr."Order Date")
                {                    
                }
                field("No.";"No.")
                {
                }
                field(Quantity;Quantity)
                {
                }
                field("Unit Price (LCY)";"Unit Price (LCY)")
                {
                }
                field("Line Amount";"Line Amount")
                {
                }
                field("Planned Receipt Date";"Planned Receipt Date")
                {
                }
                field("Expected Receipt Date";"Expected Receipt Date")
                {
                }
                field("Promised Receipt Date";"Promised Receipt Date")
                {
                }
                field("Requested Receipt Date";"Requested Receipt Date")
                {
                }
                field("Buy-from Vendor No.";"Buy-from Vendor No.")
                {
                }
                field("Supplier Name";Vendor.Name)
                {
                }
                field("Supplier Category";Vendor."Supplier Category")
                {
                }
               
            }
        }
    }

    trigger OnAfterGetRecord();
    begin 
        if not Vendor.get("Buy-from Vendor No.") then  
            Vendor.init;
        IF "Document No." <> PurchHdr."No." then begin 
            PurchHdr.get("Document Type","Document No.");            
        end;
    end;

    var
        Vendor : Record Vendor;
        PurchHdr : Record "Purchase Header";
        PODate : Date;        
}

