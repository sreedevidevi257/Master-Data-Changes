pageextension 50133 "Ext50133-SalesOrderList" extends "Sales Order List"
{
    layout
    {
        // Add changes to page layout here
        modify("No.")
        {
            Style=Attention;
            StyleExpr=HighlightText;
        }
        modify("Sell-to Customer No.")
        {
            Style=Attention;
            StyleExpr=HighlightText;
        }
        modify("Sell-to Customer Name")
        {
            Style=Attention;
            StyleExpr=HighlightText;
        }
        modify("External Document No.")
        {
            Style=Attention;
            StyleExpr=HighlightText;
        }
        modify("Location Code")
        {
            Style=Attention;
            StyleExpr=HighlightText;
        }
        modify("Assigned User ID")
        {
            Style=Attention;
            StyleExpr=HighlightText;
        }
        modify("Document Date")
        {
            Style=Attention;
            StyleExpr=HighlightText;
        }
        modify(Status)
        {
            Style=Attention;
            StyleExpr=HighlightText;
        }
    }

    trigger OnAfterGetRecord();
    var 
        SalesLine : Record "Sales Line";
        PurchLine : Record "Purchase Line";
    begin 
        HighlightText := false;
        SalesLine.reset;
        SalesLine.Setrange("Document Type","Document Type");
        SalesLine.Setrange("Document No.","No.");
        SalesLine.Setrange("Drop Shipment",true);
        SalesLine.setfilter("Quantity Invoiced",'=%1',0);
        If SalesLine.FindFirst then begin 
            IF PurchLine.GET(PurchLine."Document Type"::Order,SalesLine."Purchase Order No.",SalesLine."Purch. Order Line No.") THEN BEGIN 
                IF (PurchLine."Outstanding Quantity" = 0) THEN 
                HighlightText := TRUE;
            END;
        end;              
    end;

    var  
        HighlightText : Boolean;
}