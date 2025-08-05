tableextension 50001 "Dimension Set Entry" extends "Dimension Set Entry"
{
    fields
    {
        field(60102; "Dimension Value DS"; Code[20])
        {
            TableRelation = if ("Dimension Code" = const('HFM ENTITY')) "User Account_DSS"."Dimension Value" where("Dimension Code" = const('HFM ENTITY'), "User ID" = field("User ID"), "Dimension Code" = filter(<> '')) else
            "Dimension Value".Code where("Dimension Code" = field("Dimension Code"), Blocked = const(false), Blocked = const(false));
            trigger OnValidate()
            begin
                "Dimension Value Code" := "Dimension Value DS";
                if not DimMgt.CheckDimValue("Dimension Code", "Dimension Value Code") then
                    Error(DimMgt.GetDimErr());

                DimVal.Get("Dimension Code", "Dimension Value Code");
                "Dimension Value ID" := DimVal."Dimension Value ID";
            end;
        }
        field(60101; "Shortcut Dimension 2 Code_DSSS"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "User Account_DSS"."Dimension Value" where("Dimension Code" = const('HFM ENTITY'), "User ID" = field("User ID"), "Dimension Code" = filter(<> ''));

        }


        field(60100; "User ID"; Code[50])
        {
            
        }
    }

    trigger OnAfterInsert();
    begin
        Rec."User ID" := UserId;
    end;

    trigger OnAfterModify();
    begin
        Rec."User ID" := UserId;
    end;

    trigger OnAfterRename();
    begin
        Rec."User ID" := UserId;
    end;

    var
        DimVal: Record "Dimension Value";
        DimMgt: Codeunit DimensionManagement;
}
