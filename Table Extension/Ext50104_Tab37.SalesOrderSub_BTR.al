tableextension 50104 Ext50104_SalesOrderSub_BTR extends "Sales Line"
{
    fields
    {
        Modify("No.")
        {
            trigger OnAfterValidate()
            var 
            RecItem: Record Item;
            begin
               If RecItem.get("No.") then
               begin
                   "HIP Code" := RecItem."HIP Code";
                    Brand := RecItem."Service Item Group";
                    Origin := RecItem."Country/Region of Origin Code";
                    "Manufacturer Code" := RecItem."Vendor No.";
                    "HS Code" := recItem."Tariff No.";
               end;
               "User ID":= UserId;
            End;
            
        }
        field(50120;"HIP Code";Code[20])
        {
           
            Editable = False;
            
        }
        field(50121;Brand;Code[10])
        {
            
            Editable = False;
            
        }
        field(50122;Origin;Code[10])
        {
            
            Editable = False;
            
        }
        field(50123;"Manufacturer Code";Code[20])
        {
            
            Editable = False;
            
        }
        field(50124;"HS Code";Code[20])
        {
            
            Editable = False;
            
        }
        field(50125;"Cust. Ref #";Text[20])
        {            
        }

        field(50126; "User ID"; Text[50])
        {
 
        }
        field(50127; "Shortcut Dimension 2 Code_DSSS"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "User Account_DSS"."Dimension Value" where("Dimension Code" = const('HFM ENTITY'), "User ID" =
                                                                       field("User ID"), "Dimension Code" = filter(<> ''));
            trigger OnValidate()
            begin
                Rec.ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code_DSSS");
                Rec."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code_DSSS";
            end;
        }
    }

    keys
    {
        // Add changes to keys here
    }
    trigger OnAfterInsert()
    begin
        "User ID" := UserId;
        Rec.Modify(true);
    end;
                   
}