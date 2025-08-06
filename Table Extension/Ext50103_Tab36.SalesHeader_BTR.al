tableextension 50103 "Bank Sales Header" extends "Sales Header"
{
    fields
    {
        // Add changes to table fields here
        field(50100;"Use Bank Account";Text[50])
        {
            TableRelation = "Additional Bank Account"."Bank Name";
        }
        field(50101;"Project Code";Code[20])
        {
            //TableRelation = "Assa - Projects".Code;
        }
        
        field(50102; "Shortcut Dimension 2 Code_DSSS"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "User Account_DSS"."Dimension Value" where("Dimension Code" = const('HFM ENTITY'), "User ID" = field("User ID"), "Dimension Code" = filter(<> ''));
            // trigger OnValidate()
            // begin
                
            //     //Rec.ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code_DSSS");
            //     Rec.Validate("Shortcut Dimension 2 Code",Rec."Shortcut Dimension 2 Code_DSSS");
            //     Rec."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code_DSSS";
                
            // end;
        }

        field(50103; "User ID"; Text[50])
        {
           
        }
       
    }
    trigger OnAfterInsert()
    begin
        "User ID" := UserId;
        Rec.Modify(true);
    end;
}