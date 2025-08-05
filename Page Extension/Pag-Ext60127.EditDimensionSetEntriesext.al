pageextension 50002 "Edit Dimension Set Entriesext" extends "Edit Dimension Set Entries"
{
    layout
    {
        modify("Dimension Code")
        {
            trigger OnAfterValidate()
            begin
                Rec."User ID" := UserId;
            end;
        }
        modify(DimensionValueCode)
        {
            Visible = false;
        }

        addafter(DimensionValueCode)
        {
            field("Dimension Value DS"; Rec."Dimension Value DS")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    CurrPage.Update();
                end;
            }

        }
    }
}
