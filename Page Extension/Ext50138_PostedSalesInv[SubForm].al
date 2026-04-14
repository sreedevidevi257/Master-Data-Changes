pageextension 50141 MyExtension extends "Posted Sales Invoice Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("No.")
        {
            field("Item Category PGR 1";"Item Category PGR 1"){}
            field("Item Category PGR 2";"Item Category PGR 2"){}
            field("Item Category PGR 3";"Item Category PGR 3"){}
            field("Item Category PGR 4";"Item Category PGR 4"){}
        }
    }
    
    actions
    {
        // Add changes to page actions here
    }
    
    var
        myInt: Integer;
}