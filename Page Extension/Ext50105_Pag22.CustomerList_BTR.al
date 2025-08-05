pageextension 50105 "PagExt50105_CustomerList_BTR" extends "Customer List"
{
    layout
    {
        addlast(Control1)
        {
            field(Channel; "Customer Channel")
            {

            }
        }
    }
    actions
    {
        addafter("&Customer")
        {
            action(CustomerItem)
            {
                Caption = 'Customer/Item';
                ApplicationArea = All;
                RunObject = report "Assa - Customer/Item Sales";
            }
        }
    }
}