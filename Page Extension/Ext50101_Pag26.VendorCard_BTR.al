pageextension 50101 "PagExt50101_VendorCard_BTR" extends "Vendor Card"
{
    layout
    {
        // Add changes to page layout here
        addlast(General)
        {
            field("ICP Code"; "ICP Code")
            {
                //ApplicationArea = All;
            }
            field("Ship From Port"; "Ship From Port")
            {
                //  ApplicationArea = All;
                Visible = false;
            }
            field("Ship From Port 1"; "Ship From Port1")
            {
                Caption = 'Ship From Port';
            }
            field("HFM ICP Code"; "HFM ICP Code")
            {

            }
            field("Supplier Category"; "Supplier Category")
            {

            }
            field("Trade License No."; "Trade License No.")
            {
                ShowMandatory = true;
            }
            field(Type; Type)
            {

            }
        }
    }


}