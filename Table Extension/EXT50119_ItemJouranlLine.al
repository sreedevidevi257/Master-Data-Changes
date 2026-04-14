tableextension 50141 Ext50141_ItemJournalLine_BTR extends "Item Journal Line"
{
    fields
    {
        field(50128;"Item Category PGR 1";Code[50])
        {    
            editable = false;
        }
        field(50129;"Item Category PGR 2";Code[50])
        {
             editable = false;
        }
        field(50130;"Item Category PGR 3";Code[50])
        {
             editable = false;
        }
        field(50131;"Item Category PGR 4";Code[50])
        {
             editable = false;
        }
    }
    
    var
        myInt: Integer;
}