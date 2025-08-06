pageextension 50107 "Bank Sales Order" extends "Sales Order"
{
    layout
    {
        modify("Sell-to Customer No."){
            trigger OnAfterValidate();
            begin
                "User ID":= UserId;
            end;
        }
        modify("Sell-to Customer Name"){
            trigger OnAfterValidate();
            begin
                "User ID":= UserId;
            end;
        }
        addbefore(Status)
        {
            field("Scope of work"; "Scope of work")
            {
                ApplicationArea = all;

            }
        }

        // Add changes to page layout here
        addfirst("Invoice Details")
        {
            field("Use Bank Account"; "Use Bank Account")
            {
            }
        }
        // addafter("Shortcut Dimension 2 Code")
        // {

        //     field("Shortcut Dimension 2 Code_DSSS"; Rec."Shortcut Dimension 2 Code_DSSS")
        //     {
        //         ApplicationArea = all;
        //         trigger OnValidate()
        //         begin
        //             CurrPage.Update();
        //         end;
        //     }
        // }
         modify("Shortcut Dimension 2 Code")
        {
            Visible = true;
        }

    }
    actions
    {
        modify("Print Confirmation")//@@ha
        {
            trigger OnAfterAction()
            var
                SalesHeader: Record "Sales Header";
                Rpt_PMLWOrderConformation: Report "PM/LW - Order Confirmation";
                Rpt_OrderConfrmation: Report "Order Confirmation";
            begin
                //  DocPrint.PrintSalesOrder(Rec, Usage::"Order Confirmation");
                if (Rec.CurrentCompany = 'UAT-Prometal') OR (Rec.CurrentCompany = 'Assa Abloy') OR (Rec.CurrentCompany = 'UAT-AASS Middle East') OR (Rec.CurrentCompany = 'Assa Abloy') then begin
                    SalesHeader.Reset();
                    SalesHeader.SetRange("No.", Rec."No.");
                    if SalesHeader.FindFirst() then begin
                        Rpt_PMLWOrderConformation.SetTableView(SalesHeader);
                        Rpt_PMLWOrderConformation.Run();
                    end
                end else begin
                    SalesHeader.Reset();
                    SalesHeader.SetRange("No.", Rec."No.");
                    if SalesHeader.FindFirst() then begin
                        Rpt_PMLWOrderConformation.SetTableView(SalesHeader);
                        Rpt_OrderConfrmation.Run();
                    end
                end;
            end;
        }



        // modify("&Order Confirmation")
        // {
        //     // trigger OnAfterAction()
        //     // var
        //     //     myInt: Integer;
        //     // begin

        //     // end;
        // }
    }
    trigger OnAfterGetRecord()
    begin
      //  Rec."Shortcut Dimension 2 Code_DSSS" := Rec."Shortcut Dimension 2 Code";
    end;
    var
        DocPrint: Codeunit 229;
}