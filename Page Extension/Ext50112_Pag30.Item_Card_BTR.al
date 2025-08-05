pageextension 50112 "PagExt50100_ItemCard_BTR" extends "Item Card"
{
    layout
    {
        // Add changes to page layout here
        addlast(Item)
        {
            field("HIP Code";"HIP Code")
            {
                Visible = true;  
                ShowMandatory = true;
                //ApplicationArea = All;
            }
            field("Last Year Purchase Price";"Last Year Purchase Price")
            {                
            }
            field("Sub Category 1";"Sub Category 1")
            {
                Visible = true;  
            }
            field("Sub Category 2";"Sub Category 2")
            {
                Visible = true;  
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}