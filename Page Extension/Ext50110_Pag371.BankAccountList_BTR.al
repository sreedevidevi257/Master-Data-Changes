pageextension 50110 "Assa Bank Account List" extends "Bank Account List"
{
    actions
    {
        // Add changes to page actions here
        addafter("Bank Account Statements")
        {
            action("Bank Reconciliation Statement")
            {
                Image = Report;
                RunObject = report "Assa Bank Account Statement_";
                ApplicationArea = Suite;
            }
                
        }
    }
    
    var
        myInt : Integer;
}