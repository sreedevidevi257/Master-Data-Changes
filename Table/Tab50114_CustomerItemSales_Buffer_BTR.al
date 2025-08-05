table 50120 "Customer Item Sales Buffer"
{

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            //DataClassification = ToBeClassified;
        }
        field(2; "Customer Name"; Text[50])
        {
            //DataClassification = ToBeClassified;
        }
        field(3; "Production Order No."; Code[20])
        {
            //DataClassification = ToBeClassified;
        }
        field(4; "Item No."; Code[20])
        {
            //DataClassification = ToBeClassified;
        }
        field(5; "Description 1"; Text[50])
        {
            //DataClassification = ToBeClassified;
        }
        field(6; "Description 2"; Text[50])
        {
            //DataClassification = ToBeClassified;
        }
        field(7; "Global Dimension 1 Code"; Code[20])
        {
            //DataClassification = ToBeClassified;
        }
        field(8; "Global Dimension 2 Code"; Code[20])
        {
            //DataClassification = ToBeClassified;
        }
        field(9; "Unit of Measure"; Code[20])
        {
            //DataClassification = ToBeClassified;
        }
        field(10; "Invoiced Quantity"; Decimal)
        {
            //DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(11; "Cost Amount"; Decimal)
        {
            //DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(12; "Discount Amount"; Decimal)
        {
            //DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(13; "Invoiced Amount"; Decimal)
        {
            //DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(14; "Profit Amount"; Decimal)
        {
            //DataClassification = ToBeClassified;
        }
        field(15; "Profit %"; Decimal)
        {
            //DataClassification = ToBeClassified;
        }
        field(16; "Sales Order No."; Code[20])
        {
            //DataClassification = ToBeClassified;
        }
        field(17; "PGR Code"; Code[20])
        {
        }

        field(20; "PGR Code 2"; Code[100])
        {
        }
        field(18; "Sub Category 1"; Code[20])
        {
        }
        field(19; "Sub Category 2"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Customer No.", "Item No.", "Sales Order No.")
        {
        }
    }

    fieldgroups
    {
    }
}

