table 50001 "User Account_DSS"
{
    Caption = 'User Account';
    // DataClassification = CustomerContent;

    fields
    {
        field(1; "User ID"; Text[50])
        {
            // DataClassification = CustomerContent;
            TableRelation = "User Setup"."User ID";
            Editable = false;
        }
        field(2; "Account Type"; Option)
        {
            OptionMembers = " ","Dimensions","G/L Account","Bank Account","Customer","Vendor";
            Editable = false;
            trigger OnValidate()
            begin
                Clear(Rec."Dimension Code");
                Clear(Rec."Dimension Value");
            end;
        }
        field(3; "Dimension Code"; Code[20])
        {
            // DataClassification = CustomerContent;
            TableRelation = Dimension;
        }
        field(4; "Dimension Value"; Code[20])
        {
            // DataClassification = CustomerContent;
            Caption = 'Dimension Name';
            TableRelation = "Dimension Value".Code where("Dimension Code" = field("Dimension Code"));
        }
    }

    keys
    {
        key(Key1; "Dimension Code", "Dimension Value", "User ID")
        {
            Clustered = true;
        }

    }

    var
        myInt: Record "Gen. Journal Line";

    trigger OnInsert()
    begin
        "User ID" := UserId;
        Rec."Account Type" := Rec."Account Type"::Dimensions;
        if Rec."Dimension Value" = '' then
            Error('Please Put Dimension Value');
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}