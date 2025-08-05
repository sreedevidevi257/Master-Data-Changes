pageextension 50111 "Pag654-Ext50111" extends "Requests to Approve"
{
    layout
    {
        Addafter("Sender ID")
        {
            field("Sender Name";User."Full Name")
            {
                Editable = false;
            }
        }
    }
    
    trigger OnAfterGetRecord();
    begin 
        User.reset;
        User.setrange("User Name","Sender ID");
        IF NOT User.FindFirst THen  
            User.init;
    end;

    var
        SenderName : Text[100];
        User : Record "User";
}