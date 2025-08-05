pageextension 50106 Pag46_Ext50106_BTR extends "sales order Subform"
{
    layout
    {
        modify(Type)
        {
            Style = Attention;
            StyleExpr = HighlightText;
        }
        modify("No.")
        {
            Style = Attention;
            StyleExpr = HighlightText;
        }
        modify(Description)
        {
            Style = Attention;
            StyleExpr = HighlightText;
        }

        modify("Location Code")
        {
            Style = Attention;
            StyleExpr = HighlightText;
        }
        modify(Quantity)
        {
            Style = Attention;
            StyleExpr = HighlightText;
        }
        modify("Drop Shipment")
        {
            Style = Attention;
            StyleExpr = HighlightText;
        }
        modify("Purchase Order No.")
        {
            Style = Attention;
            StyleExpr = HighlightText;
        }


        addafter("No.")
        {
            field("HIP Code"; "HIP Code")
            {
                ApplicationArea = All;
                editable = False;
                Style = Attention;
                StyleExpr = HighlightText;
            }
            field(PGR; "item category code")
            {
                editable = False;
                Caption = 'PGR';
                Style = Attention;
                StyleExpr = HighlightText;
            }
            field(Brand; Brand)
            {
                // editable = False;     
                Style = Attention;
                StyleExpr = HighlightText;
            }
            field(" Size"; "Size_")
            {
                //editable = False;
                Style = Attention;
                StyleExpr = HighlightText;
            }
            field("Door  Type/No.1"; "Door  Type/No.")
            {
                //editable = False;  
                Style = Attention;
                StyleExpr = HighlightText;
            }
            field("STC  Rating"; "STC  Rating")
            {
                //editable = False; 
                Style = Attention;
                StyleExpr = HighlightText;
            }
            field("Fire  Rating"; "Fire  Rating")
            {
                //editable = False; 
                Style = Attention;
                StyleExpr = HighlightText;
            }
            field("Cust. Ref #"; "Cust. Ref #")
            {
                Style = Attention;
                StyleExpr = HighlightText;
            }


        }
        addafter("Shortcut Dimension 2 Code"){
            field("Shortcut Dimension 2 Code_DSSS"; Rec."Shortcut Dimension 2 Code_DSSS")
            {
                ApplicationArea = all;
                trigger OnValidate()
                begin
                    CurrPage.update();
                end;
            }
        }
         modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }

    }

    trigger OnAfterGetRecord();
    var
        PurchaseLine: Record "Purchase Line";
    begin
        HighlightText := FALSE;
        IF ("Drop Shipment") AND ("Quantity Invoiced" = 0) THEN BEGIN
            IF PurchaseLine.GET(PurchaseLine."Document Type"::Order, "Purchase Order No.", "Purch. Order Line No.") THEN BEGIN
                IF (PurchaseLine."Outstanding Quantity" = 0) THEN
                    HighlightText := TRUE;
            END;
        END;
          Rec."Shortcut Dimension 2 Code_DSSS" := Rec."Shortcut Dimension 2 Code";
    end;

    var
        HighlightText: Boolean;
}