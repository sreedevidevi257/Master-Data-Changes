pageextension 50102 PagExt50102_CustomerCard_BTR extends "Customer Card"
{
    layout
    {
        // Add changes to page layout here
        addlast(General)
        {
            field(Channel;"Customer Channel")
            {

            }
            field("Trade License No.";"Trade License No.")
            {
                ShowMandatory = true;
            }
        }
    }    
}