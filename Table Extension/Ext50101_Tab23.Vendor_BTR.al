tableextension 50101 "TabExt50101_Vendor_BTR" extends Vendor
{
    fields
    {
        field(50100; "ICP Code"; Text[10])
        {

        }
        field(50101; "Ship From Port"; Text[10])
        {

        }
        field(50102; "HFM ICP Code"; Text[20])
        {
            TableRelation = "Vendor HFM ICP Codes";
            ValidateTableRelation = true;
        }
        field(50103; "Supplier Category"; Code[20])
        {
            TableRelation = "Supplier Category";
            ValidateTableRelation = true;
        }
        field(50104; "Trade License No."; Text[20])
        {
            trigger OnValidate();
            var
                TradeLicenseUniqueError: TextConst ENU = 'A customer with the same Trade License No. already exists. Please specify a unique Trade License No.';
                Vendor: Record Vendor;
            begin
                IF (UPPERCASE("Trade License No.") <> 'N/A') and (UPPERCASE("Trade License No.") <> 'NA') THEN begin
                    Vendor.reset;
                    Vendor.setrange("Trade License No.", "Trade License No.");
                    if not Vendor.IsEmpty then
                        Error(TradeLicenseUniqueError);
                end;
            end;
        }
        field(50105; "Type"; Option)
        {
            OptionCaption = ',Direct,Indirect';
            OptionMembers = ,Direct,Indirect;
            BlankZero = true;
        }
    }

}