pageextension 50132 "Ext50134-Purch Order Subform" extends "Purchase Order Subform"
{
    layout
    {
        addlast(Control1)
        {
            field("Last Year Purchase Price";"Last Year Purchase Price")
            {
                Editable=false;
            }
            field("Last Direct Purchase Price";"Last Direct Purchase Price")
            {
                Editable=false;
            }
            field("Actual Received Date";"Actual Received Date")
            {                
            }
        }

    }
}